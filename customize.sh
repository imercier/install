#! /bin/bash

echo "
Have internet?
R U sudoer?
Press [Enter]"

read foo


PWD=`pwd`

sudo apt-get -y install $(cat pkg-srv.list)

if [ ! -z "$DISPLAY" ]
then
	sudo apt-get -qq -y install $(cat pkg-x.list)
	mkdir -p ~/.config/terminator
	[ -f ~/.config/terminator/config ] && rm ~/.config/terminator/config
	[ ! -h  ~/.config/terminator/config ] && ln -s $PWD/terminator.config ~/.config/terminator/config
	sudo mkdir -p /root/.config/terminator
	sudo [ -f /root/.config/terminator/config ] && sudo rm /root/.config/terminator/config
	sudo [ ! -h /root/.config/terminator/config ] && sudo ln -s $PWD/terminator.config /root/.config/terminator/config
fi

#HTOP
mkdir -p ~/.config/htop
sudo mkdir -p /root/.config/htop
[ -f ~/.config/htop/htoprc ] && rm ~/.config/htop/htoprc
[ ! -h ~/.config/htop/htoprc ] && ln -s $PWD/htoprc ~/.config/htop/htoprc
sudo [ -f /root/.config/htop/htoprc ] && sudo rm /root/.config/htop/htoprc
sudo [ ! -h /root/.config/htop/htoprc ] && sudo ln -s $PWD/htoprc /root/.config/htop/htoprc

#VIM
[ -f ~/.vimrc ] && rm ~/.vimrc
[ ! -h ~/.vimrc ] && ln -s $PWD/vimrc ~/.vimrc
sudo [ -f /root/.vimrc ] && sudo rm /root/.vimrc
sudo [ ! -h /root/.vimrc ] && sudo ln -s $PWD/vimrc /root/.vimrc

#BASH
[ ! -h ~/.aliases.sh ] && ln -s $PWD/aliases.sh ~/.aliases.sh
sudo [ ! -h /root/.aliases.sh ] && sudo ln -s $PWD/aliases.sh /root/.aliases.sh

[ -f ~/.bashrc ] && rm ~/.bashrc
[ ! -h ~/.bashrc ] && ln -s $PWD/bashrc ~/.bashrc
sudo [ -f /root/.bashrc ] && sudo rm /root/.bashrc
sudo [ ! -h /root/.bashrc ] && sudo ln -s $PWD/bashrc /root/.bashrc

#APT
echo "Dpkg::Progress-Fancy 1;
APT::Color 1;" | sudo tee /etc/apt/apt.conf.d/99progressbar > /dev/null

sudo apt-file update

echo "Ready!"
bash
