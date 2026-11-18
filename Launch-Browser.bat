@echo off
setlocal EnableDelayedExpansion
title SLBr Browser Launcher

:: 1. Locate the repository directory (works whether this .bat is inside the repo OR on the Desktop)
set "REPO_DIR="
if exist "%~dp0SLBr\SLBr.csproj" (
    set "REPO_DIR=%~dp0"
) else if exist "%~dp0FuckIT\SLBr\SLBr.csproj" (
    set "REPO_DIR=%~dp0FuckIT"
) else if exist "%USERPROFILE%\Desktop\FuckIT\SLBr\SLBr.csproj" (
    set "REPO_DIR=%USERPROFILE%\Desktop\FuckIT"
) else if exist "%USERPROFILE%\OneDrive\Desktop\FuckIT\SLBr\SLBr.csproj" (
    set "REPO_DIR=%USERPROFILE%\OneDrive\Desktop\FuckIT"
)

if "%REPO_DIR%"=="" (
    echo [ERROR] Could not find the FuckIT\SLBr project folder.
    echo Make sure the repository is cloned on your Desktop as "FuckIT".
    pause
    exit /b 1
)

:: Remove trailing backslash if present
if "%REPO_DIR:~-1%"=="\" set "REPO_DIR=%REPO_DIR:~0,-1%"

:: 2. Search for an already-built SLBr.exe (prefer win-x64 runtime output)
set "EXE_PATH="
for /f "delims=" %%F in ('dir /b /s "%REPO_DIR%\SLBr\bin\Release\SLBr.exe" 2^>nul') do (
    set "CANDIDATE=%%F"
    if not "!CANDIDATE:win-x64=!"=="!CANDIDATE!" (
        set "EXE_PATH=%%F"
        goto :FoundExe
    )
    if not defined EXE_PATH set "EXE_PATH=%%F"
)
if defined EXE_PATH goto :FoundExe

for /f "delims=" %%F in ('dir /b /s "%REPO_DIR%\SLBr\bin\Debug\SLBr.exe" 2^>nul') do (
    set "CANDIDATE=%%F"
    if not "!CANDIDATE:win-x64=!"=="!CANDIDATE!" (
        set "EXE_PATH=%%F"
        goto :FoundExe
    )
    if not defined EXE_PATH set "EXE_PATH=%%F"
)
if defined EXE_PATH goto :FoundExe

:: 3. If not built yet, build once using dotnet CLI
echo ========================================================
echo   First-time setup: Building SLBr Browser via .NET SDK
echo ========================================================
dotnet build "%REPO_DIR%\SLBr\SLBr.csproj" -c Release
if errorlevel 1 (
    echo.
    echo [ERROR] Build failed. Ensure .NET 8 or .NET 9+ SDK is installed ^(dotnet --version^).
    pause
    exit /b 1
)

for /f "delims=" %%F in ('dir /b /s "%REPO_DIR%\SLBr\bin\Release\SLBr.exe" 2^>nul') do (
    set "CANDIDATE=%%F"
    if not "!CANDIDATE:win-x64=!"=="!CANDIDATE!" (
        set "EXE_PATH=%%F"
        goto :FoundExe
    )
    if not defined EXE_PATH set "EXE_PATH=%%F"
)
if defined EXE_PATH goto :FoundExe

echo [ERROR] Could not locate compiled SLBr.exe after build.
pause
exit /b 1

:FoundExe
for %%D in ("%EXE_PATH%") do (
    set "EXE_DIR=%%~dpD"
    cd /d "%%~dpD"
)
if exist "%REPO_DIR%\SLBr\obj\Release\net9.0-windows7.0\win-x64\SLBr.dll" (
    copy /y "%REPO_DIR%\SLBr\obj\Release\net9.0-windows7.0\win-x64\SLBr.dll" "!EXE_DIR!SLBr.dll" >nul 2>&1
)
echo Launching SLBr Browser...
start "" "%EXE_PATH%"
exit /b 0
