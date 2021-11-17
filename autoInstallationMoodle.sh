#!/bin/bash

 #
 # Copyright 2021 Mirlind Dalipi.
 #
 # Licensed under the Apache License, Version 2.0 (the "License");
 # you may not use this file except in compliance with the License.
 # You may obtain a copy of the License at
 #
 #      http://www.apache.org/licenses/LICENSE-2.0
 #
 # Unless required by applicable law or agreed to in writing, software
 # distributed under the License is distributed on an "AS IS" BASIS,
 # WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 # See the License for the specific language governing permissions and
 # limitations under the License.
 #

if [[ $(/usr/bin/id -u) -ne 0 ]]; then # only executeable as a root
    echo "Not running as root, please start as root."
    exit
fi

function detect_OS_ARCH_VER_BITS { # detect which arch the user is on
	ARCH=$(uname -m | sed 's/x86_//;s/i[3-6]86/32/')
	if [ -f /etc/lsb-release ]; then
	    . /etc/lsb-release
	    OS=$DISTRIB_ID
	    VER=$DISTRIB_RELEASE
	elif [ -f /etc/debian_version ]; then
	    OS=Debian  # XXX or Ubuntu??
	    VER=$(cat /etc/debian_version)
	    SVER=$( cat /etc/debian_version | grep -oP "[0-9]+" | head -1 )
	elif [ -f /etc/centos-release ]; then
		OS=CentOS
		VER=$( cat /etc/centos-release | grep -oP "[0-9]+" | head -1 )
	else
	    OS=$(uname -s)
	    VER=$(uname -r)
	fi
	case $(uname -m) in
	x86_64)
	    BITS=64
	    ;;
	i*86)
	    BITS=32
	    ;;
	armv*)
	    BITS=32
	    ;;
	*)
	    BITS=?
	    ;;
	esac
	case $(uname -m) in
	x86_64)
	    ARCH=x64  # or AMD64 or Intel64 or whatever
	    ;;
	i*86)
	    ARCH=x86  # or IA32 or Intel32 or whatever
	    ;;
	*)
	    # leave ARCH as-is
	    ;;
	esac
}

declare OS ARCH VER BITS

detect_OS_ARCH_VER_BITS

export OS ARCH VER BITS

if [ "$BITS" = 32 ]; then
	echo -e "Your system architecture is $ARCH which is unsupported to run this installer. \nYour OS: $OS \nOS Version: $VER"
	echo
	printf "\e[1;31mPlease install an aarch64 (64 Bit) System.\e[0m\n"
	rm autoInstallationMoodle.sh
	exit 1
fi

if [ "$OS" = "Ubuntu" ]; then
	if [ "$VER" = "12.04" ]; then
		supported=0
	elif [ "$VER" = "14.04" ]; then
		supported=0
	elif [ "$VER" = "16.04" ]; then
		supported=0
	elif [ "$VER" = "16.10" ]; then
		supported=0
	elif [ "$VER" = "17.04" ]; then
		supported=0
	elif [ "$VER" = "17.10" ]; then
		supported=0
	elif [ "$VER" = "18.04" ]; then
		supported=1
	elif [ "$VER" = "18.10" ]; then
		supported=0
		VER=18.04
		echo -e "Using Ubuntu 19.04 Installation scripts.\nIf the installation fails come to my desk."
		sleep 5
	elif [ "$VER" = "19.04" ]; then
		supported=0
	elif [ "$VER" = "19.10" ]; then
		supported=0
		VER=19.04
		echo -e "Using Ubuntu 19.04 Installation scripts.\nIf the installation fails come to my desk."
		sleep 5
	elif [ "$VER" = "20.04" ]; then
		supported=1
	elif [ "$VER" = "20.10" ]; then
		supported=0
	elif [ "$VER" = "21.04" ]; then
		supported=0
		VER=20.10
		echo -e "Using Ubuntu 19.04 Installation scripts.\nIf the installation fails come to my desk."
		sleep 5
	else
		supported=0
	fi
fi

if [ "$OS" = "LinuxMint" ]; then # sorry, no clue about how LinuxMint works.
	SVER=$( echo $VER | grep -oP "[0-9]+" | head -1 )
	if [ "$SVER" = "18" ]; then
		supported=0
	elif [ "$SVER" = "17" ]; then
		supported=0
	elif [ "$SVER" = "2" ]; then
		supported=0
	else
		supported=0
	fi
fi

if [ "$supported" = 0 ]; then
	echo -e "Your OS $OS $VER $ARCH looks unsupported to run this Script. \nExiting..."
	printf "\e[1;31mCome to my desk and show me a screenshot of the error warning, we'll find out what we can do.\e[0m\n"
	rm autoInstallationMoodle.sh
	exit 1
fi

if [ "$OS" = "Linux" ]; then
	echo -e "Your OS $OS $VER $ARCH probably can run this Script. \nCome to my desk and show me a screenshot of the error warning, we'll find out what we can do."
	rm autoInstallationMoodle.sh
	exit 1
fi

echo -e "Welcome to Moodle Server Installer. \nWould you like to continue? \nYour OS: $OS \nOS Version: $VER \nArchitecture: $ARCH"

while true; do
    read -p "[y/n]: " yn
    case $yn in
        [Yy]* ) clear; echo Running Moodle autoinstaller; sleep 2; break;;
        [Nn]* ) echo Quitting...; rm autoInstallationMoodle.sh && exit;;
        * ) echo "Couldn't get that, please type [y] for Yes or [n] for No.";;
    esac
done

echo "This installer will download all of the required packages for the Moodle Installer. It will use some of space. This might take awhile to download if you do not have a good internet connection."
echo ""
read -n 1 -s -p "Press any key to continue..."
	echo ""
	echo "habe hunger"
    sleep 1
	echo "Preparing..."
apt update 
echo "Upgrading all packages"
sleep 1
apt upgrade -y
apt install graphviz aspell ghostscript clamav git -y
apt update
apt install mysql-server mysql-client -y
apt update
apt install apache2 php libapache2-mod-php php-cli php-mysql php-mbstring php-xmlrpc php-zip -y
apt install php-gd php-xml php-bcmath php-ldap php-pspell  php-curl php-intl php-soap -y
echo "Done!"
echo "restarting apache2..."
sleep 1
service apache2 restart
echo "Creating temp folders and downloading moodle..."
sleep 1
mkdir /home/temp
cd /home/temp
wget https://download.moodle.org/stable311/moodle-latest-311.tgz
tar -zxvf moodle-lastest-311.tgz
cp moodle /var/www/html/ -R
chown www-data.www-data /var/www/html/moodle -R
chmod 0755 /var/www/html/moodle -R
sleep 1
mkdir /var/www/moodledata
chown www-data /var/www/moodledata -R
chmod 0770 /var/www/moodledata -R
echo "Installation finished. Now you've to setup the mysql database"
echo "Also go to the site: 127.0.0.1/moodle to setup the web installer."
echo "Created and maintained by Mirlind Dalipi"
sleep 1
rm autoInstallationMoodle.sh
exit 1
