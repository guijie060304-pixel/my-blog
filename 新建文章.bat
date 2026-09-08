@echo off
cd /d D:\Project\my-blog
powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0newpost.ps1"
pause
