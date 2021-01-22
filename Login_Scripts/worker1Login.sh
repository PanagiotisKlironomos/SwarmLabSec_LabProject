network=$(ifconfig | grep inet |  sed -n 1p | awk "{print \$2}" | cut -f 1-3 -d "."  | sed 's/$/.*/')    
worker1IP=$(nmap -sP $network | grep worker_1 | awk '{print $NF}' | tr -d '()')
ssh docker@$worker1IP  