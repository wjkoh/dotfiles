#!/usr/bin/env bash

APT_GET="sudo apt-get -y"

# Update MacPorts
$APT_GET update || exit

# Install compilers and utilities
$APT_GET install build-essential || exit
$APT_GET install python-setuptools || exit
$APT_GET install gcc-4.7 || exit
$APT_GET install gfortran || exit
$APT_GET install python-dev || exit
#$APT_GET install python-matplotlib || exit
$APT_GET install zsh || exit

$APT_GET install autojump || exit
$APT_GET install ccache || exit
$APT_GET install ctags || exit
$APT_GET install wget || exit
$APT_GET install git-core || exit
$APT_GET install subversion || exit
$APT_GET install curl || exit
$APT_GET install libncurses-dev || exit
$APT_GET install liblapack-dev || exit
sudo /usr/bin/cpan App::Ack || exit

# tmux
$APT_GET install tmux || exit

# Install libraries
$APT_GET install libboost-dev || exit
$APT_GET install libatlas-dev || exit
$APT_GET install libjpeg-dev || exit
$APT_GET install libpng-dev || exit
$APT_GET install libfreetype6-dev || exit
$APT_GET install libglew-dev || exit
$APT_GET install opencl-headers || exit

# Install MacVim
git clone git://github.com/sigurdga/gnome-terminal-colors-solarized.git
cd gnome-terminal-colors-solarized; ./solarize; cd ..; rm -rf gnome-terminal-colors-solarized

echo
echo "* SUCCESSFULLY DONE!"
