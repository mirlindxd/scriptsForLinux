#!/bin/bash
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 
   exit 1
fi
echo "updating ubuntu..."
sleep 1
sudo apt update && sudo apt upgrade -y
echo "installing git, dkms and build-essential..."
sleep 1
sudo apt install git dkms build-essential -y
sleep 1 
cd ~/
git clone https://github.com/morrownr/8812au-20210629
cd 8812au-20210629
sleep 3
echo "-------------------------------------"
echo "--PRESS Y IF IT ASKS YOU TO CONFIRM--"
echo "-------------------------------------"
bash ./install-driver.sh
