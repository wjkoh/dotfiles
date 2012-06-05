#!/bin/sh
sudo port selfupdate
sudo port install autojump
sudo port install ccache
sudo port install ctags
sudo port install gcc47
sudo port install tmux
sudo port install weechat +aspell +perl +python +tls
sudo port install wget
#sudo port install p5-app-ack
cpan App::Ack
