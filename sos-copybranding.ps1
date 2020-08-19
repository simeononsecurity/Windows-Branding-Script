copy-item -Path .\Files\Branding\wallpaper.jpg -Destination C:\Windows\Web\Screen\lockscreen.jpg -Force
copy-item -Path .\Files\Branding\wallpaper.jpg -Destination C:\Windows\Web\Wallpaper\Theme1\wallpaper.jpg -Force
copy-item -Path .\Files\Branding\oemlogo.bmp -Destination "C:\ProgramData\Microsoft\User Account Pictures" -Force
copy-item -Path .\Files\Branding\user*.png -Destination "C:\ProgramData\Microsoft\User Account Pictures" -Force
copy-item -Path .\Files\Branding\user*.bmp -Destination "C:\ProgramData\Microsoft\User Account Pictures" -Force
Set-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name Wallpaper -Type String -Value C:\Windows\Web\Wallpaper\Theme1\wallpaper.jpg -Force
Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\OEMInformation" -Name Logo -Type String -Value "C:\ProgramData\Microsoft\User Account Pictures\oemlogo.bmp" -Force
##Enable Dark Mode
Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize" -Name AppsUseLightTheme -Type DWORD -Value "00000000" -Force
Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize" -Name SystemUsesLightTheme -Type DWORD -Value "00000000" -Force
Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize" -Name ColorPrevalence -Type DWORD -Value "00000000" -Force
Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize" -Name EnableTransparency -Type DWORD -Value "00000001" -Force

#Branding GPOs
.\Files\LGPO\LGPO.exe /g .\Files\GPO
