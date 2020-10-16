cmake_minimum_required(VERSION 3.17)
project(RPCalc C)

set(CMAKE_C_STANDARD 99)

add_executable(RPCalc sources/main.c sources/stack.c include/stack.h)