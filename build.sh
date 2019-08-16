#!/bin/bash

KERNEL_DIR=$PWD
#ANYKERNEL_DIR=$KERNEL_DIR/AnyKernel
TOOLCHAINDIR=~/toolchain
DATE=$(date +"%d%m%Y")
KERNEL_NAME="RGBkernel"
VER="-v1.2"
FINAL_ZIP="$KERNEL_NAME""$VER".zip

#rm $ANYKERNEL_DIR/Image.lz4-dtb
rm $KERNEL_DIR/arch/arm64/boot/Image.lz4 $KERNEL_DIR/arch/arm64/boot/Image.lz4-dtb

export ARCH=arm64
export SUBARCH=arm64
export KBUILD_BUILD_USER="SawaMEN"
export KBUILD_BUILD_HOST="RGBcorp"
export CC=$TOOLCHAINDIR/linux-x86_64/bin/clang
export CXX=$TOOLCHAINDIR/linux-x86_64/bin/clang++
export CLANG_TRIPLE=aarch64-linux-gnu-
export CROSS_COMPILE=$TOOLCHAINDIR/gcc-linaro-5.5.0-2017.10-x86_64_aarch64-linux-gnu/bin/aarch64-linux-gnu-
#export CROSS_COMPILE_ARM32=$TOOLCHAINDIR/gcc-linaro-5.5.0-2017.10-x86_64_arm-linux-gnueabi/bin/arm-linux-gnueabi-
export USE_CCACHE=1
export CCACHE_DIR=../.ccache

make clean && make mrproper
make marlin_defconfig
make -j$( nproc --all )

#cp $KERNEL_DIR/arch/arm64/boot/Image.lz4-dtb $ANYKERNEL_DIR
#cd $ANYKERNEL_DIR
#zip -r9 $FINAL_ZIP * -x *.zip $FINAL_ZIP
