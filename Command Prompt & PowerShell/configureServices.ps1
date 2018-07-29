Write-Host "Stopping and disabling Maps Broker..."
Stop-Service "MapsBroker"
Set-Service "MapsBroker" -StartupType Disabled

Write-Host "Stopping and disabling Payments and NFC/SE Manager..."
Stop-Service "SEMgrSvc"
Set-Service "SEMgrSvc" -StartupType Disabled

Write-Host "Stopping and disabling Phone Service..."
Stop-Service "PhoneSvc"
Set-Service "PhoneSvc" -StartupType Disabled

Write-Host "Stopping and disabling Xbox Live Auth Manager..."
Stop-Service "XblAuthManager"
Set-Service "XblAuthManager" -StartupType Disabled