cd ~/
touch wpa_supplicant.conf
echo "wpa_supplicant.conf:" > wpa_supplicant.conf
echo "network = {" >> wpa_supplicant.conf
echo "ssid="ICP-BYOD"" >>> wpa_supplicant.conf
echo "key_mgmt=WPA-EAP" >>>> wpa_supplicant.conf
echo "eap=PEAP" >>>>> wpa_supplicant.conf
echo "identity="name.surname@company.de"" >>>>>> wpa_supplicant.conf
echo "password="no"" >>>>>>> wpa_supplicant.conf
echo "phase2="none"" >>>>>>>> wpa_supplicant.conf
echo "}" >>>>>>>>> wpa_supplicant.conf
clear
echo "moving file..."
mv wpa_supplicant.conf /etc/
echo "enabling now, please enter root password if required..."
sleep 2
sudo wpa_supplicant -B -i wlxdc4ef405c8dd -c /etc/wpa_supplicant.conf
echo "all done!"
clear
