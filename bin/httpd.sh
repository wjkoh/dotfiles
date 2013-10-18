#!/bin/sh

python -m SimpleHTTPServer 8888 1> log.txt 2> err.txt &
echo Serving at http://localhost:8888
