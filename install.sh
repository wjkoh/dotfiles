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

echo
echo "* Changing a login shell to Zsh..."
chsh -s /bin/zsh

PIP="sudo pip"
if [ -z "$VIRTUAL_ENV" ]; then
    echo
    echo "* Installing distribute and pip..."
    curl -O http://python-distribute.org/distribute_setup.py || exit
    sudo python distribute_setup.py || exit
    sudo easy_install --upgrade pip || exit
    rm -f distribute_setup.py
    rm -f distribute-*.tar.gz
else
    PIP=pip
fi

echo
echo "* Installing Mercurial..."
$PIP install --upgrade mercurial || exit
$PIP install --upgrade gntp hg-git keyring || exit

echo
echo "* Installing virtualenv..."
$PIP install --upgrade virtualenv virtualenvwrapper || exit

echo
echo "* Installing SCons..."
sudo easy_install --upgrade scons || exit

echo
echo "* Installing iPython and numpy/scipy..."
sudo easy_install readline || exit
$PIP install --upgrade ipython ipdb || exit
$PIP install --upgrade flake8 pylint || exit
$PIP install --upgrade numpy scipy matplotlib || exit
$PIP install --upgrade scikit-learn joblib sympy || exit
$PIP install --upgrade paramiko || exit

$PIP install --upgrade flask || exit
$PIP install --upgrade sqlalchemy flask-sqlalchemy || exit

echo
echo "* Installing Ack..."
sudo /usr/bin/cpan App::Ack || exit

echo
echo "* Installing Pyp..."
svn export --force http://pyp.googlecode.com/svn/trunk/ ~/bin
chmod u+x ~/bin/pyp

echo
echo "* Installing Pelican..."
$PIP install --upgrade pelican Markdown typogrify boto || exit

echo
echo "* SUCCESSFULLY DONE!"

hg clone https://bitbucket.org/tksoh/hgshelve ~/.hgext/hgshelve # temporary fix

$PIP install --upgrade PyOpenGL PyOpenGL_accelerate OpenGLContext || exit
$PIP install --upgrade Mako PyOpenCL || exit
