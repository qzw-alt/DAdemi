$taskName = "Demi-AutoBackup"
Unregister-ScheduledTask -TaskName $taskName -Confirm:$false -ErrorAction SilentlyContinue
$trigger1 = New-ScheduledTaskTrigger -Daily -At "00:00"
$trigger2 = New-ScheduledTaskTrigger -Daily -At "06:00"
$trigger3 = New-ScheduledTaskTrigger -Daily -At "12:00"
$trigger4 = New-ScheduledTaskTrigger -Daily -At "18:00"
$action = New-ScheduledTaskAction -Execute "powershell.exe" -Argument "-ExecutionPolicy Bypass -File C:\Users\csdm2\.openclaw\workspace\scripts\backup-to-github.ps1"
Register-ScheduledTask -TaskName $taskName -Trigger @($trigger1,$trigger2,$trigger3,$trigger4) -Action $action -Description "Demi auto backup to GitHub every 6 hours" -RunLevel Highest
Write-Host "Done"
