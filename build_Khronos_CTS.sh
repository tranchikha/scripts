#!/bin/bash

export WORK_DIR=`pwd`

# Prepare tools

wget https://dl.google.com/android/repository/commandlinetools-linux-7302050_latest.zip
unzip commandlinetools-linux-7302050_latest.zip

# SDK download
$WORK_DIR/cmdline-tools/bin/sdkmanager --sdk_root=$WORK_DIR tools platform-tools 'build-tools;25.0.2' 'platforms;android-28'

# NDK download (stable NDK)

wget https://dl.google.com/android/repository/android-ndk-r20b-linux-x86_64.zip
unzip android-ndk-r20b-linux-x86_64.zip

export NDK_DIR=$WORK_DIR/android-ndk-r20b
export SDK_DIR=$WORK_DIR

# Khronos CTS download

git clone https://github.com/KhronosGroup/VK-GL-CTS

cd $WORK_DIR/VK-GL-CTS

export TARGET=$1

if [ ${TARGET} = "VULKAN" ] || [ ${TARGET} = "OPENGLES" ] ; then
        echo "Building $TARGET"
else
        echo "Invalid TARGET=$TARGET. Set OPENGLES as default build target"
	export TARGET="OPENGLES"
fi

if [ ${TARGET} = "VULKAN" ] ; then

# Checkout branch
git checkout TAG_vulkan-cts-1.2.5 tags/vulkan-cts-1.2.5.0

# Fetch dependencies
python3 external/fetch_sources.py

# Build APK
python3 scripts/android/build_apk.py --sdk $SDK_DIR --ndk $NDK_DIR

else # !VULKAN

# Checkout branch
git checkout -b TAG_opengl-es-cts-3.2.6.2 tags/opengl-es-cts-3.2.6.2

# Fetch dependencies
python3 external/fetch_sources.py

# Build APK
python3 scripts/android/build_apk.py --target=openglcts --sdk $SDK_DIR --ndk $NDK_DIR

fi

# Install APK (optional)

#python3 scripts/android/install_apk.py
