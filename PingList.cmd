@setlocal enableextensions enabledelayedexpansion
@echo off
date /t > pinglist.csv
time /t >> pinglist.csv
for /F "tokens=*" %%i in (PingList.txt) do (
	set ipaddr=%%i
	for /f "tokens=9 delims= "  %%a in ('ping -n 5 !ipaddr! ^| find /i "average"') do echo !ipaddr!,%%a >> pinglist.csv
	echo !ipaddr!
)
endlocal