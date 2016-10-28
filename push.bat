@echo off
rem set /p input=ÇëÊäÈë×¢ÊÍ:
set input="Note"
git add .
git commit -m %input%
git push