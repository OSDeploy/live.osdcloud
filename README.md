# live.osdcloud

# Make sure this is not running in PowerShell
Break

#readme.md
#powershell (iwr live.osdcloud.com/README.md -useb).content

#install-psgallery.ps1
#powershell iex(iwr live.osdcloud.com/install-psgallery.ps1 -useb).content

#Set-LocalAppData
#powershell iex(iwr live.osdcloud.com/set-localappdata.ps1 -useb).content

#Test-LocalAppData
#powershell iex(iwr live.osdcloud.com/test-localappdata.ps1 -useb).content