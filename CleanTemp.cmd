REM
REM Ideally this should be run with administrator rights. 
REM
@echo off
cd %TMP%
attrib -r -a -s -h *.*
echo Y | del *.*
for /d %%x in (*.*) do rd /s /q "%%x"
