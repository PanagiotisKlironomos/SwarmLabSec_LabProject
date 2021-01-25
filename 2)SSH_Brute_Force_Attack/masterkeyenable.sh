clear
echo "Applying SSH Configuration to allow only keys"
network=$(ifconfig | grep inet |  sed -n 1p | awk "{print \$2}" | cut -f 1-3 -d "."  | sed 's/$/.*/')    
worker1IP=$(nmap -sP $network | grep worker_1 | awk '{print $NF}' | tr -d '()')
ssh-keygen -t rsa
#(path kai kwdiko enter+enter)
ssh-copy-id docker@$worker1IP
ssh docker@$worker1IP
bash
sudo cp /project/2)SSH_Brute_Force_Attack/sshdconfrsa /etc/ssh/sshd_config 
sudo service ssh restart
exit
exit
echo "Configuration Finished!"
