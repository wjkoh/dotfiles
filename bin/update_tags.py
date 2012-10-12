#!/usr/bin/env python

"""update_tags.py"""

import os
import subprocess

__author__ = "Woojong Koh"
__status__ = "Development"

std_include_path = '/opt/local/include/gcc47/c++'
std_tags_path = '$HOME/.vim/libstdc++_tags'
std_excludes = ["gcj", "java", "javax"]

ctags_options = ['--sort=foldcase', '--c++-kinds=+p', '--fields=+iaS', '--extra=+q']
ctags_excludes = ['*/typeof/*', '*/preprocessed/*']
ignores = ['.hg', '.git', '.svn']

if __name__ == "__main__":
    processes = set()
    max_processes = 100

    p = subprocess.Popen(' '.join(['ctags'] + ctags_options + ['--exclude=' + x for x in std_excludes] + ['--file-scope=no', '-R', '-I _GLIBCXX_VISIBILITY+', '-f', std_tags_path, std_include_path]), shell=True)
    p.wait()

    for root, dirs, files in os.walk('.'):
        dirs[:] = [d for d in dirs if d not in ignores]
        if len(files) > 0:
            processes.add(subprocess.Popen(['ctags'] + ctags_options + files, cwd=root))
            if len(processes) >= max_processes:
                os.wait()
                processes.difference_update([p for p in processes if p.poll() is not None])

    # Check if all the child processes were close
    for p in processes:
        if p.poll() is None:
            p.wait()

    p = subprocess.Popen(['ctags'] + ctags_options + ['--exclude=' + x for x in ctags_excludes] + ['--file-scope=no', '-R'])
    p.wait()
