sudo apt update 
sudo apt upgrade -y 
# Installing a terminal browser
sudo apt-get install lynx -y
# Finding out the worker1IP
network=$(ifconfig | grep inet |  sed -n 1p | awk "{print \$2}" | cut -f 1-3 -d "."  | sed 's/$/.*/')    
worker1IP=$(nmap -sP $network | grep worker_1 | awk '{print $NF}' | tr -d '()')
# Local Forwarding
#connecting via ssh to worker1 and asking to forward 
#the service (apache) from his 80 port to master's 5000 port
ssh  docker@$worker1IP -L 5000:$worker1IP:80 
#after that if we login to master node in a NEW TAB and lynx localhost:5000 
#we' ll see the worker's1 service accessible inside the master node