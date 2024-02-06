#ifndef ASSIGNMENT_01_LIFEPARALLELIMPLEMENTATION_H
#define ASSIGNMENT_01_LIFEPARALLELIMPLEMENTATION_H

#include "Life.h"
#include <vector>

class LifeParallelImplementation : public Life {
private:
    int mpiRank, mpiSize;
    int startRow, endRow;
    int rowsPerProcess, remainingRows;
    void sendRow(int destination, int row);
    void receiveRow(int source, int row);

protected:
    void realStep();

public:
    LifeParallelImplementation();
    int numberOfLivingCells();
    double averagePollution();
    void oneStep();
    void beforeFirstStep();
    void afterLastStep();
};

#endif
