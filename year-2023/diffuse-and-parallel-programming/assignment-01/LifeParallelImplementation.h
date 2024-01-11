#ifndef ASSIGNMENT_01_LIFEPARALLELIMPLEMENTATION_H
#define ASSIGNMENT_01_LIFEPARALLELIMPLEMENTATION_H


#include "Life.h"
class LifeParallelImplementation : public Life {
protected:
    void realStep() override;

public:
    LifeParallelImplementation();
    int numberOfLivingCells() override;
    double averagePollution() override;
    void oneStep() override;
};


#endif//ASSIGNMENT_01_LIFEPARALLELIMPLEMENTATION_H
