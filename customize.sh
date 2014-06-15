#! /bin/sh -x

echo "Have internet?"
echo "Are you an sudoer?"
echo "debian based?"

read foo

sudo apt-get install $(< packages.lst)

exit

#ohmyssh
wget --no-check-certificate http://install.ohmyz.sh -O - | sh -v

cp terminator.config ~/.config/terminator/config
cp zshrc ~/.zshrc
cp vimrc ~/.vimrc
cp htoprc ~/.config/htop/htoprc

echo "don't forget to import rss streams!"
