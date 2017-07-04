#!/bin/bash
ip=`ifconfig wlan0 | grep "inet addr" | cut -d ':' -f 2 | cut -d ' ' -f 1`
chemin="/home/$USER/html"
echo -n Entrer Mot de passe sudo: 
read -s password
echo password | sudo apt update ; echo password | sudo apt upgrade -y
echo password |  sudo apt install apache2 php mysql-server libapache2-mod-php php-mysql git phpmyadmin -y
#Création du lien symbolique du dossier apache vers le dossier home
#Vérification si le lien symbolique existe
echo "Vérification des fichiers..."
if [ -d "$chemin" ]
then
echo "Le lien symbolique existe déjà ! (l'execution du script continue)"
else
# Sinon création du lien symbolique
echo password | echo "Création du lien symbolique /var/www/html vers $chemin"
sudo ln -s /var/www/html /home/$USER
fi
echo password | sudo chown -R $USER:$USER /var/www/html ; echo password | sudo chown -R $USER:$USER $chemin
echo "Script installé avec success ;-)"
#Vérification si le fichier default apache existe on le supprime
echo "Vérification du fichier source apache2 ..."
if [ -f "$chemin/index.html" ]
then
echo "Le fichier existe (on le supprime, l'execution du script continue)"
rm $chemin/index.html
else
# Sinon on continue
echo ""
fi
#Vérification si le fichier default php existe on le supprime
echo "Vérification du fichier source php ..."
if [ -f "$chemin/index.php" ]
then
echo "Le fichier existe (on le supprime, l'execution du script continue)"
rm $chemin/index.php
else
# Sinon on continue
echo ""
fi

#création du fichier php index
touch $chemin/index.php
echo "<!DOCTYPE html>" >> $chemin/index.php
echo "<html lang=\"en\">" >> $chemin/index.php
  echo "<head>" >> $chemin/index.php
    echo "<meta charset=\"utf-8\">" >> $chemin/index.php
    echo "<title>Raspberry pi Serveur Web</title>" >> $chemin/index.php
    echo "<link rel=\"stylesheet\" href=\"style.css\">" >> $chemin/index.php
    echo "<script src=\"script.js\"></script>" >> $chemin/index.php
  echo "</head>" >> $chemin/index.php
  echo "<body>" >> $chemin/index.php
    echo "<!-- page content -->" >> $chemin/index.php
	echo "<h1>Serveur en route</h1>" >> $chemin/index.php
  echo "</body>" >> $chemin/index.php
echo "</html>" >> $chemin/index.php
echo "url de la page web => http://$ip" 
echo "url de phpmyadmin => http://$ip/phpmyadmin"
