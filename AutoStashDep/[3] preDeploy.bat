@echo off
cd %MFS_MFC_PATH%
set /P ticketnum=Enter Ticket ID: 	
pwsh.exe -executionpolicy remotesigned -File %AUTOSTASHDEP_PATH%\predeploy.ps1
set /p copyFiles=<%MFS_DEPLOYMENT_PATH%\%ticketnum%\copyFiles-utf8.txt
for %%I in (%copyFiles%) do copy %%I %MFS_DEPLOYMENT_PATH%\%ticketnum%\                                                                             

pause
exit