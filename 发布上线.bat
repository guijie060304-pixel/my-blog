@echo off
chcp 65001 >nul
cd /d D:\Project\my-blog
echo 正在发布，请勿关闭窗口...
git add -A
git commit -m "post: update %date%"
git push
echo.
echo 完成！约 2 分钟后上线：https://guijie060304-pixel.github.io/my-blog/
pause
