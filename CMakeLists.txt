cmake_minimum_required (VERSION 3.20.0)

project (
    BBB-APP
    VERSION 1.0.0
    LANGUAGES C CXX)


set (CMAKE_CXX_STANDARD 17)
set (CMAKE_CXX_STANDARD_REQUIRED ON)
set (CMAKE_CXX_EXTENSIONS OFF)
set (CMAKE_EXPORT_COMPILE_COMMANDS ON)
set (CMAKE_MODULE_PATH "${PROJECT_SOURCE_DIR}/cmake/")  # Add cmake modules PATH
set(BUILD_COMPONENT "" CACHE STRING "Name of a single component to build (optional)")
# A small helper variable to locate systemd unit dir on target/sysroot
# Yocto typically maps this to ${CMAKE_INSTALL_PREFIX}/lib/systemd/system
if (NOT DEFINED CMAKE_INSTALL_SYSTEMD_UNITDIR)
  set(CMAKE_INSTALL_SYSTEMD_UNITDIR "${CMAKE_INSTALL_LIBDIR}/systemd/system")
endif()


option (WARNINGS_DISABLED OFF "Disable Compiler Warnings")
option (BUILD_SOURCES OFF "Build application components")
option (BUILD_TESTING OFF "Build application components unit tests")
option (ADDRESS_SANITIZER_ENABLED OFF "Build with sanitizer")
option (LTO_ENABLED ON "Enable LTO support")
option (CLANG_TIDY_ENABLED OFF "Enable clang-tidy support")
option (FORMAT_ENABLED OFF "Format project sources and scripts")
option (BUILD_FOR_YOCTO OFF "Set when building under Yocto (disables tests, sanitizers by default)")


include (tools) # clang-tidy, clang-format and cmake-format
include (components) # include all of project SW components
include (GNUInstallDirs) # Install dir helpers
include (execBashCommand)

# Config address sanitizer
if (ADDRESS_SANITIZER_ENABLED)
    message (STATUS "Address sanitizer activated")
    include (sanitizer)
    add_sanitizer_flags ()
endif ()

# Format all project sources
if (FORMAT_ENABLED)
    # format prject cmake scripts
    add_cmake_format_target ()
    # format tracked files only operates with git repos
    add_clang_format_diff_target ()
    # format all project sources - AGGRESSIVE!!!
    # add_clang_format_target ()
endif ()

# Depict the sw components to be built
if(BUILD_COMPONENT)
    if(NOT BUILD_COMPONENT IN_LIST AVAILABLE_COMPONENTS)
        message(FATAL_ERROR "Component '${BUILD_COMPONENT}' not found. Available: ${AVAILABLE_COMPONENTS}")
    endif()
    set(TARGET_COMPONENTS ${BUILD_COMPONENT})
    message(STATUS "Building only component: ${BUILD_COMPONENT}")
else()
    set(TARGET_COMPONENTS ${AVAILABLE_COMPONENTS})
    message(STATUS "Building all components: ${TARGET_COMPONENTS}")
endif()

# Build project applications
if(BUILD_SOURCES)
    foreach (sw_component ${TARGET_COMPONENTS})
        add_subdirectory (${CMAKE_SOURCE_DIR}/src/${sw_component} ${CMAKE_BINARY_DIR}/${sw_component})
    endforeach ()
endif()

# Build project unit tests
if (BUILD_TESTING)
    # 1. Get dependancies Conan’s CMakeDeps
    message (STATUS "Conan running to install project dependancies")
    include (${CMAKE_SOURCE_DIR}/external/conan_toolchain.cmake)
    find_package (GTest REQUIRED)
    include (CTest)

    # 2. setup code coverage
    include (codeCoverage)
    append_coverage_compiler_flags ()

    # 3. Build unit tests
    foreach (sw_component ${TARGET_COMPONENTS})
        set(TEST_DIR "${CMAKE_SOURCE_DIR}/src/${sw_component}/tests")
        if (EXISTS "${TEST_DIR}/CMakeLists.txt")
            add_subdirectory (${TEST_DIR} ${CMAKE_BINARY_DIR}/${sw_component}_tests)
        endif ()
    endforeach ()
endif ()