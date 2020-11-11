<#
Windows PowerShell update
version: 20201111
Author: Francisco Vargas Ruiz (https://github.com/fvarrui)
#>

If ([System.Security.Principal.WindowsIdentity]::GetCurrent().Groups -NotContains "S-1-5-32-544") {
    $Host.UI.WriteErrorLine("Must be run as administrator")
    Exit 1
}

function Unzip-File($zipFile, $destFolder) {
    Install-7zip
    & "$env:ProgramFiles\7-Zip\7z" "e" "-y" "-o$destFolder" "$zipFile" | Out-Null
}

function Install-7zip() {
    If (!(Test-Path "$env:ProgramFiles\7-zip")) {
        Write-Host "Downloading and installing 7-Zip ..."
        (New-Object System.Net.WebClient).DownloadFile("https://www.7-zip.org/a/7z1900-x64.msi", "$env:windir\temp\7z1900-x64.msi")
        & "$env:windir\temp\7z1900-x64.msi" /passive
    }
}

function Get-DotNetFullVersion() {
    return (Get-ChildItem 'HKLM:\SOFTWARE\Microsoft\NET Framework Setup\NDP' -Recurse | Get-ItemProperty -Name version -EA 0 | Where { $_.PSChildName -Match '^(?!S)\p{L}'} | Select PSChildName, version | Where { $_.PSChildName -eq "Full"}).Version
}

function Install-DotNetFramework() {
    $dotNetVersion = Get-DotNetFullVersion
    If ($dotNetVersion -ge "4.5.2") {
        Write-Host ".Net Framework is up to date ($dotNetVersion)"
    } else {
        Write-Host "Downloading and installing .Net Framwork 4.5.2+ for Windows ..."
        (New-Object System.Net.WebClient).DownloadFile("https://download.microsoft.com/download/E/2/1/E21644B5-2DF2-47C2-91BD-63C560427900/NDP452-KB2901907-x86-x64-AllOS-ENU.exe", "$env:windir\temp\NDP452-KB2901907-x86-x64-AllOS-ENU.exe")
        & "$env:windir\temp\NDP452-KB2901907-x86-x64-AllOS-ENU.exe"
    }
}

function Install-WMF() {
    $psVersion = $PSVersionTable.PSVersion.ToString()
    If ($psVersion -ge "5.1") {
        Write-Host "PowerShell is up to date ($psVersion)"
    } else {

        Install-DotNetFramework

        Write-Host "Downloading and installing WMF 5.1 for Windows ..."
        (New-Object System.Net.WebClient).DownloadFile("http://download.microsoft.com/download/6/F/5/6F5FF66C-6775-42B0-86C4-47D41F2DA187/Win7AndW2K8R2-KB3191566-x64.zip", "$env:windir\temp\Win7AndW2K8R2-KB3191566-x64.zip")
        Unzip-File "$env:windir\temp\Win7AndW2K8R2-KB3191566-x64.zip", $env:windir\temp\Win7AndW2K8R2-KB3191566-x64
        & "$env:windir\temp\Win7AndW2K8R2-KB3191566-x64\Install-WMF5.1.ps1"

    }
}

Install-WMF