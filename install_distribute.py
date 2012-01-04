import urllib

if __name__ == '__main__':
    filename, _ = urllib.urlretrieve('http://python-distribute.org/distribute_setup.py')
    execfile(filename)
