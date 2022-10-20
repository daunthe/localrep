@echo off
set /P ticketnum=1. Enter Ticket (FTS-XXX):
mkdir %MFS_DEPLOYMENT_PATH%\%ticketnum%

cd %MFS_MFC_PATH%

echo. & echo 2. GIT PULL PHASE
git pull 
pause

echo. & echo 3. GIT DIFF PHASE
git diff
FOR /F "tokens=* USEBACKQ" %%F in (`git diff`) DO (SET gitdiffvar="%%F")
if not defined gitdiffvar (echo No differences found) else (GOTO gitstat)
pause 

:gitstat
echo. & echo 4. GIT STATUS PHASE
git status
REM Call the batch file that will list the differences between master and local repo
git status --porcelain > %MFS_DEPLOYMENT_PATH%\%ticketnum%\git_status_output1.txt
FOR /F "tokens=* USEBACKQ" %%F in (`git status`) DO (SET gitstatvar="%%F")
if gitstatvar=="nothing to commit, working tree clean" (GOTO nothingToCommit) else (GOTO proceed)

REM NOTE: 	GITSTATVAR has a problem which, even if its value is "nothing to commit, working tree clean", it will 
REM 		still not prompt GOTO nothing

:proceed
echo. & echo 5. GIT ADD PHASE
set /P proceedtoStaging="Proceed to Staging Phase? (1=Yes, 0=No): "
if %proceedtoStaging%==1 (GOTO stagingPhase) else (GOTO endProgram)

:stagingPhase
echo Proceeding to Staging Phase...
git add --all
echo. & echo !!Review details before proceeding to commit phase!!
echo. & git status
echo. & echo.Ticket:		%ticketnum% & echo.Staging Phase:	Done & echo.
set doneStaging=1

echo. & echo 6. GIT COMMIT PHASE
set /P proceedtoCommit="Proceed to Commit Phase? (1=Yes, 0=No): "
if %proceedtoCommit%==1 (GOTO commitPhase) else (GOTO endProgram)

:commitPhase
echo.Proceeding to Commit Phase... 
set /P commitMessage="Input your commit message: "
git commit -a -m "%ticketnum%: %commitMessage%"
set doneCommitting=1

echo. & echo 7. GIT PUSH PHASE
set /P proceedtoPush="Proceed to Push Phase? (1=Yes, 0=No): "
if %proceedtoPush%==1 (GOTO pushPhase) else (GOTO endProgram)

:pushPhase
echo.Proceeding to Push Phase... & echo.
git push
set donePushing=1

echo. & echo Staging:		%doneStaging%
echo Committing: 		%doneCommitting%
echo Pushing:		%donePushing%
echo. 

pause 
exit

:nothingToCommit
echo. & echo Nothing has been changed in the local repository. The program will now exit... & echo.
pause
exit

:endProgram
echo. & echo User has decided to not proceed with the last prompted phase. The program will now exit... & echo.
pause
exit