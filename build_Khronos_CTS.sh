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

# Prepare output directory

mkdir -pv $WORK_DIR/output_VK-GL-CTS
export out_dir=$WORK_DIR/output_VK-GL-CTS

# Download Khronos test source

cd $WORK_DIR/VK-GL-CTS

export TARGET=$1

if [ ${TARGET} = "VULKAN" ] || [ ${TARGET} = "OPENGLES" ] ; then
        echo "Building $TARGET"
else
        echo "Invalid TARGET=$TARGET. Set OPENGLES as default build target"
	export TARGET="OPENGLES"
fi

if [ ${TARGET} = "OPENGLES" ] ; then
# Download required tool
$WORK_DIR/cmdline-tools/bin/sdkmanager --sdk_root=$WORK_DIR 'platforms;android-22'
fi

echo "Start building ${TARGET} at `date`" >> $out_dir/build_${TARGET}.txt

if [ ${TARGET} = "VULKAN" ] ; then

# Checkout branch
git checkout -b TAG_vulkan-cts-1.2.5.0 tags/vulkan-cts-1.2.5.0

# Fetch dependencies
python3 external/fetch_sources.py

# Set custom output directory
patch -Np1 < $WORK_DIR/0001-VK-GL-CTS-Custom-output-directory.patch

# Build APK
python3 scripts/android/build_apk.py --sdk $SDK_DIR --ndk $NDK_DIR

else # !VULKAN

# Checkout branch
git checkout -b TAG_opengl-es-cts-3.2.6.2 tags/opengl-es-cts-3.2.6.2

# Fetch dependencies
python3 external/fetch_sources.py

# Set custom output directory
patch -Np1 < $WORK_DIR/0001-VK-GL-CTS-Custom-output-directory.patch

# Build APK
python3 scripts/android/build_apk.py --target=openglcts --sdk $SDK_DIR --ndk $NDK_DIR

fi

echo "Finish building ${TARGET} at `date`" >> $out_dir/build_${TARGET}.txt

# Install APK (optional)

#python3 scripts/android/install_apk.py
