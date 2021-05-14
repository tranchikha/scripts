#!/bin/bash

export WORK_DIR=`pwd`

# Prepare tools

wget https://dl.google.com/android/repository/commandlinetools-linux-7302050_latest.zip
unzip commandlinetools-linux-7302050_latest.zip

# SDK download
$WORK_DIR/cmdline-tools/bin/sdkmanager --sdk_root=$WORK_DIR tools platform-tools 'build-tools;25.0.2' 'platforms;android-28'

# NDK download

wget https://dl.google.com/android/repository/android-ndk-r20b-linux-x86_64.zip
unzip android-ndk-r20b-linux-x86_64.zip

export NDK_DIR=$WORK_DIR/android-ndk-r20b
export SDK_DIR=$WORK_DIR

# Khronos CTS download

git clone https://github.com/KhronosGroup/VK-GL-CTS

cd $WORK_DIR/VK-GL-CTS

git checkout vulkan-cts-1.2.5

python3 external/fetch_sources.py

# Build APK

python3 scripts/android/build_apk.py --sdk $SDK_DIR --ndk $NDK_DIR

# Install APK (optional)

#python3 scripts/android/install_apk.py
