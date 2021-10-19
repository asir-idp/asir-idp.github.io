<#
Windows S-NODE installation
version: 20200927
Author: Francisco Vargas Ruiz (https://github.com/fvarrui)
#>

If ([System.Security.Principal.WindowsIdentity]::GetCurrent().Groups -NotContains "S-1-5-32-544") {
    $Host.UI.WriteErrorLine("Must be run as administrator")
    Exit 1
}

function Unzip-File($zipFile, $destFolder) {
    & "$env:ProgramFiles\7-Zip\7z" "e" "-y" "-o$destFolder" "$zipFile" | Out-Null
}

function Wget-File($url, $file) {
    & "$env:ProgramFiles\wget\wget" "--no-check-certificate" "-O" "$file" "$url"
}

function Install-7zip() {
    If (Test-Path "$env:ProgramFiles\7-zip") {
        Write-Host "7-Zip already installed"
    } else {
        Write-Host "Downloading and installing 7-Zip ..."
        (New-Object System.Net.WebClient).DownloadFile("https://www.7-zip.org/a/7z1900-x64.msi", "$env:windir\temp\7z1900-x64.msi")
        & "$env:windir\temp\7z1900-x64.msi" /passive
    }
}

function Install-Wget() {
    If (Test-Path "$env:ProgramFiles\wget") {
        Write-Host "wget for Windows already installed"
    } else {
        Write-Host "Downloading and installing wget for Windows ..."
        (New-Object System.Net.WebClient).DownloadFile("https://eternallybored.org/misc/wget/releases/old/wget-1.20.3-win64.zip", "$env:windir\temp\wget-1.20.3-win64.zip")
        Unzip-File "$env:windir\temp\wget-1.20.3-win64.zip" "$env:ProgramFiles\wget"
    }
}

function Install-ngrok() {
    If (Test-Path "$env:ProgramFiles\ngrok") {
        Write-Host "ngrok for Windows already installed"
    } else {
        Write-Host "Downloading and installing ngrok for Windows ..."
        (New-Object System.Net.WebClient).DownloadFile("https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-windows-amd64.zip", "$env:windir\temp\ngrok-stable-windows-amd64.zip")
        New-Item -ItemType Directory "$env:ProgramFiles\ngrok" | Out-Null
        Unzip-File "$env:windir\temp\ngrok-stable-windows-amd64.zip" "$env:ProgramFiles\ngrok"
        [Environment]::SetEnvironmentVariable("Path", $env:Path + ";" + "$env:ProgramFiles\ngrok", "Machine")
    }
}

function Install-OpenSSH() {
    If (Test-Path "$env:ProgramFiles\Win32-OpenSSH") {
        Write-Host "Win32-OpenSSH for Windows already installed"
    } else {

        $file = "$env:windir\temp\OpenSSH-Win64.zip"
        $url = "https://github.com/PowerShell/Win32-OpenSSH/releases/download/v8.0.0.0p1-Beta/OpenSSH-Win64.zip"

        Write-Host "Downloading OpenSSH-Win64 from $url to $file..."
        Wget-File $url $file 

        Write-Host "Unzipping OpenSSH..."
        Unzip-File $file "$env:ProgramFiles\OpenSSH-Win64"

    }
}

Write-Host "[0/5.INFO] WINDOWS S-NODE installation"

Write-Host "[1/5.INFO] Installing PACKAGES..."

Install-7zip

Install-Wget

Install-ngrok

Install-OpenSSH

Write-Host "[2/5.INFO] Config OpenSSH as a service"
& "$env:ProgramFiles\OpenSSH-Win64\install-sshd.ps1" | Out-Null

Write-Host "[3/5.INFO] Config auto and running ssh service"
Set-Service sshd -StartupType Automatic
Start-Service sshd

Write-Host "[4/5.INFO] Opening TCP port 22 in Windows Firewall"
& "netsh" "advfirewall" "firewall" "add" "rule" "name=SSH TCP port 22" "dir=in" "action=allow" "protocol=TCP" "localport=22" | Out-Null

Write-Host "[5/5.INFO] Finish!"