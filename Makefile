.PHONY: host arm test lint help clean

all: host

host:
	cmake --preset x86-linux-gcc-debug
	cmake --build --preset x86-linux-gcc-debug -j
	./builds/x86-debug/src/LEDController/LEDController

arm:
	cmake --preset arm-linux-gcc-release
	cmake --build --preset arm-linux-gcc-release -j

test:
	mkdir -p builds/x86-tests/external
	cd builds/x86-tests/external && conan install ../../../tools -s build_type=Debug --output-folder=. --build missing -s compiler.cppstd=17
	cmake --preset x86-linux-gcc-tests
	cmake --build --preset x86-linux-gcc-tests -j
	ctest --preset=x86-linux-gcc-tests

lint:
	cmake --preset x86-linux-gcc-debug-nolto
	cmake --build --preset lint
	@echo "################## Lintting Done."

help:
	@echo "Available targets are:"
	@echo "make host  - x86-linux-gcc-debug"
	@echo "make arm   - arm-linux-gcc-release"
	@echo "make clean - remove all builds/install dirs"

clean:
	rm -rf builds install