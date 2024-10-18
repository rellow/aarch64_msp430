#!/usr/bin/env bash
set -eu -o pipefail

trap "echo ❌ Failed to install git submodules" ERR

git clone https://github.com/signal11/hidapi.git

echo ✔️ Successfully installed git submodules
