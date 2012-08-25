#!/bin/sh -x

# install required packages.
sudo apt-get install git-core gnupg flex bison gperf build-essential zip curl
sudo apt-get install libc6-dev x11proto-core-dev g++-multilib mingw32 tofrodos
sudo apt-get install python-markdown libxml2-utils python-software-properties
sudo apt-get install xsltproc libx11-dev:i386 gcc-4.5 g++-4.5 gcc-4.5-multilib
sudo apt-get install g++-4.5-multilib zlib1g-dev:i386 libx11-dev:i386
sudo apt-get install libreadline6-dev:i386 libgl1-mesa-dev lib32ncurses5-dev
sudo apt-get install lib32readline-gplv2-dev lib32z-dev ia32-libs

# create symbolic-link to libGL libraries
sudo ln -s libGL.so.1 /usr/lib/i386-linux-gnu/mesa/libGL.so
sudo ln -s mesa/libGL.so /usr/lib/i386-linux-gnu/libGL.so

mkdir $1
pushd $1
echo "############################################################"
echo "# repo init"
echo "############################################################"
repo init -u https://android.googlesource.com/platform/manifest -b $1 2>&1 | tee init.log
echo "############################################################"
echo "# repo sync"
echo "############################################################"
repo sync 2>&1 | tee sync.log
echo "############################################################"
echo "# set environment variables and lunch"
echo "############################################################"
. build/envsetup.sh
#lunch full_maguro-eng
lunch full_maguro-userdebug
echo "############################################################"
echo "# build android"
echo "############################################################"
make -j1 2>&1 | tee build.log
popd

