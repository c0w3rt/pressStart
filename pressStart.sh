#!/bin/bash

echo ' ██████╗░██████╗░███████╗░██████╗░██████╗  ░██████╗████████╗░█████╗░██████╗░████████╗'
echo ' ██╔══██╗██╔══██╗██╔════╝██╔════╝██╔════╝  ██╔════╝╚══██╔══╝██╔══██╗██╔══██╗╚══██╔══╝'
echo ' ██████╔╝██████╔╝█████╗░░╚█████╗░╚█████╗░  ╚█████╗░░░░██║░░░███████║██████╔╝░░░██║░░░'
echo ' ██╔═══╝░██╔══██╗██╔══╝░░░╚═══██╗░╚═══██╗  ░╚═══██╗░░░██║░░░██╔══██║██╔══██╗░░░██║░░░'
echo ' ██║░░░░░██║░░██║███████╗██████╔╝██████╔╝  ██████╔╝░░░██║░░░██║░░██║██║░░██║░░░██║░░░'
echo ' ╚═╝░░░░░╚═╝░░╚═╝╚══════╝╚═════╝░╚═════╝░  ╚═════╝░░░░╚═╝░░░╚═╝░░╚═╝╚═╝░░╚═╝░░░╚═╝░░░'
echo ' By: C0v3rt                                                    experimental build 0.1'
echo '*** UPDATING ***'
apt update -y
apt full-upgrade -y
apt dist-upgrade -y
echo '*** INSTALLING gdebi ***'
apt install gdebi -y
echo '*** INSTALLING VPN ***'
wget --content-disposition -O ~/Downloads/Mullvad.deb https://mullvad.net/download/app/deb/latest
apt gdebi --n --apt-line ~/Downloads/Mullvad.deb
echo '*** INSTALLING SIGNAL ***'
wget -O- https://updates.signal.org/desktop/apt/keys.asc | gpg --dearmor > signal-desktop-keyring.gpg
cat signal-desktop-keyring.gpg | sudo tee -a /usr/share/keyrings/signal-desktop-keyring.gpg > /dev/null
echo 'deb [arch=amd64 signed-by=/usr/share/keyrings/signal-desktop-keyring.gpg] https://updates.signal.org/desktop/apt xenial main' |\
  tee -a /etc/apt/sources.list.d/signal-xenial.list
apt install -y signal-desktop
echo '*** INSTALLING TOR ***'
apt install tor -y
echo '*** INSTALLING QMMP ***'
apt install qmmp -y
read -p 'Would you like to install Steam [Y/N]?' INP
if [$INP == 'Y']
then
	wget -O ~/Downloads/Steam.deb https://cdn.akamai.steamstatic.com/client/installer/steam.deb
	gdebi --n --apt-line ~/Downloads/Steam.deb
else
	echo 'OK'
fi
echo '*** INSTALLING XWALLPAPER ***'
apt install xwallpaper -y
read -p 'Would you like to install a wallpaper [Y/N]' INP
if [$INP == 'Y']
then
	read -p 'Please enter a link, if blank default will be used:\n' LINK
	if [$LINK == '']
	then
		wget -O ~/Pictures/Default.jpg https://i0.wp.com/images-wixmp-ed30a86b8c4ca887773594c2.wixmp.com/i/81475461-74f7-4961-a5af-ade4ad6c20d6/d764cgn-e2bfd0de-2207-48ea-8d48-f4187ad56e10.jpg
		xwallpaper --zoom ~/Pictures/Default.jpg
	else
		wget -O ~/Pictures/Custom.jpg $LINK
		xwallpaper --zoom ~/Pictures/Custom.jpg
	fi
else
	echo 'OK'
fi
echo '*** INSTALLING SRM ***'
apt install -y secure-delete
echo '*** CLEANING UP ***'
srm -v ~/Downloads/Steam.deb
srm -v ~/Downloads/Mullvad.deb
echo '*** DOWNLOADS PURGED ***'
echo '*** DONE ***'
exit

