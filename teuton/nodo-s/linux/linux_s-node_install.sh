#!/usr/bin/env bash
# GNU/Linux S-Node Installation
# Version: 20200927
# Author: Francisco Vargas Ruiz (https://github.com/fvarrui)

[ $(whoami) != root ] && echo "[ERROR] Please, run as root" && exit 1

function exists_binary() {
	which $1 > /dev/null
}

CONFIGFILE="/etc/ssh/sshd_config"
BACKUPFILE="$CONFIGFILE.bak"

echo "[0/4.INFO] GNU/Linux S-NODE installation"

echo "[1/4.INFO] Checking distro..."
[ "$distro" = "" ] && exists_binary zypper && distro=opensuse
[ "$distro" = "" ] && exists_binary apt-get && distro=debian
[ "$distro" = "" ] && echo "Unsupported distribution ... exiting!" && exit 1
echo "- $distro distribution found"

echo "[2/4.INFO] Installing PACKAGES..."
[ $distro = "opensuse" ] && zypper install -y openssh
[ $distro = "debian" ] && apt-get install -y openssh-server sudo
exists_binary ngrok || wget -q https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-amd64.zip -O /tmp/ngrok-stable-linux-amd64.zip && unzip /tmp/ngrok-stable-linux-amd64.zip -d /usr/local/bin

echo "[3/4.INFO] Configuring SSH service..."
[ ! -f $BACKUPFILE ] && cp $CONFIGFILE $BACKUPFILE
sed 's/^#PermitRootLogin .*$/PermitRootLogin yes/g' $BACKUPFILE > $CONFIGFILE
systemctl restart sshd
systemctl enable sshd 2> /dev/null

echo "[4/4.INFO] Finish!"