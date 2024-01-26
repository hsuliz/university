#ifndef LIFE_PARALLEL_IMPLEMENTATION_H
#define LIFE_PARALLEL_IMPLEMENTATION_H

#include "Life.h"
#include <mpi.h>

class LifeParallelImplementation : public Life {
private:
    MPI_Status *status{};
    int mpiSize{}, mpiRank{};
    int startRow{}, endRow{};

protected:
    void realStep() override;

public:
    LifeParallelImplementation();
    int numberOfLivingCells() override;
    double averagePollution() override;
    void oneStep() override;
    void beforeFirstStep() override;
    void afterLastStep() override;
};

#endif
