@echo off
cd /d "E:\monkedDev"
git add -A
git commit -m "обновление %date% %time%"
git push origin main
pause