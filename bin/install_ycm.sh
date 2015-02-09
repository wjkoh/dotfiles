#!/usr/bin/env bash

pushd "$(pwd)" &> /dev/null
cd ~/.vim/bundle/YouCompleteMe/ && \
  git submodule update --init --recursive && \
  ./install.sh --clang-completer --system-libclang
popd &> /dev/null
