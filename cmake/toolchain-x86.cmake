# ====================================================================================
# Toolchain for x86_64 (native SDK)
# ====================================================================================

# Detect path of this toolchain file (so it works from anywhere)
set(SDK_BASE_DIR "${CMAKE_CURRENT_LIST_DIR}/../sdk/sysroots")

# SDK sysroot (x86)
set(CMAKE_SYSROOT "${SDK_BASE_DIR}/x86_64-pokysdk-linux")

# Compiler binaries (from the SDK)
set(CMAKE_C_COMPILER   "${CMAKE_SYSROOT}/usr/bin/x86_64-poky-linux/x86_64-poky-linux-gcc")
set(CMAKE_CXX_COMPILER "${CMAKE_SYSROOT}/usr/bin/x86_64-poky-linux/x86_64-poky-linux-g++")

# Target triple
set(CMAKE_SYSTEM_NAME Linux)
set(CMAKE_SYSTEM_PROCESSOR x86_64)

# Tell CMake to use the sysroot
set(CMAKE_FIND_ROOT_PATH "${CMAKE_SYSROOT}")

# Search settings (use SDK headers/libraries first)
set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_PACKAGE ONLY)

# Common build flags (optional)
set(CMAKE_C_FLAGS   "-O2 -pipe -g -feliminate-unused-debug-types --sysroot=${CMAKE_SYSROOT}" CACHE STRING "" FORCE)
set(CMAKE_CXX_FLAGS "-O2 -pipe -g -feliminate-unused-debug-types --sysroot=${CMAKE_SYSROOT}" CACHE STRING "" FORCE)

message(STATUS "Using x86 SDK toolchain at: ${CMAKE_SYSROOT}")
