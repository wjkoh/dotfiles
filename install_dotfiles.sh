#!/usr/bin/env bash
echo -n "Is this a corp machine that has access to source (y/n)? "
read answer

# Dotfiles.
echo "* Installing dotfiles..."
if [ "$answer" != "${answer#[Yy]}" ]; then
  stow google
fi
stow zsh
stow hg
stow vim
stow ssh
stow tmux
stow nethack

source ~/.zshrc
vim '+PlugInstall!' +qall
