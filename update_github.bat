@echo off
chcp 65001 >nul
cd /d "E:\monkedDev"
git add -A
git commit -m "обновление %date% %time%"
git push origin main
pause