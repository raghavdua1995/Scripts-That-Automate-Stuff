%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe -executionpolicy bypass -File configurePrivacySettings.ps1

call configureNetworkSettings.bat
call installChocolatey.bat
call installChocolateyPackages.bat
call registry-tweaks.reg
call putty-config.reg
call winscp-config.reg

%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe -executionpolicy bypass -File systemSettings.ps1

%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe -executionpolicy bypass -File configureServices.ps1

mkdir "%USERPROFILE%\Source Code"
mkdir "%USERPROFILE%\Source Code\Personal"
mkdir "%USERPROFILE%\Source Code\Widely"