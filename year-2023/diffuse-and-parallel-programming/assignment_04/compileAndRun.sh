#!/bin/bash

g++-13 -fopenmp -O2 DataSupplier.cpp Force.cpp main.cpp MyForce.cpp SimpleDataSupplier.cpp Simulation.cpp && time ./a.out
