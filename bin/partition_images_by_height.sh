#!/usr/bin/env bash

mkdir -p negative

for f in *.png
do
  height=$(identify -format '%h' "${f}")
  if [ ${height} -lt 70 ]
  then
    mv "${f}" negative/
  fi
done
