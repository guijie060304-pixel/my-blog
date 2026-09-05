@echo off
chcp 65001 >nul
cd /d D:\Project\my-blog
set /p T=请输入文章标题:
if "%T%"=="" (echo 未输入标题 & pause & exit /b)
hexo new "%T%"
start "" notepad "source\_posts\%T%.md"
echo.
echo 文章已创建并打开，写完后双击「发布上线.bat」即可
pause
