#! /bin/bash

echo "Have internet?"
echo "Are you an sudoer?"
echo "debian based?"

read foo

sudo apt-get install $(< packages.lst)

mkdir ~/.config/terminator ~/.config/htop
cp terminator.config ~/.config/terminator/config
cp vimrc ~/.vimrc
cp htoprc ~/.config/htop/htoprc
cp sh_aliases ~/.sh_aliases

echo "
if [ -f ~/.sh_aliases ]; then
    . ~/.sh_aliases
fi
" >> ~/.bashrc

bash
