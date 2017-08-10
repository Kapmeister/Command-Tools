@echo off
cd %TMP%
attrib -r -a -s -h *.*
echo Y | del *.*
for /d %%x in (*.*) do rd /s /q "%%x"
