#ifndef LIFE_PARALLEL_IMPLEMENTATION_H
#define LIFE_PARALLEL_IMPLEMENTATION_H

#include "Life.h"
#include <mpi.h>

class LifeParallelImplementation : public Life {
private:
    MPI_Datatype row_type{};
    int mpi_rank{};        // MPI rank of the process
    int mpi_size{};        // Total number of MPI processes
    int rows_per_process{};// Number of rows per process
    int start_row{};       // Starting row for this process
    int end_row{};         // Ending row for this process
    void compute();
    void exchangeBorderCells();

protected:
    void realStep() override;

public:
    LifeParallelImplementation();
    int numberOfLivingCells() override;
    double averagePollution() override;
    void oneStep() override;
    void beforeFirstStep() override;
};

#endif
