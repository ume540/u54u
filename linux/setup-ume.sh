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
sudo apt-get install doxygen graphviz
sudo apt-get install tmux

# LXC
sudo apt-get install lxc debootstrap
sudo apt-get install bridge-utils
sudo apt-get install libssl-dev

# JDK
echo "Would you like install Open JDK 6? [y/N]:"
read INP
if [ ${INP} = 'y' -o ${INP} = 'yes' ]; then
    sudo apt-get install openjdk-6-jdk
fi
#}}}

# move to home
pushd ~/

echo "----------------------------------------------------------------------"
echo "-- install NeoBundle for vim"
echo "----------------------------------------------------------------------"
mkdir -p .vim
pushd .vim
git clone https://github.com/Shougo/neobundle.vim.git neobundle.vim.git
popd

#{{{ node.js
echo "======================================================================"
echo "setup node.js"
echo "======================================================================"
git clone git://github.com/creationix/nvm.git ~/.nvm
source .nvm/nvm.sh
nvm install v0.6.18
nvm use v0.6.18
export NODE_PATH=${NVM_PATH}_modules
echo "======================================================================"
echo "setup express.js"
echo "======================================================================"
npm install -g express
echo "======================================================================"
echo "setup coffee-script.js"
echo "======================================================================"
npm install -g coffee-script
echo "======================================================================"
echo "setup hiredis"
echo "======================================================================"
npm install -g hiredis
echo "======================================================================"
echo "setup redis"
echo "======================================================================"
npm install -g redis
echo "======================================================================"
echo "setup mongoose"
echo "======================================================================"
npm install -g mongoose
echo "======================================================================"
echo "setup ejs"
echo "======================================================================"
npm install -g ejs
echo "======================================================================"
echo "setup connect-assets"
echo "======================================================================"
npm install -g connect-assets
echo "======================================================================"
echo "setup connect-redis"
echo "======================================================================"
npm install -g connect-redis
echo "======================================================================"
echo "setup ws"
echo "======================================================================"
npm install -g ws --ws:native
echo "======================================================================"
echo "setup socket.io"
echo "======================================================================"
npm install -g socket.io
echo "======================================================================"
echo "setup js2coffee"
echo "======================================================================"
npm install -g js2coffee
echo "======================================================================"
echo "setup tower.js"
echo "======================================================================"
npm install -g tower
#}}}

# return original folder
popd

