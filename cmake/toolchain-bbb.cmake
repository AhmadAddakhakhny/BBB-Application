# --- Target platform ---
set(CMAKE_SYSTEM_NAME Linux)              # we're building for Linux
set(CMAKE_SYSTEM_PROCESSOR arm)           # generic 'arm' is fine; CMake doesn't parse 'armv7' specially

# --- Triplet & sysroot (adjust paths to your SDK/sysroot) ---
set(BBB_TRIPLET arm-linux-gnueabihf)
# Example sysroot path: could be an extracted SDK or a rootfs copy from the device
set(BBB_SYSROOT "/opt/bbb/sysroot")       # <<< CHANGE THIS >>>

# Tell CMake we are cross-compiling against this root
set(CMAKE_SYSROOT "${BBB_SYSROOT}")

# --- Compilers (from your cross toolchain) ---
set(CMAKE_C_COMPILER   "${BBB_TRIPLET}-gcc")
set(CMAKE_CXX_COMPILER "${BBB_TRIPLET}-g++")
set(CMAKE_ASM_COMPILER "${BBB_TRIPLET}-gcc")

# Optional: explicitly set compiler target
set(CMAKE_C_COMPILER_TARGET   "${BBB_TRIPLET}")
set(CMAKE_CXX_COMPILER_TARGET "${BBB_TRIPLET}")

# --- CPU/ABI tuning for BeagleBone Black (AM335x, Cortex-A8, NEON, hard-float) ---
set(ARM_FLAGS "-march=armv7-a -mcpu=cortex-a8 -mfpu=neon -mfloat-abi=hard -mthumb")
set(CMAKE_C_FLAGS_INIT   "${ARM_FLAGS}")
set(CMAKE_CXX_FLAGS_INIT "${ARM_FLAGS}")

# Ensure linkers use the sysroot
set(CMAKE_EXE_LINKER_FLAGS_INIT    "--sysroot=${CMAKE_SYSROOT}")
set(CMAKE_SHARED_LINKER_FLAGS_INIT "--sysroot=${CMAKE_SYSROOT}")

# --- Make find_* and find_package search the sysroot, not the host ---
set(CMAKE_FIND_ROOT_PATH "${CMAKE_SYSROOT}")
set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)  # never take programs from sysroot
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)   # libraries only in sysroot
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)   # includes only in sysroot
set(CMAKE_FIND_ROOT_PATH_MODE_PACKAGE ONLY)   # packages only in sysroot

# --- pkg-config for cross builds ---
# Clear the host cache, point into the sysroot
set(ENV{PKG_CONFIG_DIR} "")
set(ENV{PKG_CONFIG_SYSROOT_DIR} "${CMAKE_SYSROOT}")
# Typical Debian-like layout for ARM hard-float:
set(ENV{PKG_CONFIG_LIBDIR}
    "${CMAKE_SYSROOT}/usr/lib/${BBB_TRIPLET}/pkgconfig:"
    "${CMAKE_SYSROOT}/usr/lib/pkgconfig:"
    "${CMAKE_SYSROOT}/usr/share/pkgconfig")

# --- (Optional) where 'make install' should stage ---
# set(CMAKE_STAGING_PREFIX "${CMAKE_BINARY_DIR}/staging")

# --- (Optional) integrate with Conan toolchain if you use Conan v2 profiles ---
# If your preset provides CONAN_TOOLCHAIN_FILE, include it so compiler flags/defs from Conan are applied too.
# if(DEFINED CONAN_TOOLCHAIN_FILE AND EXISTS "${CONAN_TOOLCHAIN_FILE}")
#   include("${CONAN_TOOLCHAIN_FILE}")
# endif()
