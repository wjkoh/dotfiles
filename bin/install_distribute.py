#!/usr/bin/env python
import urllib

if __name__ == '__main__':
    #curl -O http://python-distribute.org/distribute_setup.py
    filename, _ = urllib.urlretrieve('http://python-distribute.org/distribute_setup.py')
    #sudo python distribute_setup.py
    execfile(filename)
