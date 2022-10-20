echo y | rmdir /s %MFS_MFC_PATH%
cd %MFS_STASH_PATH%
git clone %MFS_STASH_URL%
pause