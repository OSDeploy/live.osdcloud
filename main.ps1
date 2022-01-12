# https://github.com/OSDeploy/live.osdcloud

# LOCALAPPDATA System Environment Variable
Set-ExecutionPolicy Bypass -Force -Verbose
Get-ExecutionPolicy




if (Get-Item env:LOCALAPPDATA -ErrorAction Ignore)
{
    Write-Verbose -Verbose 'System Environment Variable LOCALAPPDATA is already present in this PowerShell session'
}
else
{
    Write-Verbose 'WinPE does not have the LOCALAPPDATA System Environment Variable'
    Write-Verbose 'This can be enabled for this Power Session, but it will not persist'
    Write-Verbose -Verbose 'Set System Environment Variable LOCALAPPDATA for this PowerShell session'
    [System.Environment]::SetEnvironmentVariable('LOCALAPPDATA',"$env:UserProfile\AppData\Local")
}

# Create PowerShell User Profile Directory
if (!(Test-Path "$env:UserProfile\Documents\WindowsPowerShell")) {
    New-Item -Path "$env:UserProfile\Documents\WindowsPowerShell" -ItemType Directory -Force | Out-Null
}

# Set PowerShell Profile
$PowerShellProfile = @'
Set-ExecutionPolicy RemoteSigned -Force
[System.Environment]::SetEnvironmentVariable('LOCALAPPDATA',"$env:UserProfile\AppData\Local")
'@

if ($env:SystemDrive -eq 'X:')
{
    Write-Verbose 'WinPE does not have the LOCALAPPDATA System Environment Variable'
    Write-Verbose 'This can be enabled for this Power Session, but it will not persist'
    Write-Verbose -Verbose 'Set System Environment Variable LOCALAPPDATA for this PowerShell session'
    $PowerShellProfile | Set-Content -Path "$env:UserProfile\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1" -Force -Encoding Unicode
}





Write-Verbose -Verbose 'Installing PowerShellGet'
#PowerShellGet from PSGallery URL
if (!(Get-Module -Name PowerShellGet)){
    $PowerShellGetURL = "https://psg-prod-eastus.azureedge.net/packages/powershellget.2.2.5.nupkg"
    Invoke-WebRequest -UseBasicParsing -Uri $PowerShellGetURL -OutFile "$env:TEMP\powershellget.2.2.5.zip"
    $Null = New-Item -Path "$env:TEMP\2.2.5" -ItemType Directory -Force
    Expand-Archive -Path "$env:TEMP\powershellget.2.2.5.zip" -DestinationPath "$env:TEMP\2.2.5"
    $Null = New-Item -Path "$env:ProgramFiles\WindowsPowerShell\Modules\PowerShellGet" -ItemType Directory -ErrorAction SilentlyContinue
    Move-Item -Path "$env:TEMP\2.2.5" -Destination "$env:ProgramFiles\WindowsPowerShell\Modules\PowerShellGet\2.2.5"
    }

Write-Verbose -Verbose 'Installing PackageManagement'
#PackageManagement from PSGallery URL
if (!(Get-Module -Name PackageManagement)){
    $PackageManagementURL = "https://psg-prod-eastus.azureedge.net/packages/packagemanagement.1.4.7.nupkg"
    Invoke-WebRequest -UseBasicParsing -Uri $PackageManagementURL -OutFile "$env:TEMP\packagemanagement.1.4.7.zip"
    $Null = New-Item -Path "$env:TEMP\1.4.7" -ItemType Directory -Force
    Expand-Archive -Path "$env:TEMP\packagemanagement.1.4.7.zip" -DestinationPath "$env:TEMP\1.4.7"
    $Null = New-Item -Path "$env:ProgramFiles\WindowsPowerShell\Modules\PackageManagement" -ItemType Directory -ErrorAction SilentlyContinue
    Move-Item -Path "$env:TEMP\1.4.7" -Destination "$env:ProgramFiles\WindowsPowerShell\Modules\PackageManagement\1.4.7"
    }

Write-Verbose -Verbose 'Importing Modules'
Import-Module PowerShellGet -Force
Import-Module PackageManagement -Force



#Register-PSRepository -Name PSGallery -SourceLocation https://www.powershellgallery.com/api/v2/ -InstallationPolicy Trusted
Write-Verbose -Verbose 'Installation Complete'
