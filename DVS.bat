@echo off
if "%cd%"=="%programdata%\DVS" goto starter
md "%programdata%\DVS" >nul 2>&1
copy "DVS.bat" "%programdata%\DVS\DVS.bat" > nul
copy "DVS.vbs" "%programdata%\DVS\DVS.vbs" > nul
copy "Bginfo.exe" "%programdata%\DVS\Bginfo.exe" > nul
copy "OFF-OFF.bgi" "%programdata%\DVS\OFF-OFF.bgi" > nul
copy "OFF-ON.bgi" "%programdata%\DVS\OFF-ON.bgi" > nul
copy "ON-OFF.bgi" "%programdata%\DVS\ON-OFF.bgi" > nul
copy "ON-ON.bgi" "%programdata%\DVS\ON-ON.bgi" > nul
reg add HKCU\Software\Microsoft\Windows\CurrentVersion\Run /v DVS /t REG_SZ /d "%programdata%\DVS\DVS.vbs" /f > nul
color A
echo Done Setup!
pause
exit
:starter
set Abd=1
set Ali=1
for /f %%a in ('powershell -command "$ProgressPreference = 'SilentlyContinue'; tnc zline.ddns.net -port 3 | findstr /l 'failed'"') do (if "%%a"=="WARNING:" set abd=0)
for /f %%a in ('powershell -command "$ProgressPreference = 'SilentlyContinue'; tnc zline.ddns.net -port 4 | findstr /l 'failed'"') do (if "%%a"=="WARNING:" set ali=0)
if "%Abd%%ali%"=="00" Bginfo.exe OFF-OFF.bgi /timer:0 /silent
if "%Abd%%ali%"=="11" Bginfo.exe ON-ON.bgi /timer:0 /silent
if "%Abd%"=="1" if "%Ali%"=="0" Bginfo.exe ON-OFF.bgi /timer:0 /silent
if "%Abd%"=="0" if "%Ali%"=="1" Bginfo.exe OFF-ON.bgi /timer:0 /silent
goto starter