@echo off
rem CAUTION: %USERPROFILE% AND %~dp0 SHOULD BE IN THE SAME FILESYSTEM. (/H)

rem Vim
del /Q %USERPROFILE%\_vimrc
mklink /H %USERPROFILE%\_vimrc %~dp0\.vimrc
rmdir /Q %USERPROFILE%\vimfiles
mklink /D %USERPROFILE%\vimfiles %~dp0\.vim

rem Mercurial
del /Q %USERPROFILE%\_hgrc
mklink /H %USERPROFILE%\_hgrc %~dp0\.hgrc
