%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe -executionpolicy bypass -File configurePrivacySettings.ps1

call configureNetworkSettings.bat
call installChocolatey.bat
call installChocolateyPackages.bat
call registry-tweaks.reg

%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe -executionpolicy bypass -File systemSettings.ps1

%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe -executionpolicy bypass -File configureServices.ps1

mkdir "%USERPROFILE%\Source Code"
mkdir "%USERPROFILE%\Source Code\Personal"
mkdir "%USERPROFILE%\Source Code\Widely"
mkdir "%USERPROFILE%\Source Code\Pipa • Bella"

echo Install the following applications manually:
echo Adobe Creative Cloud
echo Google Cloud SDK
echo Google Drive
echo Node Version Manager
echo Microsoft Office 365
echo Samsung Magician
echo Slack
echo Spotify Music
echo Termius SSH Client
echo Vivaldi Browser
echo Windows Terminal
echo Zenkit