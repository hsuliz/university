cmake_minimum_required(VERSION 3.26)
project(assignment_01)

set(CMAKE_CXX_STANDARD 11)

find_package(MPI REQUIRED)

add_executable(assignment_01 main.cpp
        Main.cpp
        Alloc.cpp
        LifeSequentialImplementation.cpp
        Rules.cpp
        SimpleRules.cpp
        Main.cpp
        LifeParallelImplementation.cpp
        LifeParallelImplementation.h
        Main.cpp
        Main.cpp)

target_link_libraries(assignment_01 PRIVATE MPI::MPI_CXX)
