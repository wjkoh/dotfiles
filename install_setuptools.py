import os
import urllib
import subprocess

if __name__ == '__main__':
    if os.name == 'nt':
        filename, _ = urllib.urlretrieve('http://peak.telecommunity.com/dist/ez_setup.py')
        #execfile(filename)
        subprocess.call(['python', filename, '-U', 'setuptools'])
