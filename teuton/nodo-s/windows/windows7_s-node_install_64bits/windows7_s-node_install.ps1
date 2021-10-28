<#
Windows 7 S-NODE installation
version: 20211028
Author: Francisco Vargas Ruiz (https://github.com/fvarrui)
#>

If ([System.Security.Principal.WindowsIdentity]::GetCurrent().Groups -NotContains "S-1-5-32-544") {
    $Host.UI.WriteErrorLine("Must be run as administrator")
    Exit 1
}

function Unzip-File($zipFile, $destFolder) {
    & "$env:ProgramFiles\7-Zip\7z" "e" "-y" "-o$destFolder" "$zipFile" | Out-Null
}

function Install-7zip() {
    If (Test-Path "$env:ProgramFiles\7-zip") {
        Write-Host "7-Zip already installed"
    } else {
        Write-Host "Installing 7-Zip ..."
        Start-Process ".\7z1900-x64.msi" -ArgumentList "/passive" -Wait
    }
}

function Install-ngrok() {
    If (Test-Path "$env:ProgramFiles\ngrok\ngrok.exe") {
        Write-Host "ngrok for Windows already installed"
    } else {
        Write-Host "Installing ngrok for Windows ..."
        New-Item -ItemType Directory "$env:ProgramFiles\ngrok" | Out-Null
        Unzip-File "ngrok-stable-windows-amd64.zip" "$env:ProgramFiles\ngrok"
        [Environment]::SetEnvironmentVariable("Path", $env:Path + ";" + "$env:ProgramFiles\ngrok", "Machine")
    }
}

function Install-OpenSSH() {
    If (Test-Path "$env:ProgramFiles\OpenSSH-Win64") {
        Write-Host "OpenSSH-Win64 for Windows already installed"
    } else {
        $file = "OpenSSH-Win64.zip"
        Write-Host "Unzipping OpenSSH..."
        Unzip-File $file "$env:ProgramFiles\OpenSSH-Win64"
    }
}

Write-Host "[0/5.INFO] WINDOWS 7 S-NODE installation"

Write-Host "[1/5.INFO] Installing PACKAGES..."

Install-7zip

Install-ngrok

Install-OpenSSH

Write-Host "[2/5.INFO] Config OpenSSH as a service"
& "$env:ProgramFiles\OpenSSH-Win64\install-sshd.ps1" | Out-Null

Write-Host "[3/5.INFO] Config auto and running ssh service"
Set-Service sshd -StartupType Automatic
Start-Service sshd

Write-Host "[4/5.INFO] Opening TCP port 22 in Windows Firewall"
& "netsh" "advfirewall" "firewall" "add" "rule" "name=SSH TCP port 22" "dir=in" "action=allow" "protocol=TCP" "localport=22" | Out-Null

Write-Host "[5/5.INFO] Finished!"