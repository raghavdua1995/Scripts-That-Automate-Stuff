C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe -executionpolicy bypass -File configurePrivacySettings.ps1

call configureNetworkSettings.bat
call setProxy.bat
call installChocolatey.bat
call installChocolateyPackages.bat
call registry-tweaks.reg

C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe -executionpolicy bypass -File systemSettings.ps1

C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe -executionpolicy bypass -File configureServices.ps1

mkdir 'C:\Users\me\Source Code'
mkdir 'C:\Users\me\Source Code\Personal'
mkdir 'C:\Users\me\Source Code\Widely'