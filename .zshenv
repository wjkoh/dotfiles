typeset -U path
path=(/Applications/MacVim.app/Contents/MacOS $HOME/bin /opt/local/bin /opt/local/sbin $path)

export EDITOR=vim
export VISUAL=vim
export PYTHONPATH=/Library/Python/2.7/site-packages:$PYTHONPATH  # To use the latest numpy/scipy over system-default.

export PYOPENCL_CTX=1
export PYOPENCL_COMPILER_OUTPUT=1
