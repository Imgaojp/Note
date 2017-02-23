@echo off
rem set /p input=请输入注释:
set input="操作系统原理"
git add .
git commit -m %input%
git push