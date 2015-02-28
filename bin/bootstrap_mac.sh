#!/usr/bin/env bash

PORT_INSTALL="sudo port install"  # -f: force
PORT_SELECT="sudo port select --set"

sudo xcodebuild -license

# Update MacPorts.
sudo port selfupdate || exit
sudo port upgrade outdated  # It might fail, so don't add `|| exit`.

# Change default Python installation.
$PORT_INSTALL python27 || exit
$PORT_SELECT python python27
$PORT_INSTALL py27-setuptools || exit
$PORT_INSTALL py27-pip || exit
$PORT_SELECT pip pip27
$PORT_INSTALL py27-ipython +notebook || exit
$PORT_SELECT ipython ipython27
$PORT_INSTALL py27-ipdb || exit
$PORT_SELECT ipdb ipdb27
rehash

# I hope installing these using MacPorts gives me a better performance than using PIP.
$PORT_INSTALL py27-numpy || exit
$PORT_INSTALL py27-scipy || exit
$PORT_INSTALL py27-matplotlib || exit
$PORT_INSTALL py27-pandas || exit
$PORT_INSTALL py27-sympy || exit
$PORT_INSTALL py27-nose || exit

$PORT_INSTALL py27-scikit-learn || exit
$PORT_INSTALL py27-scikit-image || exit
$PORT_INSTALL py27-opengl || exit
$PORT_INSTALL py27-opengl-accelerate || exit

$PORT_INSTALL py27-hggit || exit
$PORT_INSTALL py27-hgsubversion || exit
$PORT_INSTALL py27-mercurial_keyring || exit

# Install compilers.
$PORT_INSTALL gcc49 || exit
sudo ln -sf /opt/local/bin/gfortran-mp-4.9 /opt/local/bin/gfortran || exit

# Install utilities.
$PORT_INSTALL aspell-dict-en || exit
$PORT_INSTALL autojump || exit
$PORT_INSTALL ccache || exit
$PORT_INSTALL coreutils || exit
$PORT_INSTALL ctags || exit
$PORT_INSTALL git +bash_completion +svn +credential_osxkeychain || exit
$PORT_INSTALL grep || exit
$PORT_INSTALL htop || exit
$PORT_INSTALL imagemagick || exit
$PORT_INSTALL macvim +python27 +breakindent || exit
$PORT_INSTALL meld || exit
$PORT_INSTALL mercurial +bash_completion +zsh_completion || exit
$PORT_INSTALL mosh || exit
$PORT_INSTALL nmap || exit
$PORT_INSTALL pigz || exit
$PORT_INSTALL s3cmd || exit
$PORT_INSTALL scons || exit
$PORT_INSTALL swig swig-python || exit  # for SciPy
$PORT_INSTALL texlive texlive-latex-extra texlive-science || exit
$PORT_INSTALL the_silver_searcher || exit
$PORT_INSTALL tig || exit
$PORT_INSTALL tmux libmpdclient || exit
$PORT_INSTALL tmux-pasteboard
$PORT_INSTALL watch || exit
$PORT_INSTALL weechat +aspell +perl +python +tls || exit  # Install aspell-dict-en as well.
$PORT_INSTALL wget || exit
$PORT_INSTALL wireshark || exit
$PORT_INSTALL x264 +asm ffmpeg || exit

# Install libraries.
# Do not mix libc++ and libstdc++. http://www.alecjacobson.com/weblog/?p=3145
# sudo port -ns upgrade --force boost configure.compiler=macports-gcc-4.8 || exit
$PORT_INSTALL anttweakbar || exit
$PORT_INSTALL assimp || exit
$PORT_INSTALL boost || exit
$PORT_INSTALL ceres-solver || exit
$PORT_INSTALL freeglut || exit
$PORT_INSTALL freetype || exit
$PORT_INSTALL glew || exit
$PORT_INSTALL glfw || exit
$PORT_INSTALL glm || exit
$PORT_INSTALL jpeg || exit
$PORT_INSTALL libevent || exit  # for gevent/bokeh
$PORT_INSTALL libpng || exit
$PORT_INSTALL opencv +python27 +eigen || exit
$PORT_INSTALL suitesparse || exit

# For Matplotlib and PIL. Pillow is okay?
sudo ln -s /opt/local/include/freetype2 /opt/local/include/freetype

# Install XQuartz.
open "http://xquartz.macosforge.org"

echo
echo "* SUCCESSFULLY DONE!"

# Optionals.
# Install NetHack.
$PORT_INSTALL nethack +autopickup_exceptions +menucolors

# Install DayOne CLI.
wget http://dayoneapp.com/downloads/dayone-cli.pkg -P /tmp/ && open /tmp/dayone-cli.pkg

# Install Dandy.
curl https://raw.githubusercontent.com/EBvi/dandy/master/bin/uninstall.sh | sh
curl https://raw.githubusercontent.com/EBvi/dandy/master/bin/install.sh | sh

# Better fast than slow.
defaults delete NSGlobalDomain KeyRepeat
defaults delete NSGlobalDomain InitialKeyRepeat
defaults write NSGlobalDomain KeyRepeat -int 0
#defaults write NSGlobalDomain InitialKeyRepeat -int 4

# Use Google's public DNS servers. It's 2015.
sudo networksetup -setdnsservers Ethernet 8.8.8.8 8.8.4.4
sudo networksetup -setdnsservers Wi-Fi 8.8.8.8 8.8.4.4
