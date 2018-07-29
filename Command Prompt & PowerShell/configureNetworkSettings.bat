powershell.exe Set-NetConnectionProfile -Name "Raghav" -NetworkCategory Private
powershell.exe Set-NetConnectionProfile -Name "Mi Max" -NetworkCategory Private

Netsh WLAN set profileparameter name="Mi Max" Cost="Fixed"

netsh interface ip set dns "WiFi" static 35.200.201.196

