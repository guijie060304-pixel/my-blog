@echo off
cd /d D:\Project\my-blog
set /p T=请输入文章标题:
if "%T%"=="" goto end
hexo new "%T%"
set "LATEST="
for /f "delims=" %%i in ('dir /b /o-d source\_posts\*.md') do if not defined LATEST set "LATEST=%%i"
set "VSC=%LocalAppData%\Programs\Microsoft VS Code\Code.exe"
if exist "%VSC%" (
  start "" "%VSC%" "source\_posts\%LATEST%"
) else (
  start "" "%SystemRoot%\notepad.exe" "source\_posts\%LATEST%"
)
echo.
echo 文章已创建并打开，写完后双击「发布上线.bat」即可
:end
pause
