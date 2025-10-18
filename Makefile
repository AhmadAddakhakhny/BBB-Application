# ==========================
# Top-level Makefile
# ==========================

# include
include cmake/components.min

# Default architecture
ARCH ?= x86
# Default to build all components if COMPONENT is not specified
COMPONENT ?= all
# Project build type
BUILD-TYPE ?= debug


# Depict build target based upon ARCH, BUILD-TYPE and TEST to CMake preset
ifeq ($(filter test,$(MAKECMDGOALS)),test)	# Detect if running tests
    TEST_MODE := 1
else
    TEST_MODE := 0
endif

ifeq ($(ARCH),arm)
	ifeq ($(BUILD-TYPE),debug)
    	PRESET := arm-linux-gcc-debug
	else ifeq ($(ARCH),x86)
		PRESET := arm-linux-gcc-release
	else
		$(error Unsupported BUILD-TYPE=$(BUILD-TYPE). Use debug or release!)
	endif
else ifeq ($(ARCH),x86)
	ifeq ($(BUILD-TYPE),debug)
		ifeq ($(TEST_MODE),1)
			PRESET := x86-linux-gcc-debug-tests
		else
    		PRESET := x86-linux-gcc-debug
		endif
	else
		$(error Unsupported BUILD-TYPE=$(BUILD-TYPE). Use debug!)
	endif
else
    $(error Unsupported ARCH=$(ARCH). Use arm or x86)
endif

# Root of the project
SRC_DIR := $(CURDIR)
BUILD_DIR := $(SRC_DIR)/builds/$(ARCH)/debug
INSTALL_DIR := $(SRC_DIR)/install
INSTALL_PREFIX := $(INSTALL_DIR)/$(ARCH)/debug
CONAN_DIR := $(SRC_DIR)/external

# Function to compute the build directory for a component
define build_subdir
$(if $(filter 1,$(TEST_MODE)),$(BUILD_DIR)/tests/$1,$(BUILD_DIR)/$1)
endef

# ==========================
# Default target
# ==========================
.PHONY: all
all: configure build

# ==========================
# Configure target
# ==========================
.PHONY: configure
configure:
ifeq ($(COMPONENT),all)
	@echo "=== Configuring all components ($(ARCH)) ==="
	@for c in $(AVAILABLE_COMPONENTS); do \
	    mkdir -p $(call build_subdir,$$c); \
	    cmake --preset $(PRESET) -DBUILD_COMPONENT=$$c -B $(call build_subdir,$$c); \
	done
else
# @TBD: Validate the component first
	@echo "=== Configuring component $(COMPONENT) ($(ARCH)) ==="
	@mkdir -p $(call build_subdir,$(COMPONENT))
	@cmake --preset $(PRESET) -DBUILD_COMPONENT=$(COMPONENT) -B $(call build_subdir,$(COMPONENT))
endif

# ==========================
# Build target
# ==========================
.PHONY: build
build:
ifeq ($(COMPONENT),all)
	@echo "=== Building all components ($(ARCH)) ==="
	@for c in $(AVAILABLE_COMPONENTS); do \
	    echo ">>> Building $$c"; \
	    if [ "$(TEST_MODE)" = "1" ]; then \
	        cmake --build $(call build_subdir,$$c); \
	    else \
	        cmake --build $(call build_subdir,$$c) --target $$c; \
	        cmake --install $(call build_subdir,$$c) --prefix $(INSTALL_PREFIX); \
	    fi; \
	done
else
	@echo "=== Building component $(COMPONENT) ($(ARCH)) ==="
	@if [ "$(TEST_MODE)" = "1" ]; then \
	    cmake --build $(call build_subdir,$(COMPONENT)); \
	else \
	    cmake --build $(call build_subdir,$(COMPONENT)) --target $(COMPONENT); \
	    cmake --install $(call build_subdir,$(COMPONENT)) --prefix $(INSTALL_PREFIX); \
	fi
endif

# ==========================
# Unit tests
# ==========================
.PHONY: test
test: prep-test-dependency configure build run-tests

.PHONY: prep-test-dependency
prep-test-dependency:
	@mkdir -p $(CONAN_DIR)
	@cd $(CONAN_DIR) && conan install ../tools -s build_type=Debug --output-folder=. --build missing -s compiler.cppstd=17

.PHONY: run-tests
run-tests:
ifeq ($(COMPONENT),all)
	@echo "=== Running tests for all components ($(ARCH)) ==="
	@for c in $(AVAILABLE_COMPONENTS); do \
	    cd $(call build_subdir,$$c) && ctest --output-on-failure; \
	done
else
	@echo "=== Running tests for component $(COMPONENT) ($(ARCH)) ==="
	@cd $(call build_subdir,$(COMPONENT)) && ctest --output-on-failure
endif

# ==========================
# Clean
# ==========================
.PHONY: clean
clean:
ifeq ($(COMPONENT),all)
	@echo "=== Cleaning all build directories ==="
	@rm -rf $(SRC_DIR)/builds/*
	@rm -rf $(INSTALL_DIR)/*
else
# @TBD: Validate the component first
	@echo "=== Cleaning build directory for component $(COMPONENT) ==="
	@rm -rf $(BUILD_DIR)/$(COMPONENT)
	@rm -rf $(INSTALL_DIR)/$(ARCH)/debug/bin/$(COMPONENT)
endif