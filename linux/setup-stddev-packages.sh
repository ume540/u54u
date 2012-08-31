#!/bin/bash -x

#{{{ install basic software
echo "======================================================================"
echo "Install packages"
echo "======================================================================"
sudo apt-get update
sudo apt-get install aptitude
sudo apt-get install curl wget
sudo apt-get install vim
sudo apt-get install exuberant-ctags
sudo apt-get install nkf
sudo apt-get install git-core mercurial subversion
#sudo apt-get install doxygen graphviz
sudo apt-get install tmux

# LXC
#sudo apt-get install lxc debootstrap
sudo apt-get install bridge-utils
sudo apt-get install libssl-dev

