@echo off
set input=
set /p input=ÇëÊäÈë×Ö·û´®:

git add .
git commit -m %input%
git push