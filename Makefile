.PHONY: host arm help clean

all:host

host:prep_host_dep
	cmake --preset x86-linux-gcc-debug
	cmake --build --preset x86-linux-gcc-debug -j
	./builds/x86-debug/src/LEDController/LEDController

arm:
	cmake --preset arm-linux-gcc-release
	cmake --build --preset arm-linux-gcc-release -j

prep_host_dep:
	mkdir -p builds/x86-debug/external
	cd builds/x86-debug/external && conan install ../../../tools -s build_type=Debug --output-folder=. --build missing -s compiler.cppstd=17

help:
	@echo "Available targets are:"
	@echo "make host  - x86-linux-gcc-debug"
	@echo "make arm   - arm-linux-gcc-release"
	@echo "make clean - remove all builds/install dirs"

clean:
	rm -rf builds install