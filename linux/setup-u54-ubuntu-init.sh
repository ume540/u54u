#!/bin/bash

# install basic packages
sudo apt-get update
sudo apt-get upgrade

sudo apt-get install  wget git tmux vim

mkdir -p ~/.vim
git clone https://github.com/Shougo/neobundle.vim.git ~/.vim/neobundle.vim.git

git clone https://github.com/ume540/u54u.git ~/u54u
ln -s ~/u54u/conf/.bashrc_umeda ~/
ln -s ~/u54u/conf/.tmux.conf ~/
ln -s ~/u54u/conf/.vimrc ~/

