get-content $env:MFS_DEPLOYMENT_PATH\$env:ticketnum\git_status_output1.txt | %{$_ -replace " M ","$env:MFS_MFC_PATH\"} > $env:MFS_DEPLOYMENT_PATH\$env:ticketnum\git_status_output2.txt
get-content $env:MFS_DEPLOYMENT_PATH\$env:ticketnum\git_status_output2.txt | %{$_ -replace "/","\"} > $env:MFS_DEPLOYMENT_PATH\$env:ticketnum\git_status_output3.txt
del $env:MFS_DEPLOYMENT_PATH\$env:ticketnum\git_status_output[12].txt
Rename-Item -Path "$env:MFS_DEPLOYMENT_PATH\$env:ticketnum\git_status_output3.txt" -NewName "git_status_output.txt"

Get-Content $env:MFS_DEPLOYMENT_PATH\$env:ticketnum\git_status_output.txt| foreach {
		$out = $out + $_ + " "
		}
		$out| Out-File $env:MFS_DEPLOYMENT_PATH\$env:ticketnum\copyFiles.txt

Clear-Variable out
Get-Content $env:MFS_DEPLOYMENT_PATH\$env:ticketnum\copyFiles.txt | Set-Content -Encoding UTF8NoBOM $env:MFS_DEPLOYMENT_PATH\$env:ticketnum\copyFiles-utf8.txt

exit