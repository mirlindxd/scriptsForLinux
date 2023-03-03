#!/bin/bash
# Contact me on Discord if you need help with the script or have ideas to improve it: Pure™#0087
# Notice: This script only works for pipewire and wireplumber!
# Only works on systemd systems!

# if [[ `systemctl` =~ -\.mount ]] # check if systemd is being used and exit if not
#   then echo "system runs systemd" 
#   exit
# fi 
# ^^^ need to fix

if [ "$EUID" -ne 1000 ] # for now only the main user
  then echo "Please run as an user, you'll be prompted if required."
  exit
fi
echo Restarting pipewire services...
sleep 1 
systemctl --user restart pipewire-pulse pipewire wireplumber # Restarting all pipewire's required services to mitigate any issues appearing later on
sleep 1
echo "Killing easyeffects as it won't work anymore without restarting it..."
killall easyeffects

read -p "Do you use bluetooth headphones and want to restart the bluetooth service too? (requires root)? (y/n) " yn # Read user input

case $yn in 
	[yY] ) echo Restarting bluetooth service...;;
	[nN] ) echo exiting...; # if no, it just exites and does not goto the easyeffects question... WIP
		exit;;
	* ) echo invalid response;
		exit 1;;
esac
sudo systemctl restart bluetooth 

#read -p "Do you use EasyEffects? (y/n) " yn
#
#case $yn in 
#	[yY] ) echo Restarting easyeffects...;;
#	[yN] ) echo exiting...;
#		exit;;
#	* ) echo invalid response;
#		exit 1;;
# esac

# llall easyeffects # Kills easyeffects application since you cannot open easyeffects after restarting pipewire 

echo Please open EasyEffects from your application launcher, have a nice day!


