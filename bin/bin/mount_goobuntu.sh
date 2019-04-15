#!/usr/bin/env bash

USERNAME=wjkoh
YOURHOST=wjkoh0.mtv
CITC_MOUNT_DIR=$HOME/goobuntu_citc
HOME_MOUNT_DIR=$HOME/goobuntu_home

mkdir -p $CITC_MOUNT_DIR 2> /dev/null
mkdir -p $HOME_MOUNT_DIR 2> /dev/null

# Should I unmount these mount points first?

sshfs $USERNAME@$YOURHOST.corp.google.com:/google/src/cloud/$USERNAME $CITC_MOUNT_DIR \
  -ofollow_symlinks -ovolname=$CITC_MOUNT_DIR -oauto_cache -oiosize=65536 -oallow_recursion \
  -oreconnect -oworkaround=rename:nodelaysrv:buflimit -onoappledouble

sshfs $USERNAME@$YOURHOST.corp.google.com:/usr/local/google/home/$USERNAME $HOME_MOUNT_DIR \
  -ofollow_symlinks -ovolname=$HOME_MOUNT_DIR -oauto_cache -oiosize=65536 -oallow_recursion \
  -oreconnect -oworkaround=rename:nodelaysrv:buflimit -onoappledouble
