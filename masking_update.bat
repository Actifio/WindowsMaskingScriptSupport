REM   For direct mount workflow use     "%ACT_JOBTYPE%" == "mount"

if "%ACT_JOBTYPE%" == "scrub-mount" (

"C:\Program Files\Microsoft SQL Server\110\Tools\Binn\sqlcmd.exe" -b -i "C:\Program Files\Actifio\scripts\masking_test.sql"
IF %ERRORLEVEL% EQU 0 GOTO cleanexit
exit /B 1
)

:cleanexit
exit /B 0
