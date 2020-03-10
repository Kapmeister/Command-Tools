@echo off
REM
REM Ideally this should be run with administrator rights. 
REM
if .%TMP%. == .. goto NoTmp
cd %TMP%
attrib -r -a -s -h *.*
echo Y | del *.*
for /d %%x in (*.*) do rd /s /q "%%x"
goto end
:NoTmp
echo The System Variable TMP is not set
echo Nothing was deleted. 
:end
