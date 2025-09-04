# Beaglebone Black Application Development
![Image](https://github.com/user-attachments/assets/2b35cdc0-944a-430f-bb16-1d9e4b85039c)
This is a Qt/C++ CMake-based platform for developing applications on the BeagleBone Black. What you get is:
* Custom beaglebone black SDK supports Qt6
* Configure U-Boot and support secure U-Boot
* Deploy OP-TEE for key management
* LEDController Software component to control whether user LEDs or External LEDs
* Porting DLTviewer Software component to enable debugging by using Logs
* Utilize Unit testing using gtest and gmock
* Use of modern CMake for building and compiling
* Code documentation with Doxygen
* External libraries installed and managed by (CPM package manager)
* Tooling: Clang-Format, Clang-format-diff, Cmake-format, Clang-tidy, Sanitizers

## Clone
```bash
git@github.com:AhmadAddakhakhny/BBB-Application.git
https://github.com/AhmadAddakhakhny/BBB-Application.git
```

## Software Requirements
* CMake 3.21+
* GNU Makefile
* Doxygen
* CPM
* G++9 (or higher), Clang++9 (or higher)
* Code Coverage (only on GNU|Clang): gcovr
* Doxygen
* clang-tidy
* clang-format
* python3

## Project Layout
```
BBB-Application/
├── src/                   # Central src directory where contain all applications and libs of the project (i.e. LEDController, CAN and libDlt).
    └── <apps>/               # application sources.
        └── app/                # Application sources.
        └── test/               # Application unit-test.
        └── configured/         # lookup of header file/s to be generated during compilation time.
        └── docs/               # Support Doxygen Documentation (ignored by git).
    └── <lib*>/               # Utility lib. for reusable modules that can be used across different parts of your project whether first or third party lib.
├── sdk/                   # Custom Beaglebone black SDk sysroot for both ARM and x86 as supports Qt6, openssl and etc.
├── cmake/                 # User defined cmake includes.
│   scripts/               # Scripts for setting project environment.
├── tools/                 # Development tools for development process i.e. linters, and formaters (i.e. LLVM clang flavours).
    └── conanfile.py          # Contains all packages that have to be installed and be consumed by this project via conan package manager.
├── builds/                # OUT-OF-SOURCE build trees (ignored by git).
├── install/               # Installed Project compilation output (ignored by git).
├── CMakeLists.txt         # Central project CMakeLists.txt file.
├── CMakePresets.json      # Defines reusable build configurations (presets) so you can build and cross-compile the project with simple cmake --preset <name> commands
├── Makefile               # Wrapper rules for CMakePresets.
├── .gitignore             # Execlude dir/files  from beaing tracked.
├── .clang-tidy            # Clang-tidy config file.
├── .clang-format          # Clang-format config file.
├── .cmake-format.yaml     # cmake-format config file.
├── LICENSE                # Project LICENSE.
```

