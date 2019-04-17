REM  The path to SQLCMD varies according to version, it might not be 110

if "%ACT_MULTI_OPNAME%" == "mount" (

"C:\Program Files\Microsoft SQL Server\110\Tools\Binn\sqlcmd.exe" -b -i "C:\Program Files\Actifio\scripts\masking_test.sql"
IF %ERRORLEVEL% EQU 0 GOTO cleanexit
exit /B 1
)

:cleanexit
exit /B 0
