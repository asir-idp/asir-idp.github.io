<#
S-NODE online installation for Windows
version: 20201101
Author: Francisco Vargas Ruiz (https://github.com/fvarrui)
#>

If ([System.Security.Principal.WindowsIdentity]::GetCurrent().Groups -NotContains "S-1-5-32-544") {
    $Host.UI.WriteErrorLine("Must be run as administrator")
    Exit 1
}

# Checks if Chocolatey is installed
function Test-ChocoInstalled() {
    Write-Host -NoNewline "Checking if Chocolatey is installed ... "
    $ChocoInstalled = $false
    if (Get-Command choco.exe -ErrorAction SilentlyContinue) {
        $ChocoInstalled = $true
        Write-Host "[INSTALLED]"
    } else {
        Write-Host "[NOT INSTALLED]"
    }
    return $ChocoInstalled
}

# Installs Chocolatey
function Install-Choco() {
    If (-Not (Test-ChocoInstalled)) {
        Write-Host "Installing Chocolatey..."
        Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
    }
}

# Installs a package with Chocolatey
function Install-Package([string]$package) {
    Write-Host -NoNewline "Installing $package ... "
    choco install --ignore-checksum -y $package | Out-Null
    If ($LASTEXITCODE -eq 0) {
        Write-Host "[Ok]"
    } else {
        Write-Host "[Error]"
    }
}


Write-Host "[0/5.INFO] S-NODE online installation for Windows (v20211101)"

Write-Host "[1/5.INFO] Installing PACKAGES..."

Install-Choco

Install-Package ngrok

Install-Package openssh

Write-Host "[2/5.INFO] Config OpenSSH as a service"
& "${env:ProgramFiles}\OpenSSH-Win64\install-sshd.ps1" | Out-Null

Write-Host "[3/5.INFO] Config auto and running ssh service"
Set-Service sshd -StartupType Automatic
Start-Service sshd

Write-Host "[4/5.INFO] Opening TCP port 22 in Windows Firewall"
& "netsh" "advfirewall" "firewall" "add" "rule" "name=SSH TCP port 22" "dir=in" "action=allow" "protocol=TCP" "localport=22" | Out-Null

Write-Host "[5/5.INFO] Finish!"