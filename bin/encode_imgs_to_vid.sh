#!/usr/bin/env bash

# iMovie (baseline)
ffmpeg -r 60 -i frame_%04d.png -vcodec libx264 -threads 3 -preset veryslow -crf 1 -pix_fmt yuv420p -profile:v baseline output_baseline_60fps.mp4
ffmpeg -r 30 -i frame_%04d.png -vcodec libx264 -threads 3 -preset veryslow -crf 1 -pix_fmt yuv420p -profile:v baseline output_baseline_30fps.mp4

# General
#ffmpeg -r 60 -i frame_%06d.jpg -vcodec libx264 -threads 3 -preset veryslow -crf 1 -pix_fmt yuv420p output_60fps.mp4
#ffmpeg -r 30 -i frame_%04d.png -vcodec libx264 -threads 3 -preset veryslow -crf 1 -pix_fmt yuv420p output_30fps.mp4
