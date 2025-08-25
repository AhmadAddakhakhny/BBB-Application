# WIP;

## Structures
```
project/
├── app/                   # Main program code
├── build/                 # Out build files into out directore
│   └── scripts/           # Scripts for setting project environment variables
├── cmake/                 # User defined cmake includes
├── configured/            # lookup of header file/s to be generated during compilation time.
├── docs/                  # Support Doxygen Documentation
├── external/              # Third party libs. source code
├── lib/                   # Utility lib. for reusable modules that can be used across different parts of your project (i.e. string manipulation, math, file I/O)
├── src/                   # Utility lib. for reusable modules that can be used across different parts of your project focused on how your application behaves (UDS, CAN)
├── tests/                 # Unit test
├── tools/                 # Development tools for development process i.e. linters, and formaters (i.e. LLVM clang flavours)
├── .clang-format          # Clang-format config file
├── .clang-tidy            # Clang-tidy config file
├── .cmake-format.yaml     # cmake-format config file
├── .gitignore             # Execlude dir/files  from beaing tracked
├── CMakeLists.txt         # Central project CMakeLists.txt file
├── LICENSE                # Project LICENSE
├── Makefile               # Build prject using Make rules
```
