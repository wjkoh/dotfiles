#!/usr/bin/env bash

convert -delay 6 -loop 0 -resize 50% frame_*.png output.gif
