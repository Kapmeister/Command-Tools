@echo off
REM
REM This tool changes your network interface between DHCP and fixed IP addresses.
REM Must be run as an administrator. 
REM
SETLOCAL ENABLEEXTENSIONS
set FIP=192.168.0.10
set SNM=255.255.255.0
set DGW=192.168.0.1
set DN1=1.1.1.1
set DN2=1.0.0.1
set INT="LAN"
for /F "tokens=3" %%a in ('netsh interface ipv4 show addresses %INT% ^| find "DHCP enabled"') do set DHCP=%%a
if "%DHCP%"=="Yes" (
	netsh interface ip set address name=%INT% static %FIP% %SNM% %DGW%
	netsh interface ip set dns %INT% static %DN1%
	netsh interface ip add dns %INT% %DN2% index=2
) else (
	netsh interface ip set address name=%INT% dhcp
	netsh interface ip set dns %INT% dhcp
)