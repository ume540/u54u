#!/bin/bash

mkdir $1
pushd $1
repo init -u https://android.googlesource.com/platform/manifest -b $1 2>&1 | tee repo-init.log
repo sync 2>&1 | tee repo-sync.log
source build/envsetup.sh
lunch full_maguro-userdebug
#make -j1 2>&1 | tee build-full_maguro-userdebug.log
popd

