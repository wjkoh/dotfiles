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

echo.
echo * Installing distribute and pip...
python %USERPROFILE%\bin\install_distribute.py
easy_install --upgrade pip

echo.
echo * Installing Mercurial...
pip install --upgrade mercurial
pip install --upgrade gntp hg-git

echo.
echo * Installing virtualenv...
pip install --upgrade virtualenv virtualenvwrapper

echo.
echo * Installing SCons...
pip install --upgrade scons

echo.
echo * Installing iPython and numpy/scipy...
pip install --upgrade ipython ipdb
pip install --upgrade flake8 pylint
pip install --upgrade numpy scipy matplotlib
pip install --upgrade mayavi
pip install --upgrade cvxopt
pip install --upgrade nose2
pip install --upgrade sh

echo.
echo * Installing Pyp...
svn export --force http://pyp.googlecode.com/svn/trunk/ ~/bin

echo.
echo * Installing Pelican...
pip install --upgrade pelican Markdown typogrify boto

pause
