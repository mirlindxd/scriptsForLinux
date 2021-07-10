#!/bin/bash
if [ "$EUID" -ne 0 ]
  then echo "Please run as root and not as sudo!"
  exit
fi
echo "installing ufw for opening ports for the minecraft server and other needed tools..."
sudo apt install ufw wget -y
sudo ufw allow 25565
sudo apt update && sudo apt upgrade -y
echo done installed dependencies
cd /home/$username
mkdir minecraft
cd minecraft
echo downloading now minecraft paperspigot 1.17...
wget https://papermc.io/api/v2/projects/paper/versions/1.17/builds/49/downloads/paper-1.17-49.jar
echo done
touch eula.txt
echo eula=true >> eula.txt
touch startMC.sh && echo java -Xmx1024M -Xms1024M -jar paper-1.17-49.jar >> startMC.sh
bash startMC.sh
