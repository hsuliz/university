cmake_minimum_required(VERSION 3.26)
project(assignment_01)

set(CMAKE_CXX_STANDARD 11)

find_package(MPI REQUIRED)

add_executable(assignment_01
        Main.cpp
        Rules.cpp
        Rules.h
        Alloc.cpp
        SimpleRules.cpp
        SimpleRules.h
        LifeParallelImplementation.cpp
        LifeParallelImplementation.h
        LifeSequentialImplementation.cpp
        LifeSequentialImplementation.h
        Life.cpp
        Life.h
)

target_link_libraries(assignment_01 PRIVATE MPI::MPI_CXX)
