#!/bin/bash

# Render once in 50 frames and the original FPS is 25.
# -> (1 / 25) sec * 50 = 2 sec/frame
# -> 1/2 fps
ffmpeg -r 1/2 -pattern_type glob -i 'frame_*.png' -c:v libx264 -r 25 -pix_fmt yuv420p output.mp4
