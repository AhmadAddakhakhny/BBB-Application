# ==========================
# Component-level Makefile
# ==========================

# Component name (auto-detect if folder name)
COMPONENT ?= $(notdir $(CURDIR))

# Default architecture and build type (can be overridden)
ARCH ?= x86
BUILD_TYPE ?= debug

# Detect if we are running tests
ifeq ($(filter test,$(MAKECMDGOALS)),test)
    TEST_MODE := 1
else
    TEST_MODE := 0
endif

# Project root (assumes component folder is inside src)
PROJECT_ROOT := $(abspath $(CURDIR)/../..)
BUILD_DIR := $(PROJECT_ROOT)/builds/$(ARCH)/$(BUILD_TYPE)
INSTALL_DIR := $(PROJECT_ROOT)/install
INSTALL_PREFIX := $(INSTALL_DIR)/$(ARCH)/$(BUILD_TYPE)

# Compute this component's build folder
BUILD_SUBDIR := $(if $(TEST_MODE),$(BUILD_DIR)/tests/$(COMPONENT),$(BUILD_DIR)/$(COMPONENT))

# ==========================
# Default target
# ==========================
.PHONY: all
all: configure build

# ==========================
# Configure
# ==========================
.PHONY: configure
configure:
	@echo "=== Configuring component $(COMPONENT) ($(ARCH)) ==="
	@mkdir -p $(BUILD_SUBDIR)
	@if [ "$(TEST_MODE)" = "1" ]; then \
	    cmake --preset $(ARCH)-linux-gcc-$(BUILD_TYPE)-tests -B $(BUILD_SUBDIR) -S $(PROJECT_ROOT); \
	else \
	    cmake --preset $(ARCH)-linux-gcc-$(BUILD_TYPE) -B $(BUILD_SUBDIR) -S $(PROJECT_ROOT); \
	fi

# ==========================
# Build
# ==========================
.PHONY: build
build:
	@echo "=== Building component $(COMPONENT) ($(ARCH)) ==="
	@if [ "$(TEST_MODE)" = "1" ]; then \
	    cmake --build $(BUILD_SUBDIR); \
	else \
	    cmake --build $(BUILD_SUBDIR) --target $(COMPONENT); \
	    cmake --install $(BUILD_SUBDIR) --prefix $(INSTALL_PREFIX); \
	fi

# ==========================
# Unit tests
# ==========================
.PHONY: test
test: configure build
	@echo "=== Running tests for component $(COMPONENT) ($(ARCH)) ==="
	@cd $(BUILD_SUBDIR) && ctest --output-on-failure

# ==========================
# Clean
# ==========================
.PHONY: clean
clean:
	@echo "=== Cleaning component $(COMPONENT) build directory ==="
	@rm -rf $(BUILD_SUBDIR)
	@rm -rf $(INSTALL_PREFIX)/bin/$(COMPONENT)
