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
    int currentState, currentPollution;
    for (int row = startRow + 1; row < endRow - 1; row++) {
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
}

void LifeParallelImplementation::beforeFirstStep() {
    Life::beforeFirstStep();

    int chunk_size = size / mpiSize;

    startRow = mpiRank * chunk_size;
    endRow = (mpiRank + 1) * chunk_size - 1;

    printf("%d: %d-%d\n", mpiRank, startRow, endRow);

    for (int row = 0; row < size; row++) {
        MPI_Bcast(cells[row], size, MPI_INT, 0, MPI_COMM_WORLD);
        MPI_Bcast(pollution[row], size, MPI_INT, 0, MPI_COMM_WORLD);
    }
}

void LifeParallelImplementation::afterLastStep() {
    Life::afterLastStep();
    for (int col = 0; col < size; col++) {
        if (!mpiRank) {
            MPI_Send(cells[col], size, MPI_INT, 1, 0, MPI_COMM_WORLD);
            MPI_Send(pollution[col], size, MPI_INT, 1, 0, MPI_COMM_WORLD);
        } else {
            MPI_Recv(cells[col], size, MPI_INT, 0, 0, MPI_COMM_WORLD, status);
            MPI_Recv(pollution[col], size, MPI_INT, 0, 0, MPI_COMM_WORLD, status);
        }
    }
}
