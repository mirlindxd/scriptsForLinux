#!/bin/bash

if [ "$EUID" -ne 1000 ]
  then echo "Please run as a user, you'll be prompted if required."
  exit
fi
systemctl --user restart pipewire-pulse pipewire wireplumber

read -p "Do you use bluetooth headphones and want to restart the bluetooth service too? (requires root)? (yes/no) " yn

case $yn in 
	yes ) echo Restarting bluetooth service...;;
	no ) echo exiting...;
		exit;;
	* ) echo invalid response;
		exit 1;;
esac
sudo systemctl restart bluetooth 

read -p "Do you use EasyEffects? (yes/no) " yn

case $yn in 
	yes ) echo Restarting easyeffects...;;
	no ) echo exiting...;
		exit;;
	* ) echo invalid response;
		exit 1;;
esac

killall easyeffects
easyeffects & 2> /dev/null
disown

echo Done with everything, have a nice day!

