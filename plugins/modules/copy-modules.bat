@echo off

cd /d "%~dp0"

@REM /Y Подавляет запрос на подтверждение перезаписи
@REM /U Копирует только файлы, уже имеющиеся в конечной папке.

xcopy *.js ..\stg-plugin-create-new-tab /U/Y

@REM exit /b 0
