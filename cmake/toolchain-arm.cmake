# Define system and compiler
set(CMAKE_SYSTEM_NAME Linux)
set(CMAKE_SYSTEM_PROCESSOR arm)

# Path to your SDK environment
set(SDK_SYSROOT "${CMAKE_CURRENT_LIST_DIR}/..//sdk/sysroots/armv7at2hf-neon-poky-linux-gnueabi")
message(STATUS "Using SYSROOT: ${CMAKE_SYSROOT}")

set(SDK_BINDIR   "${CMAKE_SOURCE_DIR}/sdk/sysroots/x86_64-pokysdk-linux/usr/bin/arm-poky-linux-gnueabi")
set(CMAKE_SYSROOT "${SDK_SYSROOT}" CACHE PATH "Sysroot path" FORCE)

# Define compilers as absolute paths
set(CMAKE_C_COMPILER   "${SDK_BINDIR}/arm-poky-linux-gnueabi-gcc")
set(CMAKE_CXX_COMPILER "${SDK_BINDIR}/arm-poky-linux-gnueabi-g++")
set(CMAKE_SYSROOT      "${SDK_SYSROOT}")

# --------------------------
# ARM hard-float compile flags
# --------------------------
set(ARM_FLAGS "-march=armv7-a -mthumb -mfpu=neon -mfloat-abi=hard")

# Force these flags to apply *before* compiler detection
set(CMAKE_C_FLAGS   "${ARM_FLAGS} ${CMAKE_C_FLAGS}" CACHE STRING "" FORCE)
set(CMAKE_CXX_FLAGS "${ARM_FLAGS} ${CMAKE_CXX_FLAGS}" CACHE STRING "" FORCE)

# Optional: ensure the linker uses same ABI
set(CMAKE_EXE_LINKER_FLAGS "${ARM_FLAGS} ${CMAKE_EXE_LINKER_FLAGS}" CACHE STRING "" FORCE)

# Optional: toolchain behavior
set(CMAKE_FIND_ROOT_PATH "${SDK_SYSROOT}")
set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_PACKAGE ONLY)
