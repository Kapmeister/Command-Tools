@setlocal enableextensions enabledelayedexpansion
@echo off
set OFILE=DeviceCount.csv
for /f "tokens=2,3,4 delims=^/ " %%d in ('date /t') do echo %%e/%%d/%%f>dd.txt
for /F usebackq^ delims^=^ eol^= %%j in ("dd.txt") do (< nul set /P ="%%j" > dd.txt)
for /f "tokens=1 delims= " %%t in ('time /t') do echo %%t>tt.txt
for /F usebackq^ delims^=^ eol^= %%k in ("tt.txt") do (< nul set /P ="%%k" > tt.txt)
for /F "tokens=*" %%x in (dd.txt) do (
	for /F "tokens=*" %%y in (tt.txt) do (
		for /f "tokens=6 delims=() " %%z in ('nmap -sn 192.168.0.0/24 ^| find /i "done"') do echo %%x,%%y,%%z>>%OFILE%
	)
)
