sudo apt update 
sudo apt upgrade -y 
sudo apt-get install fail2ban -y 
sudo apt install rsyslog -y
sudo cp /etc/fail2ban/jail.conf /etc/fail2ban/jail.local 
sudo cp "/project/2)SSH_Brute_Force_Attack/fail2bansshconf" /etc/fail2ban/jail.local 
sudo cp "/project/2)SSH_Brute_Force_Attack/sshdconf" /etc/ssh/sshd_config 
sudo service ssh restart
sudo service rsyslog restart
sudo service fail2ban restart
#sudo cat /var/log/auth.log
sudo fail2ban-client status sshd

