#!/usr/bin/env bash

APT_GET="sudo apt-get -y"

# Update apt-get
$APT_GET update || exit

# Install compilers
$APT_GET install build-essential || exit
$APT_GET install gcc-4.8 || exit
$APT_GET install gfortran || exit
$APT_GET install python-dev || exit
$APT_GET install python-setuptools || exit
#$APT_GET install python-matplotlib || exit

# Install utilities
$APT_GET install autojump || exit
$APT_GET install ccache || exit
$APT_GET install ctags || exit
$APT_GET install curl || exit
$APT_GET install ffmpeg || exit
$APT_GET install git-core || exit
$APT_GET install htop || exit
$APT_GET install liblapack-dev || exit
$APT_GET install libncurses-dev || exit
$APT_GET install meld || exit
$APT_GET install mosh || exit
$APT_GET install subversion || exit
$APT_GET install tig || exit
$APT_GET install tmux || exit
$APT_GET install weechat || exit
$APT_GET install wget || exit
$APT_GET install zsh || exit
$APT_GET install swig || exit  # for SciPy

# Install libraries
$APT_GET install libatlas-dev || exit
$APT_GET install libboost-dev || exit
$APT_GET install libfreetype6-dev || exit  # Also for PIL
$APT_GET install libglew-dev || exit
$APT_GET install libglfw-dev || exit
$APT_GET install libjpeg-dev || exit
$APT_GET install liblapack-dev || exit
$APT_GET install libncurses-dev || exit
$APT_GET install libpng-dev || exit
$APT_GET install opencl-headers || exit
$APT_GET install suitesparse || exit

# Install Solarized
git clone git://github.com/sigurdga/gnome-terminal-colors-solarized.git
cd gnome-terminal-colors-solarized; ./solarize; cd ..; rm -rf gnome-terminal-colors-solarized

echo
echo "* SUCCESSFULLY DONE!"
