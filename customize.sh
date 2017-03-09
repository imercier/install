#! /bin/bash

echo "Have internet?"
echo "R U sudoer?"

read foo


PWD=`pwd`

sudo apt-get install $(cat packages.list)

mkdir -p ~/.config/terminator ~/.config/htop
[ -e ~/.config/terminator.config ] && rm ~/.config/terminator.config
ln -s $PWD/terminator.config ~/.config/terminator/config

[ -e ~/.config/htop/htoprc ] && rm ~/.config/htop/htoprc
ln -s $PWD/htoprc ~/.config/htop/htoprc

[ -e ~/.vimrc ] && rm ~/.vimrc
ln -s $PWD/vimrc ~/.vimrc

ln -s $PWD/aliases.sh ~/.aliases.sh

[ -e ~/.bashrc ] && rm ~/.bashrc
ln -s $PWD/bashrc ~/.bashrc

echo "Dpkg::Progress-Fancy 1;
APT::Color 1;" | sudo tee --append /etc/apt/apt.conf.d/99progressbar

source ~/.bashrc
