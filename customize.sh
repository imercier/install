#! /bin/zsh

echo "Have internet?"
echo "Running Zsh?"
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

ln -s $PWD/aliases ~/.aliases

[ -e ~/.bashrc ] && rm ~/.bashrc
ln -s $PWD/bashrc ~/.bashrc


sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

[ -e ~/.zshrc ] && rm ~/.zshrc
ln -s $PWD/zshrc ~/.zshrc

source ~/.zshrc
