@echo off
set /p input=������ע��:
rem set input="Note"
git add .
git commit -m %input%
git push