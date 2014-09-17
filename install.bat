@echo off
rem CAUTION: %USERPROFILE% AND %~dp0 SHOULD BE IN THE SAME FILESYSTEM. (/H)

rem %USERPROFILE%/bin
mklink /H %USERPROFILE%\bin %~dp0\bin

rem Vim
del /Q %USERPROFILE%\_vimrc
mklink /H %USERPROFILE%\_vimrc %~dp0\.vimrc
rmdir /Q %USERPROFILE%\vimfiles
mklink /D %USERPROFILE%\vimfiles %~dp0\.vim

rem Mercurial
del /Q %USERPROFILE%\.hgext
mklink /D %USERPROFILE%\.hgext %~dp0\.hgext
del /Q %USERPROFILE%\.hgrc
mklink /H %USERPROFILE%\.hgrc %~dp0\.hgrc
copy NUL %USERPROFILE%\.hgrc_mac

rem Git
del /Q %USERPROFILE%\.gitconfig
mklink /D %USERPROFILE%\.gitconfig %~dp0\.gitconfig

set PATH=%USERPROFILE%\bin;%PATH%;C:\Python27;C:\Python27\Scripts

echo * Installing distribute and pip...
python %USERPROFILE%\bin\install_distribute.py
easy_install -q --upgrade pip

echo * Installing Mercurial...
pip -q install --upgrade mercurial
pip -q install --upgrade gntp hg-git

echo * Installing virtualenv...
pip -q install --upgrade virtualenv virtualenvwrapper

echo * Installing SCons...
pip -q install --upgrade scons

echo * Installing iPython and numpy/scipy...
pip -q install --upgrade bokeh
pip -q install --upgrade boto
pip -q install --upgrade cvxopt
pip -q install --upgrade fabric
pip -q install --upgrade flake8 pylint
pip -q install --upgrade flask
pip -q install --upgrade ipython ipdb
pip -q install --upgrade line-profiler
pip -q install --upgrade lxml
pip -q install --upgrade mayavi
pip -q install --upgrade networkx
pip -q install --upgrade nose2
pip -q install --upgrade numpy scipy matplotlib
pip -q install --upgrade paramiko
pip -q install --upgrade pil
pip -q install --upgrade psutil
pip -q install --upgrade scikit-image
pip -q install --upgrade scikit-learn
pip -q install --upgrade sh
pip -q install --upgrade sqlalchemy flask-sqlalchemy

echo * Installing Pyp...
pip -q install --upgrade pyp

echo * Installing Pelican...
pip -q install --upgrade pelican Markdown typogrify boto

pause
