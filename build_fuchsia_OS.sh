#!/bin/bash
export CUR_DIR=`pwd`

# Check PC info and warn

curl -sO https://storage.googleapis.com/fuchsia-ffx/ffx-linux-x64 && chmod +x ffx-linux-x64 && ./ffx-linux-x64 platform preflight

# Install require tools

sudo apt-get install -y curl git unzip

# Run bootstrap script to download Fuchsia source

curl -s "https://fuchsia.googlesource.com/fuchsia/+/HEAD/scripts/bootstrap?format=TEXT" | base64 --decode | bash

export PATH=/data/06_FUCHSIA/fuchsia/.jiri_root/bin:$PATH
source /data/06_FUCHSIA/fuchsia/scripts/fx-env.sh

export CCACHE_DIR=/data/06_FUCHSIA/ccache_dir

# Build Fuchsia

cd $CUR_DIR/fuchsia

fx set core.qemu-x64  --ccache

fx build

# Optional

# fx clean clear out all build artifacts.

# fx clean

# fx clean-build perform a clean, then a build.

# fx clean-build
