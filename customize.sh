#! /bin/bash

echo "Have internet?"
echo "Are you an sudoer?"
echo "debian based?"

read foo

mkdir -p ~/.config/terminator ~/.config/htop
cp terminator.config ~/.config/terminator/config
cp vimrc ~/.vimrc
cp htoprc ~/.config/htop/htoprc
cp sh_aliases ~/.bash_aliases

bash
