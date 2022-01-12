if (Get-Item ENV:LOCALAPPDATA -ErrorAction Ignore)
{
    Return $true
}
else
{
    Return $false
}