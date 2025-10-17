# ==========================
# Top-level Makefile
# ==========================

# include
include cmake/components.min

# Default architecture
ARCH ?= arm
# Default to build all components if COMPONENT is not specified
COMPONENT ?= all
# Map ARCH to CMake preset
ifeq ($(ARCH),arm)
    PRESET := x86-linux-gcc-debug
else ifeq ($(ARCH),x86)
    PRESET := x86-linux-gcc-debug
else
    $(error Unsupported ARCH=$(ARCH). Use arm or x86)
endif

# Root of the project
SRC_DIR := $(CURDIR)
BUILD_DIR := $(SRC_DIR)/builds/$(ARCH)/debug

# Function to compute the build directory for a component
define build_subdir
$(BUILD_DIR)/$1
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
	    cmake --preset $(PRESET) -DBUILD_COMPONENT=$$c -DBUILD_SOURCES=ON -B $(call build_subdir,$$c); \
	done
else
	# @TBD: Validate the component first
	@echo "=== Configuring component $(COMPONENT) ($(ARCH)) ==="
	@mkdir -p $(call build_subdir,$(COMPONENT))
	@cmake --preset $(PRESET) -DBUILD_COMPONENT=$(COMPONENT) -DBUILD_SOURCES=ON -B $(call build_subdir,$(COMPONENT))
endif

# ==========================
# Build target
# ==========================
.PHONY: build
build:
ifeq ($(COMPONENT),all)
	@echo "=== Building all components ($(ARCH)) ==="
	@for c in $(AVAILABLE_COMPONENTS); do \
	    cmake --build $(call build_subdir,$$c) --target $$c; \
	done
else
	@echo "=== Building component $(COMPONENT) ($(ARCH)) ==="
	@cmake --build $(call build_subdir,$(COMPONENT)) --target $(COMPONENT)
endif

# ==========================
# Unit tests
# ==========================
.PHONY: test
test: BUILD_TESTING := ON
test: configure build run-tests

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
	@rm -rf $(BUILD_DIR)/*
else
	# @TBD: Validate the component first
	@echo "=== Cleaning build directory for component $(COMPONENT) ==="
	@rm -rf $(BUILD_DIR)/$(COMPONENT)
endif