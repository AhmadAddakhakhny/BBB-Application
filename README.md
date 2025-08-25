# WIP;

## Structures
```
project/
├── build/                 # Central build directory, holds project build configuration, development related scripts and binaries.
│   └── out/               # Project compilation output.
│   └── cmake/             # User defined cmake includes.
│   └── scripts/           # Scripts for setting project environment.
│   └── Makefile           # Build prject using Make rules.
│   └── CMakeLists.txt     # Central project CMakeLists.txt file.
├── src/                   # Central src directory where contain all applications and libs of the project (i.e. LEDController, CAN and libDlt).
│   └── <apps>/               # application sources
|   │   └── test/               # Unit test
|   │   └── docs/               # Support Doxygen Documentation
│   └── <lib*>/               # Utility lib. for reusable modules that can be used across different parts of your project whether first or third party lib.
├── opt/                   # Custom Beaglebone black SDk sysroot for both ARM and x86 as supports Qt6, openssl and etc.
├── tools/                 # Development tools for development process i.e. linters, and formaters (i.e. LLVM clang flavours)
├── LICENSE                # Project LICENSE
├── .clang-format          # Clang-format config file
├── .clang-tidy            # Clang-tidy config file
├── .cmake-format.yaml     # cmake-format config file
├── .gitignore             # Execlude dir/files  from beaing tracked
```
