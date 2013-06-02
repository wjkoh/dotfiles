#!/usr/bin/env bash

DOTDIR="$( cd -P "$( dirname "$0" )" && pwd )"
pushd "${DOTDIR}" &> /dev/null

echo "* Installing dotfiles..."

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

echo
echo "* Changing a login shell to Zsh..."
chsh -s /bin/zsh

PIP="sudo pip"
if [ -z "$VIRTUAL_ENV" ]; then
    echo
    echo "* Installing distribute and pip..."
    curl -O http://python-distribute.org/distribute_setup.py
    sudo python distribute_setup.py
    sudo easy_install --upgrade pip
    rm distribute_setup.py
    rm distribute-*.tar.gz
else
    PIP=pip
fi

echo
echo "* Installing Mercurial..."
$PIP install --upgrade mercurial
$PIP install --upgrade gntp hg-git keyring

echo
echo "* Installing virtualenv..."
$PIP install --upgrade virtualenv virtualenvwrapper

echo
echo "* Installing SCons..."
$PIP install --upgrade scons

echo
echo "* Installing iPython and numpy/scipy..."
easy_install readline
$PIP install --upgrade ipython ipdb
$PIP install --upgrade flake8 pylint
$PIP install --upgrade numpy scipy matplotlib
$PIP install --upgrade scikit-learn joblib sympy
$PIP install --upgrade PyOpenGL PyOpenGL_accelerate OpenGLContext
$PIP install --upgrade Mako PyOpenCL
$PIP install --upgrade paramiko

echo
echo "* Installing Ack..."
sudo /usr/bin/cpan App::Ack

echo
echo "* Installing Pyp..."
svn export --force http://pyp.googlecode.com/svn/trunk/ ~/bin
chmod u+x ~/bin/pyp

echo
echo "* Installing Pelican..."
$PIP install --upgrade pelican Markdown typogrify boto

hg clone https://bitbucket.org/tksoh/hgshelve ~/.hgext/hgshelve # temporary fix
