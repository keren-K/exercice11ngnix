Exercice 11 : Load Balancer avec nginx
Vous lancez un VPC dans lequel vous aurez 3 subnets (un public et deux privés) et chaque subnet sera dans son availability zone (donc nous aurons aussi 3 AZ)
Dans chaque subnet, vous lancez un ec2 où vous lancez un serveur Node.
Spécialement au niveau de l'availability zone 2 (où le subnet est public), vous installez nginx (avec l'algorithme round robin) qui va faire la balance des charges.
Dans chacun des deux ec2 des réseaux privés, vous lancez aussi un serveur Node.
Vous affichez une page qui affiche Hello World dans deux ports différents : 5000 et 5001
Mais au niveau de l'ec2 du subnet public où se trouve nginx vous affichez Hello World seulement au port 5000
Au total, vous devez voir naviguer 5 sites sur votre browser (pour mieux voir, vous pouvez jouez sur la couleur du background)
Supplément : écrire un script en prenant le nom du serveur et de l'hôte et automatiser son envoi sur GitHub 

création du vpc avec 3 subnet, dans des az different.
création d'un internet gataway pour le subnet public, ensuite on l'associé à son route table
et un natgateway pour le deux subnet private, on l'associe à sa route table.

création de 3ec2 dans chaque subnet, 
création d'un groupe de securité pour le ec2 public qui permet le passage de l'http port 80.

Etapes1: configuration de l'ec2 public.
a. installer nodejs
avec la commande sudo yum install -y nodejs
b. installation de pm2
avec la commande sudo npm install -g pm2
c. installation de git
avec la commande sudo yum install git
d. creation des scripts dans un dossier specifique 
- script de configuration du serveur app.config.js
- Script du serveur nodejs app.js
- script de verification de mise à jour du fichier index.html: ngscript.sh
e. installation de ngnix
avec la commanende sudo yum install nginx
f. modification du fichier de configuration de ngniix
avec la commande sudo nano /etc/nginx/conf.d/default.conf
g. on remplace les adressses ip par ceux de nos serveurs
h. rédemarage du ngnix 
avec la commande sudo systemctl restart nginx
j. lancement du serveur pm2 start app.config.js
k. lancement du script en background ./ngscript.sh &

Etapes2: configurationde l'ec2 private1 et 2
a. installer nodejs
avec la commande sudo yum install -y nodejs
b. installation de pm2
sudo npm install -g pm2
c. installation de git
avec sudo yum install git
d. création des scripts dans un dossier specifique 
- script de configuration du serveur app.config.js
- Script du serveur nodejs server.js
- script de verification de mise à jour du fichier index.html: ngscript.sh
f. lancement du serveur pm2 start app.config.js
g. lancement du script en background ./ngscript.sh &
