cmake_minimum_required(VERSION 3.20.0)

project(
    BBB-APP
    VERSION 1.0.0
    LANGUAGES C CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)
option(BUILD_TESTING OFF "Build unit tests")
set(CMAKE_MODULE_PATH "${PROJECT_SOURCE_DIR}/cmake/")

include(components)     # include all of project SW components

# Build project applications
foreach(sw_component ${COMPONENTS})
    add_subdirectory(${CMAKE_SOURCE_DIR}/src/${sw_component})
endforeach()

# Build project unit tests
if(BUILD_TESTING)
    # 1. Get dependancies Conan’s CMakeDeps
    message(STATUS "Conan running to install project dependancies")
    include(${CMAKE_BINARY_DIR}/external/conan_toolchain.cmake)
    find_package(GTest REQUIRED)
    include(CTest)

    # 2. Build unit tests
    foreach(sw_component ${COMPONENTS})
        add_subdirectory(${CMAKE_SOURCE_DIR}/src/${sw_component}/tests)
    endforeach()
endif()