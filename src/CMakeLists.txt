cmake_minimum_required(VERSION 3.8)
project(src)

set(CMAKE_CXX_STANDARD 11)

set(SOURCE_FILES main.cpp calculate_genome_similarities.cpp)
add_executable(src ${SOURCE_FILES} calculate_genome_similarit.cpp)