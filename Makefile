.PHONY: host arm help clean

all:host

host:
	cmake --preset x86-linux-gcc-debug
	cmake --build --preset x86-linux-gcc-debug -j

arm:
	cmake --preset arm-linux-gcc-release
	cmake --build --preset arm-linux-gcc-release -j

help:
	@echo "Available targets are:"
	@echo "make host  - x86-linux-gcc-debug"
	@echo "make arm   - arm-linux-gcc-release"
	@echo "make clean - remove all builds/install dirs"

clean:
	rm -rf builds install