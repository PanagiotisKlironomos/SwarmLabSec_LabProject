**1worker1-startingApache.sh**

- Εδώ ο worker εγκαθιστά έναν apache server σαν μια υπηρεσία αναφοράς για να δειχθεί το ssh forwarding. Επίσης εγκαθίσταται το lynx που είναι ένας web browser για τερματικά.
  - **sudo apt update**
  - **sudo apt upgrade -y**
  - **sudo apt-get install apache2 -y**
  - **sudo apt-get install lynx -y**
  - **sudo service apache2 start**
  
  Ssh_Forwarding_Worker_ServiceStart 
[![asciicast](https://asciinema.org/a/386187.svg)](https://asciinema.org/a/386187)


  

**2masterLocal.sh**

Εδώ ο master κάνει local ssh forwarding μία υπηρεσίας που &quot;τρέχει&quot; στον worker στην πόρτα 80 στην δική του πόρτα 5000.

- Αφού εγκατασταθεί το lynx και γίνει γνωστή στον master η IP του worker
  - **sudo apt update**
  - **sudo apt upgrade -y**
  - **sudo apt-get install lynx -y**
  - **network=$(ifconfig | grep inet | sed -n 1p | awk &quot;{print \$2}&quot; | cut -f 1-3 -d &quot;.&quot; | sed &#39;s/$/.\*/&#39;)**
  - **worker1IP=$(nmap -sP $network | grep worker\_1 | awk &#39;{print $NF}&#39; | tr -d &#39;()&#39;)**
- Δημιουργείται μια ssh σύνδεση μέσω της οποίας γίνεται forward η υπηρεσία του worker στην πόρτα 80 στον master στην πόρτα 5000.
  - **ssh docker@$worker1IP -L 5000:$worker1IP:80**
- Αν τώρα σε ένα καινούριο τερματικό συνδεθούμε εκ νέου στον master node και τρέξουμε την εντολή **lynx localhost:5000** παρατηρούμε ότι h default σελίδα του apache server που τρέχει στον worker1 είναι διαθέσιμη στον master στην πόρτα 5000



Ssh_Forwarding_Master_LocalForwarding 
[![asciicast](https://asciinema.org/a/386189.svg)](https://asciinema.org/a/386189)







**3workerRemote.sh**

Εδώ ο worker κάνει remote ssh forwarding μία υπηρεσίας που &quot;τρέχει&quot; στην πόρτα 80 στην πόρτα 5002 του master node.

- Αφού εγκατασταθεί το lynx και γίνει γνωστή στον worker η IP του master
  - **sudo apt update**
  - **sudo apt upgrade -y**
  - **sudo apt-get install lynx -y**
  - **network=$(ifconfig | grep inet | sed -n 1p | awk &quot;{print \$2}&quot; | cut -f 1-3 -d &quot;.&quot; | sed &#39;s/$/.\*/&#39;)**
  - **masterIP=$(nmap -sP $network | grep master | awk &#39;{print $NF}&#39; | tr -d &#39;()&#39;)**
- Δημιουργείται μια ssh σύνδεση μέσω της οποίας γίνεται forward η υπηρεσία του worker στην πόρτα 80 στον master στην πόρτα 5002.
  - **ssh -R 5002:localhost:80 docker@$masterIP**
- Αν τώρα σε ένα καινούριο τερματικό συνδεθούμε εκ νέου στον master node και τρέξουμε την εντολή **lynx localhost:5002** παρατηρούμε ότι h default σελίδα του apache server που τρέχει στον worker1 είναι διαθέσιμη στον master στην πόρτα 5002



Ssh_Forwarding_Worker_RemoteForwarding 
[![asciicast](https://asciinema.org/a/386190.svg)](https://asciinema.org/a/386190)
