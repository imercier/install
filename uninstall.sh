#! /bin/bash

echo "
Are you sudoer?
Press [Enter]"

read foo

[ -L  ~/.config/terminator/config ] && unlink ~/.config/terminator/config
sudo [ -L /root/.config/terminator/config ] && sudo unlink /root/.config/terminator/config

[ -L ~/.config/htop/htoprc ] && unlink ~/.config/htop/htoprc
sudo [ -L /root/.config/htop/htoprc ] && sudo unlink /root/.config/htop/htoprc

[ -L ~/.vimrc ] && unlink ~/.vimrc
sudo [ -L /root/.vimrc ] && sudo unlink /root/.vimrc

[ -L ~/.aliases.sh ] && unlink ~/.aliases.sh
sudo [ -L /root/.aliases.sh ] && sudo unlink /root/.aliases.sh

[ -L ~/.bash_command_timer.sh ] && unlink ~/.bash_command_timer.sh
sudo [ -L /root/.bash_command_timer.sh ] && sudo unlink /root/.bash_command_timer.sh

[ -L ~/.bashrc ] && unlink ~/.bashrc
sudo [ -L /root/.bashrc ] && sudo unlink /root/.bashrc

echo "Links removed!"
