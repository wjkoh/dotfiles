#!/bin/bash
./pre_bootstrap.sh

# Update the package index files first.
sudo apt update

curl -sfL git.io/antibody | sudo sh -s - -b /usr/local/bin || exit
sudo apt install fd-find
sudo apt install htop
sudo apt install kitty
sudo apt install mutt
sudo apt install nodejs
sudo apt install python-pip
sudo apt install python3-pip
sudo apt install renameutils
sudo apt install ripgrep
sudo apt install silversearcher-ag
sudo apt install stow
sudo apt install urlview

if [ -f ~/.at_google ]; then
  FD_FIND_URL='http://http.us.debian.org/debian/pool/main/r/rust-fd-find/fd-find_7.2.0-2_amd64.deb'
  sudo glinux-add-repo clang-include-fixer stable
  sudo glinux-add-repo -p 600 typescript stable
  sudo apt update
  sudo apt install clang-include-fixer
  sudo apt install clsearch
  sudo apt install nodejs
  curl $FD_FIND_URL --output fd-find.deb
  sudo dpkg -i fd-find.deb
fi

./install_dotfiles.sh
./post_bootstrap.sh
