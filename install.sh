#!/usr/bin/env bash

USE_ANACONDA=false
if [ "$USE_ANACONDA" == true ]; then
    EASY_INSTALL="conda install -q --yes"
    PIP_INSTALL="conda install -q --yes"
else
    EASY_INSTALL="sudo CFLAGS=-Qunused-arguments CPPFLAGS=-Qunused-arguments easy_install -q --upgrade"
    PIP_INSTALL="sudo CFLAGS=-Qunused-arguments CPPFLAGS=-Qunused-arguments pip -q install --upgrade"
fi

echo "* Installing dotfiles..."
DOTDIR="$( cd -P "$( dirname "$0" )" && pwd )"
pushd "${DOTDIR}" &> /dev/null
shopt -s dotglob extglob
for DOTFILE in !(.DS_Store|.hg|.hgsub|.hgsubstate|.hgignore|tags|install.sh|install.bat|README.md)
do
    echo ${DOTFILE}
    TARGET="${HOME}/${DOTFILE}"
    rm -rf "${TARGET}"
    ln -s "${DOTDIR}/${DOTFILE}" "${TARGET}"
done

rm -rf "${HOME}/.weechat/irc.conf"
ln -s "${HOME}/Dropbox/Mac Sync/weechat/irc.conf" "${HOME}/.weechat/irc.conf"
popd &> /dev/null

echo "* Changing a login shell to Zsh..."
chsh -s /bin/zsh

if [ -z "$VIRTUAL_ENV" ]; then
    echo "* Installing distribute and pip..."
    $EASY_INSTALL setuptools || exit
    $EASY_INSTALL pip || exit
elif [ "$USE_ANACONDA" == false ]; then
    EASY_INSTALL="easy_install -q --upgrade"
    PIP_INSTALL="pip -q install --upgrade"
fi

echo "* Installing Mercurial..."
$PIP_INSTALL mercurial
$PIP_INSTALL gntp hg-git
$PIP_INSTALL keyring mercurial_keyring

if [ "$USE_ANACONDA" == false ]; then
    echo "* Installing virtualenv..."
    $PIP_INSTALL virtualenv virtualenvwrapper
fi

#echo "* Installing SCons... (Please install it manually if fails.)"
#$EASY_INSTALL scons  # Can fail.

echo "* Installing iPython and numpy/scipy..."
# For bokeh, you may need to run
# `sudo CFLAGS="-I /opt/local/include -L /opt/local/lib" pip install bokeh`
# instead after installing libevent.

#$PIP_INSTALL mayavi  # Can fail.
$EASY_INSTALL readline
$PIP_INSTALL --pre OpenGLContext
$PIP_INSTALL --pre line-profiler
$PIP_INSTALL Mako PyOpenCL
$PIP_INSTALL Pillow  # A fork of PIL.
$PIP_INSTALL PyOpenGL PyOpenGL_accelerate
$PIP_INSTALL bokeh
$PIP_INSTALL boto
$PIP_INSTALL cvxopt
$PIP_INSTALL fabric
$PIP_INSTALL flake8 pylint
$PIP_INSTALL flask
$PIP_INSTALL hg+http://bitbucket.org/pygame/pygame  # For SimpleCV.
$PIP_INSTALL ipython ipdb
$PIP_INSTALL lxml
$PIP_INSTALL networkx
$PIP_INSTALL nose2
$PIP_INSTALL numpy scipy matplotlib
$PIP_INSTALL paramiko
$PIP_INSTALL psutil
$PIP_INSTALL scikit-image
$PIP_INSTALL scikit-learn
$PIP_INSTALL sh
$PIP_INSTALL sqlalchemy flask-sqlalchemy
$PIP_INSTALL sympy
$PIP_INSTALL tabulate
$PIP_INSTALL wand

echo "* Installing Pyp..."
$PIP_INSTALL pyp

echo "* Installing Pelican..."
$PIP_INSTALL pelican Markdown typogrify boto

echo "* Checking out Koh..."
mkdir -p ~/wjkoh-research/
hg clone https://wjkoh@bitbucket.org/wjkoh/koh ~/wjkoh-research/koh
$PIP_INSTALL -r ~/wjkoh-research/koh/requirements.txt
$PIP_INSTALL -e ~/wjkoh-research/koh

echo "* SUCCESSFULLY DONE!"
