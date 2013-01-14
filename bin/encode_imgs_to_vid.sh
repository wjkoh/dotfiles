#!/usr/bin/env bash

ffmpeg -r 2 -i frame_%06d.jpg -vcodec libx264 -threads 4 -preset slower -crf 12 -tune animation -pix_fmt yuv420p output_2fps.mp4
#ffmpeg -r 0.5 -i frame_%06d.jpg -vcodec libx264 -threads 4 -preset slower -crf 12 -tune animation -pix_fmt yuv420p output_60fps.mp4
#ffmpeg -r 0.25 -i frame_%06d.jpg -vcodec libx264 -threads 4 -preset slower -crf 12 -tune animation -pix_fmt yuv420p output_30fps.mp4
#ffmpeg -r 90 -i img_%04d.png -vcodec libx264 -threads 4 -preset veryslow -crf 12 -tune animation -pix_fmt yuv420p output_90fps.mp4
#ffmpeg -r 30 -i img_%04d.png -vcodec libx264 -threads 4 -preset veryslow -crf 12 -tune animation -pix_fmt yuv420p output_30fps.mp4
