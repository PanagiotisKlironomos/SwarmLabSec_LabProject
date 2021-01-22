#update and upgrade the master node 
# so we can install tcpdump
sudo apt update
sudo apt upgrade -y
sudo apt install tcpdump -y
#extracting worker1IP with ifconfig and inet commands
worker1IP=$(ifconfig | grep inet |  sed -n 1p | awk "{print \$2}" )
clear
# reseting IP tables from past configurations
sudo iptables -F
# Listening to packets with tcpdump for 5 seconds
# We listen to ICMP replies so we can listen after the firewall
echo "Listening to ICMP replies from worker1 for 2 seconds"
sleep 2s
sudo  timeout 2s tcpdump -i eth0 icmp and src $worker1IP
sleep 2s
#Applying Ip Tables Rules
# We are setting a limit to icmp incoming packets to 1 per second
echo "Applying Ip Tables Rules"
sleep 2s
sudo iptables -N icmp_flood  
sudo iptables -A INPUT -p icmp -j icmp_flood  
sudo iptables -A icmp_flood -m limit --limit 1/s --limit-burst 3 -j RETURN  
sudo iptables -A icmp_flood -j DROP 
# Listening to packets with tcpdump for 5 seconds
# We listen to ICMP replies so we can listen after the firewall
echo "Listening to ICMP replies from worker1 for 5 seconds"
sleep 2s
sudo  timeout 5s tcpdump -i eth0 icmp and src $worker1IP
echo "Spot any difference?"