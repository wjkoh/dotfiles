typeset -U path
path=($HOME/bin /opt/local/bin /opt/local/sbin $path)

export EDITOR=vim
export VISUAL=vim
#export PYTHONPATH=/Library/Python/2.7/site-packages:$PYTHONPATH  # To use the latest numpy/scipy over system-default.

export LDFLAGS='-L/opt/local/lib'
export CPPFLAGS='-I/opt/local/include'
export LD_LIBRARY_PATH=/opt/local/lib:$LD_LIBRARY_PATH
export LD_INCLUDE_PATH=/opt/local/include:$LD_INCLUDE_PATH

export PYOPENCL_CTX=1
export PYOPENCL_COMPILER_OUTPUT=1
