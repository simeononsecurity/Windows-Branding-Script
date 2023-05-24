# Continue on error
$ErrorActionPreference = 'silentlycontinue'

# Require elevation for script run
Write-Output "Elevating privileges for this process"
do {} until (Elevate-Privileges SeTakeOwnershipPrivilege)

# Set Directory to PSScriptRoot
if ((Get-Location).Path -ne $PSScriptRoot) {
    Set-Location $PSScriptRoot
}

# Function to create destination folders if needed
function Create-DestinationFolder {
    param([string]$Path)

    if (!(Test-Path -Path $Path)) {
        Write-Host "$Path does not exist, creating..."
        New-Item -Type Directory -Path $Path -Force | Out-Null
    }
}

# Create destination folders if needed
Write-Host "Creating Destination Folders if Needed"
$destinationPaths = @(
    "C:\Windows\Web\Screen\",
    "C:\ProgramData\Microsoft\User Account Pictures",
    "C:\Windows\Web\Wallpaper\Theme1\"
)

$destinationPaths | ForEach-Object {
    Create-DestinationFolder -Path $_
}

# Set Lockscreen
$lockscreenSourcePath = Join-Path -Path $PSScriptRoot -ChildPath ".\Files\Branding\wallpaper.jpg"
$lockscreenDestinationPath = "C:\Windows\Web\Screen\lockscreen.jpg"
Write-Host "Setting Lockscreen"
Copy-Item -Path $lockscreenSourcePath -Destination $lockscreenDestinationPath -Force
Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Personalization" -Name LockScreenImage -Type String -Value $lockscreenDestinationPath -Force

# Set Wallpaper
$wallpaperSourcePath = Join-Path -Path $PSScriptRoot -ChildPath ".\Files\Branding\wallpaper.jpg"
$wallpaperDestinationPath = "C:\Windows\Web\Wallpaper\Theme1\wallpaper.jpg"
Write-Host "Setting Wallpaper"
Copy-Item -Path $wallpaperSourcePath -Destination $wallpaperDestinationPath -Force
Set-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name Wallpaper -Type String -Value $wallpaperDestinationPath -Force

# Set Account Pictures
$userAccountPicturesSourcePath = Join-Path -Path $PSScriptRoot -ChildPath ".\Files\Branding\user*.png"
$userAccountPicturesDestinationPath = "C:\ProgramData\Microsoft\User Account Pictures"
Write-Host "Account Pictures"
Copy-Item -Path $userAccountPicturesSourcePath -Destination $userAccountPicturesDestinationPath -Force
Copy-Item -Path (Join-Path -Path $PSScriptRoot -ChildPath ".\Files\Branding\user*.bmp") -Destination $userAccountPicturesDestinationPath -Force
Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" -Name UseDefaultTile -Type DWORD -Value 1 -Force

# Set OEM Logo
$oemLogoSourcePath = Join-Path -Path $PSScriptRoot -ChildPath ".\Files\Branding\oemlogo.bmp"
$oemLogoDestinationPath = "C:\Windows\System32\oemlogo.bmp"
Write-Host "Setting OEM Logo"
Copy-Item -Path $oemLogoSourcePath -Destination $oemLogoDestinationPath -Force
Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\OEMInformation" -Name Logo -Type String -Value $oemLogoDestinationPath -Force

# Set OEM Information
$oemManufacturer = "SimeonOnSecurity"
$oemModel = "Super Secure Super Optimized PC"
$oemSupportHours = "0800-1800 Central"
$oemSupportPhone = "1-800-555-1234"
$oemSupportURL = "https://simeononsecurity.ch"
Write-Host "Setting OEM Information"
Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\OEMInformation" -Name Manufacturer -Type String -Value $oemManufacturer -Force
Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\OEMInformation" -Name Model -Type String -Value $oemModel -Force
Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\OEMInformation" -Name SupportHours -Type String -Value $oemSupportHours -Force
Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\OEMInformation" -Name SupportPhone -Type String -Value $oemSupportPhone -Force
Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\OEMInformation" -Name SupportURL -Type String -Value $oemSupportURL -Force
Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\OEMInformation" -Name HelpCustomized -Type DWORD -Value 0 -Force

# Set Registered Information
$registeredOwner = "SimeonOnSecurity"
$registeredOrganization = "SimeonOnSecurity"
Write-Host "Setting Registered Information"
Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\OEMInformation" -Name RegisteredOwner -Type String -Value $registeredOwner -Force
Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\OEMInformation" -Name RegisteredOrganization -Type String -Value $registeredOrganization -Force

# Enable Dark Mode
Write-Host "Setting Dark Mode"
$darkModeSettingsPath = "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize"
Set-ItemProperty -Path $darkModeSettingsPath -Name AppsUseLightTheme -Type DWORD -Value 0 -Force
Set-ItemProperty -Path $darkModeSettingsPath -Name SystemUsesLightTheme -Type DWORD -Value 0 -Force
Set-ItemProperty -Path $darkModeSettingsPath -Name ColorPrevalence -Type DWORD -Value 0 -Force
Set-ItemProperty -Path $darkModeSettingsPath -Name EnableTransparency -Type DWORD -Value 1 -Force

# Branding GPOs
Write-Host "Setting Group Policies"
$gpoPath = Join-Path -Path $PSScriptRoot -ChildPath ".\Files\GPO"
Start-Process -NoNewWindow -FilePath ".\Files\LGPO\LGPO.exe" -ArgumentList "/g $gpoPath" -Wait
