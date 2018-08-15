<#
Thanks jaapbrasser(https://github.com/jaapbrasser) for the BlueLight script
#>

Function Set-BlueLight {
    [cmdletbinding(SupportsShouldProcess = $true)]
    param(
        [Parameter(
            Mandatory = $true, 
            ParameterSetName = 'BlueShift Off'
        )]
        [switch] $DisableBlueLight,
        [Parameter(
            Mandatory = $true, 
            ParameterSetName = 'BlueShift On'
        )]
        [switch] $EnableBlueLight,
        [Parameter(
            Mandatory = $true, 
            ParameterSetName = 'Automatic Off'
        )]
        [switch] $DisableAutomaticSchedule,
        [Parameter(
            Mandatory = $true, 
            ParameterSetName = 'Automatic On'
        )]
        [switch] $EnableAutomaticSchedule,
        [Parameter(
            Mandatory = $false, 
            ParameterSetName = 'BlueShift On'
        )]
        [Parameter(
            Mandatory = $false, 
            ParameterSetName = 'BlueShift Off'
        )]
        [Parameter(
            Mandatory = $false, 
            ParameterSetName = 'Automatic On'
        )]
        [Parameter(
            Mandatory = $false, 
            ParameterSetName = 'Automatic Off'
        )]
        [Parameter(
            Mandatory = $true, 
            ParameterSetName = 'Color Temperature'
        )]
        [ValidateSet('NoShift', 'MinimumShift', 'MediumShift', 'LargeShift', 'MaximumShift')]
        [string] $ColorTemperature
    )

    begin {
        $BlueLightOption = @{
            Off          = [byte[]](2, 0, 0, 0, 147, 250, 216, 91, 185, 109, 210, 1, 0, 0, 0, 0, 67, 66, 1, 0, 208, 10, 2, 198, 20, 202, 236, 227, 222, 149, 183, 155, 233, 1, 0)
            On           = [byte[]](2, 0, 0, 0, 128, 208, 150, 171, 186, 109, 210, 1, 0, 0, 0, 0, 67, 66, 1, 0, 16, 0, 208, 10, 2, 198, 20, 221, 137, 219, 220, 170, 183, 155, 233, 1, 0)
            AutoOn       = [byte[]](2, 0, 0, 0, 89, 63, 239, 213, 232, 109, 210, 1, 0, 0, 0, 0, 67, 66, 1, 0, 2, 1, 202, 20, 14, 21, 0, 202, 30, 14, 7, 0, 207, 40, 188, 62, 202, 50, 14, 16, 46, 54, 0, 202, 60, 14, 8, 46, 46, 0, 0)
            AutoOff      = [byte[]](2, 0, 0, 0, 175, 164, 252, 55, 235, 109, 210, 1, 0, 0, 0, 0, 67, 66, 1, 0, 202, 20, 14, 21, 0, 202, 30, 14, 7, 0, 207, 40, 188, 62, 202, 50, 14, 16, 46, 54, 0, 202, 60, 14, 8, 46, 46, 0, 0)
            NoShift      = [byte[]](2, 0, 0, 0, 255, 124, 43, 3, 82, 107, 210, 1, 0, 0, 0, 0, 67, 66, 1, 0, 2, 1, 202, 20, 14, 21, 0, 202, 30, 14, 7, 0, 207, 40, 168, 70, 202, 50, 14, 16, 46, 49, 0, 202, 60, 14, 8, 46, 47, 0, 0)
            MinimumShift = [byte[]](2, 0, 0, 0, 224, 193, 179, 114, 82, 107, 210, 1, 0, 0, 0, 0, 67, 66, 1, 0, 2, 1, 202, 20, 14, 21, 0, 202, 30, 14, 7, 0, 207, 40, 236, 57, 202, 50, 14, 16, 46, 49, 0, 202, 60, 14, 8, 46, 47, 0, 0)
            MediumShift  = [byte[]](2, 0, 0, 0, 49, 229, 185, 33, 82, 107, 210, 1, 0, 0, 0, 0, 67, 66, 1, 0, 2, 1, 202, 20, 14, 21, 0, 202, 30, 14, 7, 0, 207, 40, 200, 42, 202, 50, 14, 16, 46, 49, 0, 202, 60, 14, 8, 46, 47, 0, 0)
            LargeShift   = [byte[]](2, 0, 0, 0, 22, 255, 5, 128, 82, 107, 210, 1, 0, 0, 0, 0, 67, 66, 1, 0, 2, 1, 202, 20, 14, 21, 0, 202, 30, 14, 7, 0, 207, 40, 138, 27, 202, 50, 14, 16, 46, 49, 0, 202, 60, 14, 8, 46, 47, 0, 0)
            MaximumShift = [byte[]](2, 0, 0, 0, 199, 91, 231, 198, 81, 107, 210, 1, 0, 0, 0, 0, 67, 66, 1, 0, 2, 1, 202, 20, 14, 21, 0, 202, 30, 14, 7, 0, 207, 40, 208, 15, 202, 50, 14, 16, 46, 49, 0, 202, 60, 14, 8, 46, 47, 0, 0)
        }
        $SetRegistrySplat = @{
            Path  = 'HKCU:\Software\Microsoft\Windows\CurrentVersion\CloudStore\Store\Cache\DefaultAccount\{0}\Current'
            Force = $true
            Name  = 'Data'
        }
        function Set-RegistryValue {
            if (-not (Test-Path -Path $SetRegistrySplat.Path)) {
                if ($PSCmdlet.ShouldProcess($SetRegistrySplat.Path, 'Creating registry key')) {
                    $null = New-Item -Path $SetRegistrySplat.Path -Force
                }
            }
        
            if ($PSCmdlet.ShouldProcess($SetRegistrySplat.Path, 'Updating registry value')) {
                $null = Set-ItemProperty @SetRegistrySplat
            }
        }
    }

    process {
        switch ($PsCmdlet.ParameterSetName) {
            'BlueShift Off' {
                $SetRegistrySplat.Path = $SetRegistrySplat.Path -f '$$windows.data.bluelightreduction.bluelightreductionstate'
                $SetRegistrySplat.Value = $BlueLightOption.Off
                Set-RegistryValue
            }
            'BlueShift On' {
                $SetRegistrySplat.Path = $SetRegistrySplat.Path -f '$$windows.data.bluelightreduction.bluelightreductionstate'
                $SetRegistrySplat.Value = $BlueLightOption.On
                Set-RegistryValue
            }
            'Automatic Off' {
                $SetRegistrySplat.Path = $SetRegistrySplat.Path -f '$$windows.data.bluelightreduction.settings'
                $SetRegistrySplat.Value = $BlueLightOption.AutoOff
                Set-RegistryValue
            }
            'Automatic On' {
                $SetRegistrySplat.Path = $SetRegistrySplat.Path -f '$$windows.data.bluelightreduction.settings'
                $SetRegistrySplat.Value = $BlueLightOption.AutoOn
                Set-RegistryValue
            }
            {$ColorTemperature} {
                $SetRegistrySplat.Path = $SetRegistrySplat.Path -f '$$windows.data.bluelightreduction.settings'
                $SetRegistrySplat.Value = $BlueLightOption.$ColorTemperature
                Set-RegistryValue
            }
        }
    }
}

Write-Host "Setting Blue light filter..."
Set-BlueLight -EnableAutomaticSchedule

Write-Host "Enabling automatic updates for other Microsoft products..."
$mu = New-Object -ComObject Microsoft.Update.ServiceManager -Strict 
$mu.AddService2("7971f918-a847-4430-9279-4a52d1efe18d", 7, "")

Write-Host "Setting application defaults..."
dism /online /Import-DefaultAppAssociations:"defaultAppAssociations.xml"

Write-Host "Disabling automatic settings sync..."
New-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\SettingSync" -Name DisableSettingSync -Type DWord -Value 00000002
New-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\SettingSync" -Name DisableSettingSyncUserOverride -Type DWord -Value 00000001

Write-Host "Disabling Game Mode..."
Set-ItemProperty -Path "HKCU:\Software\Microsoft\GameBar" -Name AllowAutoGameMode -Type DWord -Value 00000000
Set-ItemProperty -Path "HKCU:\Software\Microsoft\GameBar" -Name AutoGameModeEnabled -Type DWord -Value 00000000

Write-Host "Disabling Game Bar..."
New-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\GameDVR" -Name AppCaptureEnabled -Type DWord -Value 00000000
Set-ItemProperty -Path "HKCU:\System\GameConfigStore" -Name GameDVR_Enabled -Type DWord -Value 00000000

Write-Host "Disabling App Suggestions in Start Menu..."
Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name SystemPaneSuggestionsEnabled -Type DWord -Value 0
Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name SilentInstalledAppsEnabled -Type DWord -Value 0

Write-Host "Disabling Preloading Of Microsoft Edge..."
Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\MicrosoftEdge\Main" -Name AllowPrelaunch -Type DWord -Value 0
Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\MicrosoftEdge\Main" -Name AllowTabPreloading -Type DWord -Value 0
