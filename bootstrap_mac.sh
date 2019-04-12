#!/bin/sh

brew tap caskroom/fonts
brew cask install font-fira-code

brew install getantibody/tap/antibody

# Install both Python 2 and Python 3.
# Note: Use python3 venv instead of virtualenv.
brew install python@2 python

brew install terminal-notifier

brew install tmux
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# TODO: Install dracula iterm2 theme.
brew install vim
brew install hg

echo 'If you use ITerm2'
echo 'Q: How do I make the option/alt key act like Meta or send escape codes?'
echo 'A: Go to Preferences > Profiles tab. Select your profile on the left, and then open the Keyboard tab. At the bottom is a set of buttons that lets you select the behavior of the Option key. For most users, Esc+ will be the best choice.'
