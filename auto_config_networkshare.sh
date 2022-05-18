sudo ip addr add 192.168.0.1/24 dev enp3s0f0
sudo iptables -A FORWARD -o wlxdc4ef405c8dd -i enp3s0f0 -s 192.168.0.0/24 -m conntrack --ctstate NEW -j ACCEPT
sudo iptables -A FORWARD -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT
sudo iptables -t nat -F POSTROUTING
sudo iptables -t nat -A POSTROUTING -o wlxdc4ef405c8dd -j MASQUERADE
sudo iptables-save | sudo tee /etc/iptables.sav
sudo sh -c "echo 1 > /proc/sys/net/ipv4/ip_forward"
sudo echo "net.ipv4.conf.default.forwarding=1" > /etc/sysctl.conf
sudo echo "net.ipv4.conf.all.forwarding=1" >> /etc/sysctl.conf
sudo echo "net.ipv4.ip_forward=1" >>> /etc/sysctl.conf
echo finished lol
