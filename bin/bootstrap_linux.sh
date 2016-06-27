#!/usr/bin/env bash

# Install Ubuntu Tweak (http://ubuntu-tweak.com/) for natural scrolling.
# Install GNOME Tweak Tool (https://apps.ubuntu.com/cat/applications/gnome-tweak-tool/).

APT_GET="sudo apt-get -y"

# Update apt-get.
$APT_GET update || exit

# Install compilers.
$APT_GET install build-essential || exit
$APT_GET install gcc-4.8 || exit
$APT_GET install gfortran || exit
$APT_GET install python-dev || exit
$APT_GET install python-setuptools || exit

# Install Python modules.
$APT_GET install ipython || exit
$APT_GET install ipython-notebook || exit
$APT_GET install python-matplotlib || exit
$APT_GET install python-nose || exit
$APT_GET install python-numpy || exit
$APT_GET install python-pandas || exit
$APT_GET install python-scipy || exit
$APT_GET install python-sympy || exit

# OpenGL.
$APT_GET install python-opengl || exit
$APT_GET install python-scikits-learn || exit
$APT_GET install python-skimage || exit

# Mercurial-related modules.
$APT_GET install hgsubversion || exit
$APT_GET install mercurial-git || exit
$APT_GET install mercurial-keyring || exit

echo "* Installing Python modules..."
$APT_GET install fabric || exit
#$APT_GET install python-bokeh || exit  # Not available yet.
$APT_GET install python-boto || exit
$APT_GET install python-cvxopt || exit
$APT_GET install python-flask || exit
$APT_GET install python-flask-sqlalchemy || exit
$APT_GET install python-lxml || exit
$APT_GET install python-networkx || exit
$APT_GET install python-paramiko || exit
$APT_GET install python-pil || exit  # Pillow fork by default in Ubuntu.
$APT_GET install python-psutil || exit
#$APT_GET install python-sh || exit  # Not available yet.
$APT_GET install python-sqlalchemy || exit
#$APT_GET install python-tabulate || exit  # Not available yet.
$APT_GET install python-wand || exit

# Install utilities.
#$APT_GET install ffmpeg || exit  # Not available.
$APT_GET install aspell-en || exit
$APT_GET install autojump || exit
$APT_GET install ccache || exit
$APT_GET install cmake || exit  # For YouCompleteMe plugin.
$APT_GET install cowsay || exit
$APT_GET install ctags || exit
$APT_GET install curl || exit
$APT_GET install git-core || exit
$APT_GET install htop || exit
$APT_GET install imagemagick || exit
$APT_GET install meld || exit
$APT_GET install mercurial || exit
$APT_GET install mosh || exit
$APT_GET install mpv || exit
$APT_GET install nmap || exit
$APT_GET install pigz || exit
$APT_GET install ranger || exit
$APT_GET install s3cmd || exit
$APT_GET install scons || exit
$APT_GET install silversearcher-ag || exit
$APT_GET install subversion || exit
$APT_GET install swig || exit  # for SciPy
$APT_GET install texlive-full || exit
$APT_GET install tig || exit
$APT_GET install tmux || exit
$APT_GET install urlview || exit
$APT_GET install urlview || exit
$APT_GET install watch || exit
$APT_GET install weechat || exit
$APT_GET install wget || exit
$APT_GET install wireshark || exit
$APT_GET install zsh || exit

# Install libraries.
#$APT_GET install ceres-solver || exit  # Not available.
$APT_GET install freeglut3-dev || exit
$APT_GET install libatlas-base-dev || exit
$APT_GET install libatlas-dev || exit
$APT_GET install libboost-all-dev || exit
$APT_GET install libclang-dev || exit  # For YouCompleteMe plugin.
$APT_GET install libfreetype6-dev || exit  # Also for PIL
$APT_GET install libglew-dev || exit
$APT_GET install libglfw-dev || exit
$APT_GET install libglu1-mesa-dev || exit
$APT_GET install libjpeg-dev || exit
$APT_GET install liblapack-dev || exit
$APT_GET install liblapack-dev || exit
$APT_GET install libncurses-dev || exit
$APT_GET install libncurses-dev || exit
$APT_GET install libpng-dev || exit
$APT_GET install libsuitesparse-dev || exit
$APT_GET install opencl-headers || exit

# Assimp.
$APT_GET install assimp-utils || exit
$APT_GET install libassimp-dev || exit
$APT_GET install python-pyassimp || exit

# Install Solarized.
pushd $(mktemp -d)
git clone git://github.com/sigurdga/gnome-terminal-colors-solarized.git . && ./set_dark.sh
popd

echo
echo "* SUCCESSFULLY DONE!"
