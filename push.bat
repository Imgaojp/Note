@echo off
rem set /p input=ÇëÊäÈë×¢ÊÍ:
set input="add"
git add .
git commit -m %input%
git push