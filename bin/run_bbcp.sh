#!/usr/bin/env bash
bbcp -V -P 2 -w '=2M' -s 8 -z -N io 'd@ssh.intel-research.net:tar -cz -O -C /homes/d/N7 karate_snu ' 'tar -x -C .'
