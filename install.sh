#!/bin/env bash

DOTDIR="$( cd -P "$( dirname "$0" )" && pwd )"
pushd "${DOTDIR}" &> /dev/null

echo "* Installing dotfiles..."

shopt -s dotglob extglob
for DOTFILE in !(.hg|.hgsub|.hgsubstate|.hgignore|tags|install|install.bat)
do
    echo ${DOTFILE}
    TARGET="${HOME}/${DOTFILE}"
    rm -rf "${TARGET}"
    ln -sf "${DOTDIR}/${DOTFILE}" "${TARGET}"
done

rm -rf "${HOME}/.weechat/irc.conf"
ln -sf "${HOME}/Dropbox/Mac Sync/weechat/irc.conf" "${HOME}/.weechat/irc.conf"
popd &> /dev/null

echo
echo "* Changing a login shell to ZSH..."
chsh -s /bin/zsh

PIP=sudo pip
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
$PIP install --upgrade ipython ipdb
$PIP install --upgrade numpy scipy matplotlib

echo
echo "* Installing Ack..."
sudo /usr/bin/cpan App::Ack

svn export --force http://pyp.googlecode.com/svn/trunk/ ~/bin
chmod u+x ~/bin/pyp
