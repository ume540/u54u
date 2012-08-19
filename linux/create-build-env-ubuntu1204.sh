#!/bin/bash

KERNEL_VER=3.2.0
KERNEL_REV=29
PWD=`pwd`

echo "----------------------------------------------------------------------"
echo "-- install required package to build kernel source"
echo "----------------------------------------------------------------------"
apt-get install build-essential
apt-get install kernel-package
apt-get install libncurses-dev
# libqt3 is required only to use make xconfig
apt-get install libqt3-mt-dev

echo "----------------------------------------------------------------------"
echo "-- downloding kernel source"
echo "----------------------------------------------------------------------"
apt-get install linux-source-${KERNEL_VER}

echo "----------------------------------------------------------------------"
echo "-- extracting kernel source to current directory"
echo "----------------------------------------------------------------------"
tar xf /usr/src/linux-source-${KERNEL_VER}.tar.bz2 linux-source-${KERNEL_VER}

echo "----------------------------------------------------------------------"
echo "-- generating default kernel config file"
echo "----------------------------------------------------------------------"
pushd linux-source-${KERNEL_VER}
cp /boot/config-${KERNEL_VER}-${KERNEL_REV}-generic .config
make oldconfig
# following modification is needed in kernel 3.x on ubuntu 
sed -i s/CONFIG_RTS5139=m/CONFIG_RTS5139=n/ .config
popd

# following line is needed for kernel 2.6 on ubunu
#echo "----------------------------------------------------------------------"
#echo "-- create /ubunt"
#echo "----------------------------------------------------------------------"
#sudo ln -s ${PWD}/linux-source-${KERNEL_VER}/ubuntu /ubunt

echo "----------------------------------------------------------------------"
echo "complete creating environment for building ubuntu kernel"
echo ""
echo "# configure kernel"
echo "> cd ${PWD}/linux-source-${KERNEL_VER}"
echo "> make menuconfig"
echo ""
echo "# build kernel"
echo "> cd ${PWD}/linux-source-${KERNEL_VER}"
echo "> make -j8"
echo ""
echo "# generate kernel package"
echo "> cd ${PWD}/linux-source-${KERNEL_VER}"
echo "> sudo make-kpkg --initrd kernel_image"
echo ""
echo "# install(replace) new kernel"
echo "> sudo dpkg -i *.deb"

