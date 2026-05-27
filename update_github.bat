@echo off
setlocal enabledelayedexpansion

:: Настройки репозитория
set REPO_URL=https://github.com/monkedDev/monkedDevelope.git
set BRANCH=main
set DEFAULT_COMMIT_MSG=Auto-update: %date% %time%

echo ========================================
echo   Git push helper for monkedDevelope
echo ========================================
echo.

:: 1. Проверка, инициализирован ли Git
if not exist ".git" (
    echo Git репозиторий не найден. Выполняем git init...
    git init
    if errorlevel 1 (
        echo Ошибка при инициализации Git.
        pause
        exit /b 1
    )
    echo Создаём README.md, если его нет...
    if not exist "README.md" (
        echo # monkedDevelope >> README.md
    )
    echo Добавляем README.md и делаем первый коммит...
    git add README.md
    git commit -m "first commit"
    if errorlevel 1 (
        echo Ошибка при первом коммите.
        pause
        exit /b 1
    )
) else (
    echo Git репозиторий уже существует.
)

:: 2. Проверка наличия remote 'origin'
git remote get-url origin >nul 2>&1
if errorlevel 1 (
    echo Добавляем remote origin...
    git remote add origin %REPO_URL%
    if errorlevel 1 (
        echo Ошибка добавления remote.
        pause
        exit /b 1
    )
) else (
    echo Remote 'origin' уже существует.
)

:: 3. Переключение на ветку main
git branch -M %BRANCH%

:: 4. Добавление всех изменений (новые, изменённые, удалённые файлы)
echo Добавляем все изменения...
git add -A
if errorlevel 1 (
    echo Ошибка при git add.
    pause
    exit /b 1
)

:: 5. Запрос сообщения коммита у пользователя
set /p COMMIT_MSG="Введите сообщение коммита (Enter - использовать стандартное): "
if "%COMMIT_MSG%"=="" set COMMIT_MSG=%DEFAULT_COMMIT_MSG%

:: 6. Выполнение коммита
git commit -m "%COMMIT_MSG%"
if errorlevel 1 (
    echo Нет изменений для коммита или ошибка.
) else (
    echo Коммит создан.
)

:: 7. Отправка изменений на GitHub
echo Отправляем изменения в ветку %BRANCH%...
git push -u origin %BRANCH%
if errorlevel 1 (
    echo Ошибка при push. Проверьте подключение к интернету и права доступа к репозиторию.
    pause
    exit /b 1
)

echo ========================================
echo   Готово! Изменения отправлены.
echo ========================================
pause