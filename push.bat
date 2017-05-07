@echo off
set /p input=请输入注释:
rem set input="操作系统原理"
git add .
git commit -m %input%
git push