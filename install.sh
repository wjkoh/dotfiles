#!/usr/bin/env bash
INSTALL_SH_DIR="$( cd -P "$( dirname "$0" )" && pwd )"
echo -n "Is this a corp machine that has access to source (y/n)? "
read answer
if [ "$answer" != "${answer#[Yy]}" ] ;then
    touch ~/.at_google
fi

# Zsh.
#echo "* Changing a login shell to Zsh..."
#chsh -s /bin/zsh || exit
#sudo sh -c 'echo /opt/local/bin/zsh >> /etc/shells'
#chsh -s /opt/local/bin/zsh || exit

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

vim '+PlugInstall!' +qall

echo "* SUCCESSFULLY DONE!"
