@echo off
rem PhotoSv installer payload (run by the self-extracting PhotoSv-Setup.exe).
rem Installed (non-portable) mode: settings live in %APPDATA%\PhotoSv.
setlocal
set APPDIR=%LocalAppData%\Programs\PhotoSv
mkdir "%APPDIR%" 2>nul
copy /y "%~dp0photosv.exe" "%APPDIR%\photosv.exe" >nul
if errorlevel 1 (
  echo PhotoSv: could not write to "%APPDIR%".
  echo Close any running PhotoSv and run this installer again.
  pause
  exit /b 1
)
powershell -NoProfile -ExecutionPolicy Bypass -Command "$s = New-Object -ComObject WScript.Shell; $sm = [IO.Path]::Combine($s.SpecialFolders('Programs'), 'PhotoSv.lnk'); $l = $s.CreateShortcut($sm); $l.TargetPath = [IO.Path]::Combine($env:LocalAppData, 'Programs\PhotoSv\photosv.exe'); $l.WorkingDirectory = [IO.Path]::Combine($env:LocalAppData, 'Programs\PhotoSv'); $l.IconLocation = [IO.Path]::Combine($env:LocalAppData, 'Programs\PhotoSv\photosv.exe') + ',0'; $l.Save(); $dk = [IO.Path]::Combine($s.SpecialFolders('Desktop'), 'PhotoSv.lnk'); $d = $s.CreateShortcut($dk); $d.TargetPath = $l.TargetPath; $d.WorkingDirectory = $l.WorkingDirectory; $d.IconLocation = $l.IconLocation; $d.Save()"
echo PhotoSv installed to "%APPDIR%" (Start Menu + Desktop shortcuts created).
