#!/usr/bin/env bash

src=$1
preset=veryslow

# Encodes CRF 6 video (1-pass).
crf=18
dst=${2:-output_${preset}_crf${crf}.mp4}
ffmpeg -i $src -c:v libx264 -preset $preset -crf $crf -pix_fmt yuv420p -an $dst
exit

# Encodes 50 MB video (2-pass).
# (50 MB * 8192 [converts MB to kilobits]) / 600 seconds = ~683 kilobits/s total bitrate
# 683k - 128k (desired audio bitrate) = 555k video bitrate
bitrate=2700k  # 50 MB, ? secs
bitrate=9330k  # 500 MB, 439 secs
dst=${2:-output_${preset}_b${bitrate}.mp4}
rm ffmpeg2pass*.log ffmpeg2pass*.log.mbtree
ffmpeg -y -i $src -c:v libx264 -preset $preset -b:v $bitrate -pix_fmt yuv420p -pass 1 -an -f mp4 /dev/null && \
ffmpeg -i $src -c:v libx264 -preset $preset -b:v $bitrate -pix_fmt yuv420p -pass 2 -an $dst
exit

