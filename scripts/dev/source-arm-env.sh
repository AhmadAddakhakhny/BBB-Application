#!/bin/bash
# Source Yocto ARM SDK environment

SDK_PATH="$(dirname "${BASH_SOURCE[0]}")/../../sdk/environment-setup-armv7at2hf-neon-poky-linux-gnueabi"

if [[ "${BASH_SOURCE[0]}" == "$0" ]]; then
    echo "Run with: source $0"
    exit 1
fi

if [[ ! -f "$SDK_PATH" ]]; then
    echo "SDK setup script not found: $SDK_PATH"
    return 1
fi

source "$SDK_PATH"
echo "Yocto ARM SDK environment loaded."