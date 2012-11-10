#!/bin/bash

progsec() {
    echo -e "\e[30;42m$1\e[m"
}

progsec "--                    Install required packages                     --"

sudo apt-get install \
    git-core \
    gnupg \
    flex bison \
    gperf \
    build-essential \
    zip curl \
    libc6-dev \
    x11proto-core-dev \
    libgl1-mesa-dev \
    g++-multilib \
    mingw32 \
    openjdk-6-jdk \
    tofrodos \
    python-markdown \
    python-software-properties \
    libxml2-utils \
    xsltproc \
    ia32-libs \
    lib32ncurses5-dev \
    lib32readline-gplv2-dev \
    lib32z-dev \
    libx11-dev:i386 \
    libreadline6-dev:i386 \
    libgl1-mesa-glx:i386 \
    zlib1g-dev:i386 \
#    libncurses5-dev:i386 \

sudo ln -s libGL.so.1 /usr/lib/i386-linux-gnu/mesa/libGL.so
sudo ln -s mesa/libGL.so /usr/lib/i386-linux-gnu/libGL.so

