 #
 # Copyright 2022 Mirlind Dalipi.
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
