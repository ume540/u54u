#!/bin/bash

sudo apt-get install git-core gnupg flex bison gperf build-essential zip curl libc6-dev x11proto-core-dev g++-multilib mingw32 tofrodos python-markdown libxml2-utils python-software-properties xsltproc libx11-dev:i386 gcc-4.5 g++-4.5 gcc-4.5-multilib g++-4.5-multilib zlib1g-dev:i386 libx11-dev:i386 libreadline6-dev:i386 libgl1-mesa-dev lib32ncurses5-dev lib32readline-gplv2-dev lib32z-dev ia32-libs
sudo ln -s libGL.so.1 /usr/lib/i386-linux-gnu/mesa/libGL.so
sudo ln -s mesa/libGL.so /usr/lib/i386-linux-gnu/libGL.so

#sudo apt-get install git-core gnupg flex bison gperf build-essential
#sudo apt-get install zip curl libc6-dev libncurses5-dev:i386 x11proto-core-dev
#sudo apt-get install libx11-dev:i386 libreadline6-dev:i386 libgl1-mesa-glx:i386
#sudo apt-get install libgl1-mesa-dev g++-multilib mingw32 openjdk-6-jdk tofrodos
#sudo apt-get install python-markdown libxml2-utils xsltproc zlib1g-dev:i386

#sudo ln -s /usr/lib/i386-linux-gnu/mesa/libGL.so.1 /usr/lib/i386-linux-gnu/libGL.so

mkdir $1
pushd $1
echo "############################################################"
echo "# repo init"
echo "############################################################"
repo init -u https://android.googlesource.com/platform/manifest -b $1 | tee init.log
echo "############################################################"
echo "# repo sync"
echo "############################################################"
repo sync | tee sync.log
echo "############################################################"
echo "# set environment variables and lunch"
echo "############################################################"
. build/envsetup.sh
#lunch full_maguro-eng
lunch full_maguro-userdebug
echo "############################################################"
echo "# build android"
echo "############################################################"
make -j1 | tee build.log
popd

