**master.sh**

Εδώ ο master node θα κάνει Ddos επίθεση στον worker\_1 node. Το εργαλείο που χρησιμοποιείται για την επίθεση είναι το hping3.

- Αφού γίνει εγκατάσταση του εργαλείου στον master κόμβο
  - **sudo apt update**
  - **sudo apt upgrade -y**
  - **sudo apt install hping3 -y**
- Και αναγνώριση της IP του worker κόμβου από τον master
  - **network=$(ifconfig | grep inet | sed -n 1p | awk &quot;{print \$2}&quot; | cut -f 1-3 -d &quot;.&quot; | sed &#39;s/$/.\*/&#39;)**
  - **worker1IP=$(nmap -sP $network | grep worker\_1 | awk &#39;{print $NF}&#39; | tr -d &#39;()&#39;)**
- Ξεκινάει η επίθεση επ&#39; αόριστον
  - **sudo hping3 -p 80 --flood --icmp $worker1IP**
  
  DDos_Master_Node 




[![asciicast](https://asciinema.org/a/385069.svg)](https://asciinema.org/a/385069)


**worker1.sh**

Εδώ ο worker node εφαρμόζει αντίμετρα στην Ddos επίθεση που δέχεται από τον master node μέσω του εργαλείου iptables και tcpdump (για monitoring).

- Αφού γίνει εγκατάσταση του εργαλείου στον worker κόμβο (το iptables είναι ήδη εγκατεστημένο)
  - **sudo apt update**
  - **sudo apt upgrade -y**
  - **sudo apt install tcpdump -y**
- Και αποθήκευση της IP του worker κόμβου σε μία μεταβλητή
  - **worker1IP=$(ifconfig|grep inet|sed -n 1p|awk &quot;{print \$2}&quot;)**
- Γίνεται reset του configuration του Iptables ώστε να δούμε ξεκάθαρα την επίδραση που έχει η επίθεση που δεχόμαστε.
  - **sudo iptables -F**
- Κάνουμε monitor τις απαντήσεις που στέλνονται από τον worker1 στον master (Icmp replies) για 2 δευτερόλεπτα. Κάνουμε monitor στις απαντήσεις και όχι στα εισερχόμενα ICMP πακέτα διότι ανάμεσα στον worker και στον master παρεμβάλλεται το firewall. Έτσι παρατηρώντας τις απαντήσεις που είναι ισάριθμες των εισερχόμενων πακέτων, έχουμε ξεκάθαρη εικόνα του πλήθους των πακέτων καθώς το firewall βρίσκεται τοπολογικά μετά τον worker και άρα δεν εμπλέκεται στο monitoring των απαντήσεων.
  - **sudo timeout 2s tcpdump -i eth0 icmp and src $worker1IP**
- Εφαρμόζουμε στην συνέχεια κανόνες μέσω του Iptables επιτρέποντας μόνο ένα εισερχόμενο ICMP πακέτο ανά ένα δευτερόλεπτο.
  - **sudo iptables -N icmp\_flood**
  - **sudo iptables -A INPUT -p icmp -j icmp\_flood**
  - **sudo iptables -A icmp\_flood -m limit --limit 1/s --limit-burst 3 -j RETURN**
  - **sudo iptables -A icmp\_flood -j DROP**
- Τέλος, κάνουμε monitor τις απαντήσεις που στέλνονται από τον worker1 στον master (Icmp replies) για 5 δευτερόλεπτα και η διαφορά στο πλήθος που θα παρατηρηθεί είναι εμφανώς μεγάλη.
  - **sudo timeout 5s tcpdump -i eth0 icmp and src $worker1IP**





DDos_Worker_Node



[![asciicast](https://asciinema.org/a/385070.svg)](https://asciinema.org/a/385070)
