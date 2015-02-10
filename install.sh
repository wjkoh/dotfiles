#!/usr/bin/env bash

EASY_INSTALL="sudo easy_install -q --upgrade"
PIP_INSTALL="sudo -H pip -q install --upgrade"

# Dotfiles.
echo "* Installing dotfiles..."
DOTDIR="$( cd -P "$( dirname "$0" )" && pwd )"
pushd "${DOTDIR}" &> /dev/null
shopt -s dotglob extglob
for DOTFILE in !(.|..|.DS_Store|.hg|.hgsub|.hgsubstate|.hgignore|tags|install.sh|install.bat|README.md|*.swp)
do
    echo ${DOTFILE}
    TARGET="${HOME}/${DOTFILE}"
    rm -rf "${TARGET}"
    ln -s "${DOTDIR}/${DOTFILE}" "${TARGET}"
done

# WeeChat.
rm -rf "${HOME}/.weechat/irc.conf"
ln -s "${HOME}/Dropbox/Mac Sync/weechat/irc.conf" "${HOME}/.weechat/irc.conf"
popd &> /dev/null

# Zsh.
echo "* Changing a login shell to Zsh..."
chsh -s /bin/zsh || exit

if [ -z "$VIRTUAL_ENV" ]; then
    echo "* Installing distribute and pip..."
    $EASY_INSTALL setuptools || exit
    $EASY_INSTALL pip || exit
fi

# Warning! The following are already installed by MacPorts or APT in
# bootstrap_[mac|linux].sh.
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

echo "* Installing Mercurial extensions..."
$PIP_INSTALL hg-git
$PIP_INSTALL mercurial_keyring

# This one should be in install.sh, not bootstap_*.sh, because we don't know the path to
# directory .vim until install.sh links .vim to ~/.vim.
echo "* Installing YouCompleteMe..."
install_ycm.sh

echo "* Installing Python modules..."
$PIP_INSTALL Pillow  # A fork of PIL.
$PIP_INSTALL bokeh
$PIP_INSTALL boto
$PIP_INSTALL cvxopt
$PIP_INSTALL fabric
$PIP_INSTALL flask
$PIP_INSTALL lxml
$PIP_INSTALL networkx
$PIP_INSTALL nose2
$PIP_INSTALL paramiko
$PIP_INSTALL psutil
$PIP_INSTALL pyp
$PIP_INSTALL sh
$PIP_INSTALL sqlalchemy flask-sqlalchemy
$PIP_INSTALL tabulate
$PIP_INSTALL wand

echo "* Checking out Koh..."
mkdir -p ~/wjkoh-research/
hg clone https://wjkoh@bitbucket.org/wjkoh/koh ~/wjkoh-research/koh
$PIP_INSTALL -r ~/wjkoh-research/koh/requirements.txt
$PIP_INSTALL -e ~/wjkoh-research/koh

echo "* SUCCESSFULLY DONE!"
