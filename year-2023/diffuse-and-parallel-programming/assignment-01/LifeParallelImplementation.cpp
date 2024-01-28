#include "LifeParallelImplementation.h"
#include "mpi.h"
#include <cstdio>
#include <iostream>
#include <vector>

LifeParallelImplementation::LifeParallelImplementation() {
}

void LifeParallelImplementation::realStep() {
    int currentState, currentPollution;
    std::cout << "Process " << mpiRank << ": startRow = " << startRow << ", endRow = " << endRow << std::endl;
    for (int row = startRow; row < endRow; row++) {
        for (int col = 1; col < size_1; col++) {
            currentState = cells[row][col];
            currentPollution = pollution[row][col];
            cellsNext[row][col] = rules->cellNextState(currentState, liveNeighbours(row, col),
                                                       currentPollution);
            pollutionNext[row][col] =
                    rules->nextPollution(currentState, currentPollution, pollution[row + 1][col] + pollution[row - 1][col] + pollution[row][col - 1] + pollution[row][col + 1],
                                         pollution[row - 1][col - 1] + pollution[row - 1][col + 1] + pollution[row + 1][col - 1] + pollution[row + 1][col + 1]);
        }
    }
    MPI_Barrier(MPI_COMM_WORLD);
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
    MPI_Barrier(MPI_COMM_WORLD);
}

void LifeParallelImplementation::beforeFirstStep() {
    Life::beforeFirstStep();

    MPI_Comm_size(MPI_COMM_WORLD, &mpiSize);
    MPI_Comm_rank(MPI_COMM_WORLD, &mpiRank);

    rowsPerProcess = size / mpiSize;
    remainingRows = size % mpiSize;

    // Calculate the start and end row for each process
    if (mpiRank < remainingRows) {
        startRow = mpiRank * (rowsPerProcess + 1) + 1;
        endRow = startRow + rowsPerProcess; // endRow is exclusive for this process
    } else {
        startRow = remainingRows * (rowsPerProcess + 1) + (mpiRank - remainingRows) * rowsPerProcess + 1;
        endRow = startRow + rowsPerProcess - 1; // Adjust for processes without an extra row
    }

    // Adjust startRow for processes after the first one
    if (mpiRank > 0) {
        startRow--;
    }

    // Adjust endRow for the last process
    if (mpiRank == mpiSize - 1) {
        endRow = size - 1;
    }

    for (int i = 0; i < size; ++i) {
        MPI_Bcast(cells[i], size, MPI_INT, 0, MPI_COMM_WORLD);
        MPI_Bcast(pollution[i], size, MPI_INT, 0, MPI_COMM_WORLD);
    }
}



void LifeParallelImplementation::afterLastStep() {
    if (mpiRank != 0) {
        int actualRowsHandled = endRow - startRow;
        int sendSize = actualRowsHandled * size;
        std::vector<int> sendCells(sendSize);
        std::vector<int> sendPollution(sendSize);
        for (int i = 0; i < actualRowsHandled; ++i) {
            for (int j = 0; j < size; ++j) {
                sendCells[i * size + j] = cells[startRow + i][j];
                sendPollution[i * size + j] = pollution[startRow + i][j];
            }
        }
        MPI_Send(sendCells.data(), sendSize, MPI_INT, 0, 0, MPI_COMM_WORLD);
        MPI_Send(sendPollution.data(), sendSize, MPI_INT, 0, 0, MPI_COMM_WORLD);
    } else {
        for (int i = 1; i < mpiSize; ++i) {
            int actualRowsToReceive = (i < remainingRows) ? rowsPerProcess + 1 : rowsPerProcess;
            int recvSize = actualRowsToReceive * size;

            std::vector<int> recvCells(recvSize);
            std::vector<int> recvPollution(recvSize);

            MPI_Recv(recvCells.data(), recvSize, MPI_INT, i, 0, MPI_COMM_WORLD, MPI_STATUS_IGNORE);
            MPI_Recv(recvPollution.data(), recvSize, MPI_INT, i, 0, MPI_COMM_WORLD, MPI_STATUS_IGNORE);

            int startRowIndex = (i < remainingRows) ? i * (rowsPerProcess + 1) : remainingRows * (rowsPerProcess + 1) + (i - remainingRows) * rowsPerProcess;
            printf("startRowIndex: %d\n", startRowIndex);
            for (int j = 0; j < actualRowsToReceive; ++j) {
                for (int k = 0; k < size; ++k) {
                    cells[startRowIndex + j][k] = recvCells[j * size + k];
                    pollution[startRowIndex + j][k] = recvPollution[j * size + k];
                }
            }
        }
    }
}
