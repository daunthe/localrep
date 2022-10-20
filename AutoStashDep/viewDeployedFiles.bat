@echo off

cd %WINSCP_PATH%
set /P ticketnum=Enter Ticket ID: 	
winscp.com /ini=nul /script=%AUTOSTASHDEP_PATH%\winscpViewDeployed.txt

pause
exit