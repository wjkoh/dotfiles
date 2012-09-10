#!/bin/sh
sudo port selfupdate
sudo port install autojump
sudo port install ccache
sudo port install ctags
sudo port install gcc47
sudo port install tig

sudo port install tmux
git clone https://github.com/ChrisJohnsen/tmux-MacOSX-pasteboard.git
cd tmux-MacOSX-pasteboard
make reattach-to-user-namespace && sudo cp reattach-to-user-namespace /opt/local/bin
cd ..
rm -rf tmux-MacOSX-pasteboard

sudo port install weechat +aspell +perl +python +tls
sudo port install wget
sudo cpan App::Ack

sudo port install glew
sudo port install jpeg
sudo port install freetype

# install MacVim
