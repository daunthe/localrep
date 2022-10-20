@echo off

set /P MFS_DEPLOYMENT_PATH=Enter Deployment Path:
setx MFS_DEPLOYMENT_PATH "%MFS_DEPLOYMENT_PATH%"

set /P MFS_STASH_PATH=Enter Local Stash Path:
setx MFS_STASH_PATH %MFS_STASH_PATH%

set /P MFS_MFC_PATH=Enter managed-fix-configs Path:
setx MFS_MFC_PATH "%MFS_MFC_PATH%"

set /P MFS_STASH_URL=Enter Master Stash URL:
setx MFS_STASH_URL "%MFS_STASH_URL%"

set /P WINSCP_PATH=Enter WinSCP Path:
setx WINSCP_PATH "%WINSCP_PATH%"

set /P AUTOSTASHDEP_PATH=Enter AutoStashDep Path:
setx AUTOSTASHDEP_PATH "%AUTOSTASHDEP_PATH%"


"%~dp0\permanentVariableView.bat" start