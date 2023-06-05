# Setup branding on Windows 10 and Server 2016/2019/2022 Systems

[![VirusTotal Scan](https://github.com/simeononsecurity/Windows-Branding-Script/actions/workflows/virustotal.yml/badge.svg)](https://github.com/simeononsecurity/Windows-Branding-Script/actions/workflows/virustotal.yml)

## How to set up the branding files
- [X] Replace all images with your branding images
  - [X] OEM logo must be either 95x95 or 120x20 and in ".bmp" format
  - [X] Generate the User Image along with 32x32, 40x40, 48x48, 192x192 variants.
  - [X] Generate or copy user image for guest image.
  
## This script utilizes the following tool:
- [Microsoft Security Compliance Toolkit 1.0 - LGPO](https://www.microsoft.com/en-us/download/details.aspx?id=55319)

## How to run the script
### Manual Install:
If manually downloaded, the script must be launched from an administrative powershell in the directory containing all the files from the [GitHub Repository](https://github.com/simeononsecurity/Windows-Branding-Script)
```powershell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Force
Get-ChildItem -Recurse *.ps1 | Unblock-File
.\sos-copybranding.ps1
```
### Automated Install:
The script may be launched from the extracted GitHub download like this:
```powershell
iwr -useb 'https://simeononsecurity.ch/scripts/sosbranding.ps1'|iex
```

## Learn more about [Branding Windows Systems](https://simeononsecurity.ch/github//windows-10-branding/)
