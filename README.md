# SwarmLabSec_LabProject

Όλο το project είναι βασισμένο στο [swarmlab](http://docs.swarmlab.io/SwarmLab-HowTos/labs/sec/sec.adoc.html) το οποίο βασίζεται στο [docker](http://docs.swarmlab.io/SwarmLab-HowTos/labs/Howtos/docker/install.adoc.html). Το πρώτο βήμα είναι να γίνει εγκατάσταση του [docker](http://docs.swarmlab.io/SwarmLab-HowTos/labs/Howtos/docker/install.adoc.html) και να γίνει clone το [swarmlab project](http://docs.swarmlab.io/SwarmLab-HowTos/labs/sec/sec.adoc.html) από το [https://git.swarmlab.io:3000/swarmlab/swarmlab-sec](https://git.swarmlab.io:3000/swarmlab/swarmlab-sec). Εδώ συγκεκριμένα το project του swarmlab έγινε clone στον κατάλογο **~/Asfaleia\_Diktiwn/** ενός Linux μηχανήματος. Κάνοντας αυτό έχουμε στην διάθεσή μας ένα μεταβλητού μεγέθους σμήνος (swarm) το οποίο μπορούμε να χρησιμοποιήσουμε για να προσομοιώσουμε κάποια περιστατικά. Συγκεκριμένα εδώ προσομοιώνονται κάποιες επιθέσεις (Ddos, SSH Brute Force), τα αντίστοιχα αντίμετρα τους και κάποιες υπηρεσίες (Ssh Forwarding και VPN).

Για να &quot;ξεκινήσει&quot; οποιαδήποτε από τις παραπάνω προσομοιώσεις πρέπει να δημιουργηθεί το σμήνος (create), έπειτα να ορίσουμε το μέγεθος του και να το &quot;σηκωσουμε&quot; (πχ. up size=5) και στην συνέχεια να συνδεθούμε (login) στον κύριο κόμβο (master node) του σμήνους απ&#39; όπου μπορούμε να έχουμε πρόσβαση και στα υπόλοιπα μέλη του σμήνους (workers).

Άρα αν πάρουμε σαν κατάλογο του project το **~/Asfaleia\_Diktiwn/swarmlab-sec/** (ο swarmlab-sec κατάλογος δημιουργείται μετά το cloning του project), δημιουργούμε μέσα εκεί ένα δικό μας φάκελο - συγκεκριμένα εδώ **LabProject** - από τον οποίο θα κάνουμε create, up size=? και login στο σμήνος.

Συνεπώς για να ξεκινήσει οποιαδήποτε προσομοίωση πρέπει να γίνουν τα 3 παρακάτω βήματα μέσα στον κατάλογο **~/Asfaleia\_Diktiwn/swarmlab-sec/LabProject**.

- Create

  - **../install/usr/share/swarmlab.io/sec/swarmlab-sec create**

- Up size=5 (για ένα σμήνος με 5 κόμβους συμπεριλαμβανομένου του master)

  - **../install/usr/share/swarmlab.io/sec/swarmlab-sec up size=5**

- Login στον master κόμβο

  - **../install/usr/share/swarmlab.io/sec/swarmlab-sec login**
  - Εναλλακτικά αν γίνει clone το τρέχον github project στον κατάλογο **~/Asfaleia\_Diktiwn/swarmlab-sec/LabProject/project** τότε μπορεί να γίνει login χρησιμοποιώντας το login script από τον αντίστοιχο κατάλογο. Δηλαδή με τις εντολές
  **cd ~/Asfaleia\_Diktiwn/swarmlab-sec/LabProject/project/Login\_Scripts**
  **./2masterLogin.sh**

- Login σε worker κόμβο

  - Login στον master κόμβο
  - Μόλις κάνουμε login στον master κόμβο παίρνουμε ένα shell στον κατάλογο **~/Asfaleia\_Diktiwn/swarmlab-sec/LabProject/project** ο οποίος &quot;φαίνεται&quot; στο master κόμβο σαν υποφάκελος του ριζικού καταλόγου (/) δηλαδή /project. Άρα για να κάνουμε login σε ένα worker κάνουμε τα παρακάτω βήματα μέσα από το shell του master κόμβου
    - **cd Login\_Scripts/**
    - **./worker1Login.sh**

Τα credentials όλων των κόμβων είναι username: docker , password: docker.
