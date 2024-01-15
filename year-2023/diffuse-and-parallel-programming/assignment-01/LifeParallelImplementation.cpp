#include "LifeParallelImplementation.h"
#include "stdio.h"
#include <iostream>
#include <math.h>
#include <mpi.h>
#include <unistd.h>

LifeParallelImplementation::LifeParallelImplementation() = default;

void LifeParallelImplementation::beforeFirstStep() {
    Life::beforeFirstStep();

    MPI_Comm_rank(MPI_COMM_WORLD, &mpi_rank);
    MPI_Comm_size(MPI_COMM_WORLD, &mpi_size);

    rows_per_process = size_1 / mpi_size;
    int remaining_rows = size_1 % mpi_size;

    if (mpi_rank < remaining_rows) {
        start_row = mpi_rank * (rows_per_process + 1) + 1;
        end_row = start_row + rows_per_process;
    } else {
        start_row = mpi_rank * rows_per_process + remaining_rows + 1;
        end_row = start_row + rows_per_process - 1;
    }

    MPI_Type_contiguous(size_1, MPI_INT, &row_type);
    MPI_Type_commit(&row_type);
}

void LifeParallelImplementation::exchangeBorderCells() {
    MPI_Status status;
    int next_rank = (mpi_rank + 1) % mpi_size;
    int prev_rank = mpi_rank == 0 ? mpi_size - 1 : mpi_rank - 1;

    MPI_Sendrecv(cells[end_row - 1], size_1, MPI_INT, next_rank, 0,
                 cells[end_row], size_1, MPI_INT, prev_rank, 0,
                 MPI_COMM_WORLD, &status);

    MPI_Sendrecv(cells[start_row], size_1, MPI_INT, prev_rank, 1,
                 cells[start_row - 1], size_1, MPI_INT, next_rank, 1,
                 MPI_COMM_WORLD, &status);

    MPI_Sendrecv(pollution[end_row - 1], size_1, MPI_INT, next_rank, 2,
                 pollution[end_row], size_1, MPI_INT, prev_rank, 2,
                 MPI_COMM_WORLD, &status);

    MPI_Sendrecv(pollution[start_row], size_1, MPI_INT, prev_rank, 3,
                 pollution[start_row - 1], size_1, MPI_INT, next_rank, 3,
                 MPI_COMM_WORLD, &status);
}




void LifeParallelImplementation::realStep() {
    exchangeBorderCells();
    compute();
}

void LifeParallelImplementation::compute() {
    int currentState, currentPollution;
    printf("%d: %d-%d\n", mpi_rank, start_row, end_row);
    for (int row = start_row; row < end_row; ++row) {
        for (int col = 1; col < size_1 - 1; ++col) {
            currentState = cells[row][col];
            currentPollution = pollution[row][col];
            cellsNext[row][col] = rules->cellNextState(currentState, liveNeighbours(row, col), currentPollution);
            pollutionNext[row][col] = rules->nextPollution(currentState, currentPollution,
                                                           pollution[row + 1][col] + pollution[row - 1][col] + pollution[row][col - 1] + pollution[row][col + 1],
                                                           pollution[row - 1][col - 1] + pollution[row - 1][col + 1] + pollution[row + 1][col - 1] + pollution[row + 1][col + 1]);
        }
    }
}


void LifeParallelImplementation::oneStep() {
    realStep();
    swapTables();
}

int LifeParallelImplementation::numberOfLivingCells() {
    return sumTable(cells);
}

double LifeParallelImplementation::averagePollution() {
    return (double) sumTable(pollution) / size_1_squared / rules->getMaxPollution();
}