#include "LifeParallelImplementation.h"
#include "mpi.h"
#include <vector>

LifeParallelImplementation::LifeParallelImplementation() {
    MPI_Comm_size(MPI_COMM_WORLD, &mpiSize);
    MPI_Comm_rank(MPI_COMM_WORLD, &mpiRank);
    status = new MPI_Status();
}

int LifeParallelImplementation::numberOfLivingCells() {
    return sumTable(cells);
}

double LifeParallelImplementation::averagePollution() {
    return (double) sumTable(pollution) / size_1_squared / rules->getMaxPollution();
}

void LifeParallelImplementation::oneStep() {
    realStep();
    swapTables();
}

void LifeParallelImplementation::realStep() {
    int startRow, endRow;

    int rowsPerProcess = size_1 - 1 / mpiSize;

    if (mpiRank == 0) {
        startRow = 1;
        endRow = rowsPerProcess;
    } else {
        startRow = mpiRank * rowsPerProcess;
        endRow = (mpiRank + 1) * rowsPerProcess;

        if (mpiRank == mpiSize - 1) {
            endRow = size_1;
        }
    }
    this->compute(startRow, endRow);
}

void LifeParallelImplementation::compute(int startRow, int endRow) {
    int currentState, currentPollution;

    MPI_Datatype rowType;
    MPI_Type_contiguous(size_1, MPI_INT, &rowType);
    MPI_Type_commit(&rowType);

    int prevRank = mpiRank - 1;
    int nextRank = mpiRank + 1;

    int *sendBuffer = new int[size_1];
    int *recvBuffer = new int[size_1];

    if (mpiRank > 0) {
        memcpy(sendBuffer, cells[startRow], size_1 * sizeof(int));
        MPI_Recv(recvBuffer, 1, rowType, prevRank, 0, MPI_COMM_WORLD, status);
        MPI_Send(sendBuffer, 1, rowType, prevRank, 0, MPI_COMM_WORLD);
        memcpy(cells[startRow - 1], recvBuffer, size_1 * sizeof(int));
    }

    if (mpiRank < mpiSize - 1) {
        memcpy(sendBuffer, cells[endRow - 1], size_1 * sizeof(int));
        MPI_Send(sendBuffer, 1, rowType, nextRank, 0, MPI_COMM_WORLD);
        MPI_Recv(recvBuffer, 1, rowType, nextRank, 0, MPI_COMM_WORLD, status);
        memcpy(cells[endRow], recvBuffer, size_1 * sizeof(int));
    }

    for (int row = startRow; row < endRow; row++) {
        for (int col = 1; col < size_1; col++) {
            currentState = cells[row][col];
            currentPollution = pollution[row][col];
            cellsNext[row][col] = rules->cellNextState(currentState, liveNeighbours(row, col), currentPollution);
            pollutionNext[row][col] =
                    rules->nextPollution(currentState, currentPollution,
                                         pollution[row + 1][col] + pollution[row - 1][col] + pollution[row][col - 1] + pollution[row][col + 1],
                                         pollution[row - 1][col - 1] + pollution[row - 1][col + 1] + pollution[row + 1][col - 1] + pollution[row + 1][col + 1]);
        }
    }

    delete[] sendBuffer;
    delete[] recvBuffer;
    MPI_Type_free(&rowType);
}