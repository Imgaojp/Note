@echo off
rem set /p input=请输入注释:
set input="GitHub入门与实践"
git add .
git commit -m %input%
git push