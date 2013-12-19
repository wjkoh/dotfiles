#!/usr/bin/env bash

DOTDIR="$( cd -P "$( dirname "$0" )" && pwd )"

echo "* Installing dotfiles..."
pushd "${DOTDIR}" &> /dev/null
shopt -s dotglob extglob
for DOTFILE in !(.hg|.hgsub|.hgsubstate|.hgignore|tags|install.sh|install.bat)
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

PIP="sudo pip -q"
if [ -z "$VIRTUAL_ENV" ]; then
    echo "* Installing distribute and pip..."
    #wget https://bitbucket.org/pypa/setuptools/downloads/ez_setup.py --no-check-certificate
    #sudo python ez_setup.py || exit
    sudo easy_install -q --upgrade setuptools || exit
    sudo easy_install -q --upgrade pip || exit
else
    PIP="pip -q"
fi

echo "* Installing Mercurial..."
$PIP install --upgrade mercurial
$PIP install --upgrade gntp hg-git
$PIP install --upgrade keyring mercurial_keyring

echo "* Installing virtualenv..."
$PIP install --upgrade virtualenv virtualenvwrapper

echo "* Installing SCons..."
sudo easy_install -q --upgrade scons

echo "* Installing iPython and numpy/scipy..."
sudo easy_install -q --upgrade readline
$PIP install --upgrade ipython ipdb
$PIP install --upgrade flake8 pylint
$PIP install --upgrade numpy scipy matplotlib
$PIP install --upgrade scikit-learn joblib sympy
$PIP install --upgrade mayavi
$PIP install --upgrade cvxopt
$PIP install --upgrade PyOpenGL PyOpenGL_accelerate OpenGLContext
$PIP install --upgrade Mako PyOpenCL
$PIP install --upgrade paramiko
$PIP install --upgrade PIL
$PIP install --upgrade networkx
$PIP install --upgrade line-profiler
$PIP install --upgrade nose2
$PIP install --upgrade flask
$PIP install --upgrade sqlalchemy flask-sqlalchemy
$PIP install --upgrade sh
$PIP install --upgrade lxml
$PIP install --upgrade boto
$PIP install --upgrade fabric
$PIP install --upgrade psutil

echo "* Installing Pyp..."
$PIP install --upgrade pyp

echo "* Installing Pelican..."
$PIP install --upgrade pelican Markdown typogrify boto

echo "* SUCCESSFULLY DONE!"
