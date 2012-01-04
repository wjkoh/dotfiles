@echo off
rem CAUTION: %USERPROFILE% AND %~dp0 SHOULD BE IN THE SAME FILESYSTEM. (/H)

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

set PATH=%PATH%;C:\Python27

echo.
echo Installing distribute...
python install_distribute.py

set PATH=%PATH%;C:\Python27\Scripts

echo.
echo Installing extensions...
easy_install --upgrade pip
pip install --upgrade pip
pip install hg-git

echo.
echo Installing virtualenv...
pip install --upgrade virtualenv
pip install --upgrade virtualenvwrapper

echo.
echo Installing SCons...
pip install --upgrade scons

pause