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

# Install Prezto.
echo "* Installing Prezto..."
pushd ~/.zprezto
git checkout master
git pull
git submodule update --init --recursive
popd

# Note: Use 13pt DejaVu Sans Mono (Book).
echo "* Installing the Powerline fonts..."
pushd $(mktemp -d)
git clone https://github.com/powerline/fonts.git . && ./install.sh

# Note: Run `base16_ocean` or similar in shell first. You may not need to install
# profiles due to base16-shell.
# If MacOS.
# curl -fLo base16-default-dark-256.itermcolors \
# https://raw.githubusercontent.com/martinlindhe/base16-iterm2/master/itermcolors/base16-default-dark-256.itermcolors \
# && open base16-default-dark-256.itermcolors
# curl -fLo base16-eighties-256.itermcolors \
# https://raw.githubusercontent.com/martinlindhe/base16-iterm2/master/itermcolors/base16-eighties-256.itermcolors \
# && open base16-eighties-256.itermcolors
popd

# Note: Run `base16_ocean` or similar in shell first. You may not need to install
# profiles due to base16-shell.
# Install Base16 GNOME Terminal themes.
# source <(curl -s https://raw.githubusercontent.com/aaron-williamson/base16-gnome-terminal/master/color-scripts/base16-default-dark.sh)
# source <(curl -s https://raw.githubusercontent.com/aaron-williamson/base16-gnome-terminal/master/color-scripts/base16-eighties.sh)

vim '+PlugInstall!' +qall

~/.fzf/install --all

echo "* SUCCESSFULLY DONE!"
