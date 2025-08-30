cmake_minimum_required(VERSION 3.20.0)

project(
    BBB-APP
    VERSION 1.0.0
    LANGUAGES C CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)
set(CMAKE_MODULE_PATH "${PROJECT_SOURCE_DIR}/cmake/")

include(components)     # inlude all of the project SW components

foreach(sw_component ${COMPONENTS})
    add_subdirectory(${CMAKE_SOURCE_DIR}/src/${sw_component})
endforeach()