#!/bin/bash
npm install -g eslint
npm install -g tslint
npm install -g typescript typescript-language-server
pip3 install isort
pip3 install proselint
pip3 install pylint
pip3 install python-language-server
pip3 install yapf

# Install all tmux plugins managed by TPM.
~/.tmux/plugins/tpm/bin/clean_plugins
~/.tmux/plugins/tpm/bin/install_plugins
~/.tmux/plugins/tpm/bin/update_plugins all
