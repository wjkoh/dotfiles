#!/usr/bin/env bash
echo -n "Is this a corp machine that has access to source (y/n)? "
read answer

# Dotfiles.
echo "* Installing dotfiles..."
if [ "$answer" != "${answer#[Yy]}" ]; then
  stow --restow google
fi
stow --restow hg
stow --restow nethack
stow --restow ssh
stow --restow tmux
stow --restow vim
stow --restow vimwiki
stow --restow zsh

vim '+PlugInstall!' +qall