choco install git.install tortoise-git winscp.install putty.install vlc ccleaner dashlane vscode kindle wireshark anki teamviewer -Y

schtasks /Create /tn "chocolateyUpdatePackages" /SC WEEKLY /D SUN /tr "C:\chocoPackagesUpgrade.bat" /ST 10:00 /RL HIGHEST