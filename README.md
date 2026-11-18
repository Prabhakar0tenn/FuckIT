<div align="center">

# SLBr (FuckIT Edition)

**A lightweight, Chrome-like WPF C# browser built for .NET 8 & .NET 9+**<br/>
**Fast, full-featured Chromium & WebView2 browsing with zero Visual Studio dependency — runs with just the `dotnet` CLI.**

[![C#](https://img.shields.io/static/v1?style=for-the-badge&message=C%23&color=239120&logo=csharp&logoColor=239120&label=&labelColor=black)](https://github.com/Prabhakar0tenn/FuckIT)
[![XAML](https://img.shields.io/static/v1?style=for-the-badge&message=WPF&color=0C54C2&logo=WPF&logoColor=0C54C2&label=&labelColor=black)](https://github.com/Prabhakar0tenn/FuckIT)
[![.NET](https://img.shields.io/static/v1?style=for-the-badge&message=.NET%208%20%2F%209%2B&color=512BD4&logo=.NET&logoColor=512BD4&label=&labelColor=black)](https://github.com/Prabhakar0tenn/FuckIT)
[![Chromium](https://img.shields.io/static/v1?style=for-the-badge&message=Chromium&color=006CFF&logo=GoogleChrome&logoColor=006CFF&label=&labelColor=black)](https://github.com/Prabhakar0tenn/FuckIT)

</div>

---

## Quick Start (Clone on Desktop & Run)

You only need the **.NET 8.0 or .NET 9.0+ SDK** (`dotnet`) installed on Windows 10/11. No Visual Studio installation is required!

### 1. Clone the repository to your Desktop

Open **PowerShell** or **Command Prompt** and run:

```powershell
cd "$HOME\Desktop"
git clone https://github.com/Prabhakar0tenn/FuckIT.git
cd FuckIT
```

### 2. Launch using the included `.bat` file

- Double-click **`Launch-Browser.bat`** inside `Desktop\FuckIT` (or copy `Launch-Browser.bat` directly onto your `Desktop`).
- On the first launch, it automatically builds the browser in Release mode (`win-x64`) using `dotnet build` and launches **`SLBr.exe`** as an independent desktop process (visible in Task Manager).
- On every launch after that, it starts **`SLBr.exe`** instantaneously!

### 3. Or build & run manually via CLI

```powershell
cd "$HOME\Desktop\FuckIT"
dotnet build SLBr\SLBr.csproj -c Release
start "" "SLBr\bin\Release\net9.0-windows7.0\win-x64\SLBr.exe"
```
*(If you have .NET 8 installed, the output folder will automatically be `SLBr\bin\Release\net8.0-windows7.0\win-x64\SLBr.exe`.)*

---

## Ask Any Chat-Based Copilot / AI to Make Your Desktop `.bat` Launcher

If you cloned this repo to your Desktop (`Desktop\FuckIT`) and want any chat-based AI (Microsoft Copilot, ChatGPT, Claude, etc.) to generate a Desktop `.bat` launcher for you, copy and paste this prompt into the chat:

> **Prompt to copy-paste into Copilot:**
> ```text
> I have cloned https://github.com/Prabhakar0tenn/FuckIT onto my Windows Desktop at %USERPROFILE%\Desktop\FuckIT (or %USERPROFILE%\OneDrive\Desktop\FuckIT).
> Write a Windows batch (.bat) file that I can save on my Desktop as Launch-Browser.bat.
> The batch file should:
> 1. Locate my Desktop\FuckIT folder (checking both %USERPROFILE%\Desktop\FuckIT and %USERPROFILE%\OneDrive\Desktop\FuckIT).
> 2. Look for SLBr.exe inside SLBr\bin\Release\*\win-x64\SLBr.exe.
> 3. If SLBr.exe does not exist yet, run: dotnet build "%REPO_DIR%\SLBr\SLBr.csproj" -c Release
> 4. Launch SLBr.exe as a detached background/GUI process using: start "" /D "<exe_folder>" "<exe_path>" so the browser runs in Task Manager and the command prompt window closes immediately.
> ```

Or simply save the following code as **`Launch-Browser.bat`** directly on your Desktop:

```bat
@echo off
setlocal EnableDelayedExpansion
title SLBr Browser Launcher

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
    echo [ERROR] Could not find Desktop\FuckIT\SLBr\SLBr.csproj.
    pause
    exit /b 1
)
if "%REPO_DIR:~-1%"=="\" set "REPO_DIR=%REPO_DIR:~0,-1%"

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

echo Building SLBr Browser via .NET SDK...
dotnet build "%REPO_DIR%\SLBr\SLBr.csproj" -c Release
for /f "delims=" %%F in ('dir /b /s "%REPO_DIR%\SLBr\bin\Release\SLBr.exe" 2^>nul') do (
    set "CANDIDATE=%%F"
    if not "!CANDIDATE:win-x64=!"=="!CANDIDATE!" (
        set "EXE_PATH=%%F"
        goto :FoundExe
    )
    if not defined EXE_PATH set "EXE_PATH=%%F"
)

:FoundExe
for %%D in ("%EXE_PATH%") do cd /d "%%~dpD"
taskkill /F /IM SLBr.exe >nul 2>&1
start "" "%EXE_PATH%"
exit /b 0
```

---

## Notable Chrome-Like Features

- **Default Dark Mode (UI + Web Pages):** Opens in sleek Dark Mode out of the box with Smart Dark Mode enabled for websites.
- **Built-in Copilot Stealth Masking:** Automatically masks `chatgpt.com` / `chat.openai.com` as **Copilot** (`https://copilot.microsoft.com`) across the address bar, tab title, window title, tab favicon, hover status bar, and live page DOM/logos while preserving code blocks and user prompts.
- **Multiple Web Engines:** Switch seamlessly between **Chromium (CEF)** and **Microsoft Edge (WebView2)** engines.
- **Horizontal & Vertical Tabs + Tab Groups:** Organize tabs with color-coded collapsible groups, vertical or horizontal layout, and automatic inactive tab unloading to save RAM.
- **Built-in Ad & Tracker Blocker:** Customize filter lists (EasyList, EasyPrivacy, AdGuard, Peter Lowe, NoCoin).
- **Chrome Extension Support:** Load unpacked extensions and install from the Chrome Web Store / Edge Add-ons.
- **Private (Incognito) Browsing & Multiple Profiles:** Browse in isolated sessions or switch user profiles.
- **Smart OmniBox Address Bar:** Instant search suggestions, inline math calculator, unit/currency conversions, definitions, and page translation.
- **Full Browser Suite:** Built-in Downloads manager (`slbr://downloads`), History (`slbr://history`), Favourites/Bookmarks (`slbr://favourites`), Settings (`slbr://settings`), DevTools (`F12`), PDF viewer, screenshots, and dark/light themes.

---

## Customizing the Logo / Icon Later

To replace the browser logo/icon:
1. Replace **`SLBr\Resources\SLBr.ico`** with your custom `.ico` file (keep the filename `SLBr.ico`).
2. Rebuild with `dotnet build SLBr\SLBr.csproj -c Release`.

---

## License & Credits

Based on [SLT-World/SLBr](https://github.com/SLT-World/SLBr) under the [GNU General Public License v3.0](LICENSE), adapted to build and run out-of-the-box with standard `.NET 8` / `.NET 9+` CLI (`dotnet`) without requiring Visual Studio COM interop tasks or external secret files.
