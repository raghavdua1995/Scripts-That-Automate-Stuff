Write-Host "Stopping and disabling Maps Broker Service..."
Stop-Service "MapsBroker"
Set-Service "MapsBroker" -StartupType Disabled

Write-Host "Stopping and disabling Payments and NFC/SE Manager Service..."
Stop-Service "SEMgrSvc"
Set-Service "SEMgrSvc" -StartupType Disabled

Write-Host "Stopping and disabling Phone Service..."
Stop-Service "PhoneSvc"
Set-Service "PhoneSvc" -StartupType Disabled

Write-Host "Stopping and disabling Xbox Live Auth Manager Service ..."
Stop-Service "XblAuthManager"
Set-Service "XblAuthManager" -StartupType Disabled

Write-Host "Stopping and disabling Xbox Game Monitoring Service..."
Set-ItemProperty -Path "HKLM:\System\CurrentControlSet\Services\xbgm" -Name "Start" -Type DWord -Value 4

Write-Host "Xbox Live Game Save Service..."
Stop-Service "XblGameSave"
Set-Service "XblGameSave" -StartupType Disabled

Write-Host "Stopping and disabling Xbox Live Networking Service..."
Stop-Service "XboxNetApiSvc"
Set-Service "XboxNetApiSvc" -StartupType Disabled