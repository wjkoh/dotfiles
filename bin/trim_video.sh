#!/usr/bin/env bash

filename=$(basename "$1")
extension="${filename##*.}"
filename="${filename%.*}"

ffmpeg -i "$1" -vcodec copy -acodec copy -ss 00:00:20 -t 00:00:20 "$filename"_trimmed."$extension"
