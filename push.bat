@echo off
rem set /p input=������ע��:
set input="add"
git add .
git commit -m %input%
git push