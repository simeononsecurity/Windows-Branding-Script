Write-Host "Setting Lockscreen"
copy-item -Path .\Files\Branding\wallpaper.jpg -Destination C:\Windows\Web\Screen\lockscreen.jpg -Force
Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Personalization" -Name LockScreenImage -Type String -Value "C:\Windows\Web\Screen\lockscreen.jpg" -Force

Write-Host "Setting Wallpaper"
copy-item -Path .\Files\Branding\wallpaper.jpg -Destination C:\Windows\Web\Wallpaper\Theme1\wallpaper.jpg -Force
Set-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name Wallpaper -Type String -Value "C:\Windows\Web\Wallpaper\Theme1\wallpaper.jpg" -Force

Write-Host "Account Pictures"
copy-item -Path .\Files\Branding\user*.png -Destination "C:\ProgramData\Microsoft\User Account Pictures" -Force
copy-item -Path .\Files\Branding\user*.bmp -Destination "C:\ProgramData\Microsoft\User Account Pictures" -Force
Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" -Name UseDefaultTile -Type DWORD -Value "1" -Force

Write-Host "Setting OEM Logo"
copy-item -Path .\Files\Branding\oemlogo.bmp -Destination "C:\Windows\System32\" -Force
Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\OEMInformation" -Name Logo -Type String -Value "C:\Windows\System32\oemlogo.bmp" -Force

Write-Host "Setting OEM Information"
Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\OEMInformation" -Name Manufacturer -Type String -Value "SimeonOnSecurity" -Force
Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\OEMInformation" -Name Model -Type String -Value "Super Secure Super Optimized PC" -Force
Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\OEMInformation" -Name SupportHours -Type String -Value "0800-1800 Central" -Force
Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\OEMInformation" -Name SupportPhone -Type String -Value "1-800-555-1234" -Force
Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\OEMInformation" -Name SupportURL -Type String -Value "https://simeononsecurity.ch" -Force
Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\OEMInformation" -Name HelpCustomized -Type DWORD -Value "0" -Force

Write-Host "Setting Registered Information"
Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\OEMInformation" -Name RegisteredOwner -Type String -Value "SimeonOnSecurity" -Force
Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\OEMInformation" -Name RegisteredOrganization -Type String -Value "SimeonOnSecurity" -Force

##Enable Dark Mode
Write-Host "Setting Dark Mode"
Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize" -Name AppsUseLightTheme -Type DWORD -Value "00000000" -Force
Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize" -Name SystemUsesLightTheme -Type DWORD -Value "00000000" -Force
Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize" -Name ColorPrevalence -Type DWORD -Value "00000000" -Force
Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize" -Name EnableTransparency -Type DWORD -Value "00000001" -Force

#Branding GPOs
Write-Host "Setting Group Policies"
.\Files\LGPO\LGPO.exe /g .\Files\GPO
