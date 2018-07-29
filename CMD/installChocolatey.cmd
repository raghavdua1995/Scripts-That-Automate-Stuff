@"%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" -NoProfile -InputFormat None -ExecutionPolicy Bypass -Command "iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))" && SET "PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin"

copy chocoPackagesUpgrade.bat C:\

schtasks /Create /tn "chocolateyUpdatePackages" /SC WEEKLY /D SUN /tr "C:\chocoPackagesUpgrade.bat" /ST 10:00 /RL HIGHEST