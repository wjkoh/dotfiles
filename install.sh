#!/usr/bin/env bash

USE_ANACONDA=true
if [ $USE_ANACONDA ]; then
    EASY_INSTALL="conda install -q --yes"
    PIP_INSTALL="conda install -q --yes"
else
    EASY_INSTALL="sudo easy_install -q --upgrade"
    PIP_INSTALL="sudo pip -q install --upgrade"
fi


echo "* Installing dotfiles..."
DOTDIR="$( cd -P "$( dirname "$0" )" && pwd )"
pushd "${DOTDIR}" &> /dev/null
shopt -s dotglob extglob
for DOTFILE in !(.DS_Store|.hg|.hgsub|.hgsubstate|.hgignore|tags|install.sh|install.bat)
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
elif [ !$USE_ANACONDA ]; then
    EASY_INSTALL="easy_install -q --upgrade"
    PIP_INSTALL="pip -q install --upgrade"
fi

echo "* Installing Mercurial..."
$PIP_INSTALL mercurial
$PIP_INSTALL gntp hg-git
$PIP_INSTALL keyring mercurial_keyring

if [ !$USE_ANACONDA ]; then
    echo "* Installing virtualenv..."
    $PIP_INSTALL virtualenv virtualenvwrapper
fi

echo "* Installing SCons..."
$EASY_INSTALL scons

echo "* Installing iPython and numpy/scipy..."
$EASY_INSTALL readline
$PIP_INSTALL ipython ipdb
$PIP_INSTALL flake8 pylint
$PIP_INSTALL numpy scipy matplotlib
$PIP_INSTALL scikit-learn joblib sympy
$PIP_INSTALL mayavi
$PIP_INSTALL cvxopt
$PIP_INSTALL PyOpenGL PyOpenGL_accelerate OpenGLContext
$PIP_INSTALL Mako PyOpenCL
$PIP_INSTALL paramiko
$PIP_INSTALL PIL
$PIP_INSTALL networkx
$PIP_INSTALL line-profiler
$PIP_INSTALL nose2
$PIP_INSTALL flask
$PIP_INSTALL sqlalchemy flask-sqlalchemy
$PIP_INSTALL sh
$PIP_INSTALL lxml
$PIP_INSTALL boto
$PIP_INSTALL fabric
$PIP_INSTALL psutil
$PIP_INSTALL bokeh

echo "* Installing Pyp..."
$PIP_INSTALL pyp

echo "* Installing Pelican..."
$PIP_INSTALL pelican Markdown typogrify boto

echo "* SUCCESSFULLY DONE!"
