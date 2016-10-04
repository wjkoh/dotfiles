#!/usr/bin/env bash

EASY_INSTALL="sudo easy_install -q --upgrade"
PIP_INSTALL="sudo -H pip -q install --upgrade"

INSTALL_SH_DIR="$( cd -P "$( dirname "$0" )" && pwd )"
MAC_SYNC_DIR="${HOME}/Dropbox/Mac_sync"

# Zsh.
echo "* Changing a login shell to Zsh..."
sudo sh -c 'echo /opt/local/bin/zsh >> /etc/shells'
#chsh -s /bin/zsh || exit
chsh -s /opt/local/bin/zsh || exit

# Dotfiles.
echo "* Installing dotfiles..."
pushd "${INSTALL_SH_DIR}" &> /dev/null
shopt -s dotglob extglob
for DOTFILE in !(.|..|.DS_Store|.hg|.hgsub|.hgsubstate|.hgignore|tags|install.sh|install.bat|README.md|*.swp|.config)
do
    echo "Linking ${DOTFILE}"
    rm -f "${HOME}/${DOTFILE}"
    ln -s "${INSTALL_SH_DIR}/${DOTFILE}" "${HOME}/${DOTFILE}"
done

pushd .config
for DOTFILE in !(.|..|.DS_Store|.placeholder)
do
    echo "Linking ${DOTFILE}"
    rm -f "${HOME}/.config/${DOTFILE}"
    ln -s "${INSTALL_SH_DIR}/.config/${DOTFILE}" "${HOME}/.config/${DOTFILE}"
done
popd &> /dev/null
popd &> /dev/null

#echo "* Installing Facebook PathPicker..."
#pushd "${INSTALL_SH_DIR}/bin"
#ln -s ./PathPicker/fpp fpp
#popd

# Warning! The following are already installed by MacPorts or APT in
# bootstrap_[mac|linux].sh.
#if [ -z "$VIRTUAL_ENV" ]
#then
#    echo "* Installing distribute and pip..."
#    $EASY_INSTALL setuptools || exit
#    $EASY_INSTALL pip || exit
#fi
#
#echo "* Installing Mercurial..."
#$PIP_INSTALL mercurial
#echo "* Installing iPython and numpy/scipy..."
#$PIP_INSTALL ipython ipdb
#$PIP_INSTALL numpy scipy matplotlib
#$PIP_INSTALL sympy
#$PIP_INSTALL pandas
#$PIP_INSTALL scikit-image
#$PIP_INSTALL scikit-learn
#$PIP_INSTALL PyOpenGL PyOpenGL_accelerate
#
#echo "* Installing Mercurial extensions..."
#$PIP_INSTALL hg-git
#$PIP_INSTALL hgsubversion
#$PIP_INSTALL mercurial_keyring
#
#echo "* Installing Python modules..."
#$PIP_INSTALL Pillow  # A fork of PIL.
#$PIP_INSTALL bokeh
#$PIP_INSTALL boto
#$PIP_INSTALL cvxopt
#$PIP_INSTALL fabric
#$PIP_INSTALL flask
#$PIP_INSTALL lxml
#$PIP_INSTALL networkx
#$PIP_INSTALL paramiko
#$PIP_INSTALL psutil
#$PIP_INSTALL sh
#$PIP_INSTALL sqlalchemy flask-sqlalchemy
#$PIP_INSTALL tabulate
#$PIP_INSTALL wand

echo "* Installing Python modules..."
#$PIP_INSTALL nose2
#$PIP_INSTALL pyp
$PIP_INSTALL imgurpython

# Install Prezto.
echo "* Installing Prezto..."
pushd ~/.zprezto
git checkout master
git pull
git submodule update --init --recursive
popd

echo "* Checking out Koh..."
mkdir -p ~/wjkoh-research/
hg clone https://wjkoh@bitbucket.org/wjkoh/koh ~/wjkoh-research/koh
#$PIP_INSTALL -r ~/wjkoh-research/koh/requirements.txt
#$PIP_INSTALL -e ~/wjkoh-research/koh

# ssh_config.
if [ -e "${MAC_SYNC_DIR}/ssh/config" ]
then
  mkdir -p "${HOME}/.ssh"
  rm -f "${HOME}/.ssh/config"
  ln -s "${MAC_SYNC_DIR}/ssh/config" "${HOME}/.ssh/config"
fi

# WeeChat.
if [ -e "${MAC_SYNC_DIR}/weechat/irc.conf" ]
then
  rm -f "${HOME}/.weechat/irc.conf"
  ln -s "${MAC_SYNC_DIR}/weechat/irc.conf" "${HOME}/.weechat/irc.conf"
fi

# VPN.
if [ -e "${MAC_SYNC_DIR}/vpn/install.sh" ]
then
  ${MAC_SYNC_DIR}/vpn/install.sh
fi

# This one should be in install.sh, not bootstap_*.sh, because we don't know the
# path to directory .vim until install.sh links .vim to ~/.vim.
echo "* Building YouCompleteMe plugin..."
pushd ~/.vim/bundle/YouCompleteMe
./install.py --clang-completer
popd

echo "* Installing the Powerline fonts..."
pushd $(mktemp -d)
git clone https://github.com/powerline/fonts.git . && ./install.sh

curl -fLo base16-default.dark.256.itermcolors \
https://raw.githubusercontent.com/chriskempson/base16-iterm2/master/base16-default.dark.256.itermcolors \
&& open base16-default.dark.256.itermcolors

curl -fLo base16-eighties.dark.256.itermcolors \
https://raw.githubusercontent.com/chriskempson/base16-iterm2/master/base16-eighties.dark.256.itermcolors \
&& open base16-eighties.dark.256.itermcolors
popd

# Install Base16 GNOME Terminal themes.
source <(curl -s https://raw.githubusercontent.com/chriskempson/base16-gnome-terminal/master/base16-default.dark.sh)
source <(curl -s https://raw.githubusercontent.com/chriskempson/base16-gnome-terminal/master/base16-eighties.dark.sh)

vim '+PluginInstall!' +qall

~/.fzf/install

echo "* SUCCESSFULLY DONE!"
