#!/bin/sh
./pre_bootstrap.sh

# Update the homebrew formulae first.
brew update

echo 'Use Fira Code Regular 13pt'
brew install getantibody/tap/antibody
brew tap caskroom/fonts
brew cask install font-fira-code

# Install both Python 2 and Python 3.
# Note: Use python3 venv instead of virtualenv.
brew install python@2 python

# TODO: Install dracula iterm2 theme.
brew install clang-format
brew install fd
brew install hg
brew install htop
brew install llvm
brew install node
brew install nvm
brew install stow
brew install terminal-notifier
brew install the_silver_searcher
brew install tmux
brew install urlview
brew install vim

echo 'If you use ITerm2'
echo 'Q: How do I make the option/alt key act like Meta or send escape codes?'
echo 'A: Go to Preferences > Profiles tab. Select your profile on the left, and then open the Keyboard tab. At the bottom is a set of buttons that lets you select the behavior of the Option key. For most users, Esc+ will be the best choice.'

tic -x terminfo/tmux-256color.terminfo
tic -x terminfo/xterm-256color-italic.terminfo

./post_bootstrap.sh
