sudo apt update 
sudo apt upgrade -y 
# Installing a terminal browser
sudo apt-get install lynx -y
# Finding out the masterIP
network=$(ifconfig | grep inet |  sed -n 1p | awk "{print \$2}" | cut -f 1-3 -d "."  | sed 's/$/.*/')    
masterIP=$(nmap -sP $network | grep master | awk '{print $NF}' | tr -d '()')
# Giving access to the remote host (master node)via an ssh connection 
#(docker@172.19.0.2) to a service running in our (worker's 1) port 80 
#and forwarding it to the remote's host (master node) port 5002
ssh -R 5002:localhost:80 docker@$masterIP
#now if we lynx localhost:5002 inside the master node 
#we' ll see the worker's1 service accessible inside the master node