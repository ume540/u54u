#!/bin/bash

sudo apt-get install \
    ia32-libs \
    openjdk-6-jdk \
    ant \

ADEV_BASE=$HOME/android/devtools
NDK_TARFILE=android-ndk-r8b-linux-x86.tar.bz2
NDK_DLURL=http://dl.google.com/android/ndk/$NDK_TARFILE
NDK_DIRORG=android-ndk-r8b
NDK_DIRNAME=ndk-r8b
ADK_TARFILE=android-sdk_r20.0.3-linux.tgz
ADK_DLURL=http://dl.google.com/android/$ADK_TARFILE
ADK_DIRORG=android-sdk-linux
ADK_DIRNAME=sdk

mkdir -p $ADEV_BASE
pushd $ADEV_BASE
    if ! [ -e "$ADK_DIRNAME" ]; then
        [ -f "$ADK_TARFILE" ] || wget $ADK_DLURL
        tar xf $ADK_TARFILE
        mv $ADK_DIRORG $ADK_DIRNAME
    fi
    if ! [ -e "NDK_DIRNAME" ]; then
        [ -f "$NDK_TARFILE" ] || wget $NDK_DLURL
        tar xf $NDK_TARFILE
        mv $NDK_DIRORG $NDK_DIRNAME
    fi
popd

