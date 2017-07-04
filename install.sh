######################################################
#  __          __               _      _ _           #
#  \ \        / /              | |    (_) |          #
#   \ \  /\  / /_ _ _ __   __ _| |     _| | _____    #
#    \ \/  \/ / _` | '_ \ / _` | |    | | |/ / _ \   #
#     \  /\  / (_| | | | | (_| | |____| |   <  __/   #
#      \/  \/ \__,_|_| |_|\__,_|______|_|_|\_\___|   #
#                                                    # 
#   Script d'installation de lamp git & page Web.    #
#                                                    #
#   Par KoS_ => https://github.com/Ko5t1C            #
#            => https://facebook.com/Ko5t1C          #
#            => https://twitter.com/Ko5t1C           #
#            => https://www.wanalike.fr              #
#            => https://kos.wanalike.fr              #
#                                                    #
######################################################                                              
#!/bin/bash

#/* Variables */#
ip=`ifconfig wlan0 | grep "inet addr" | cut -d ':' -f 2 | cut -d ' ' -f 1`
chemin="/home/$USER/html"

#/* Fin des variables */#

#/* Fonctions */#
function symlink_check() 
{
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
}

function success_script() 
{
  #Changement des droits de fichiers d'apache et lien smbolique de root vers variable globale $USER
  echo password | sudo chown -R $USER:$USER /var/www/html ; echo password | sudo chown -R $USER:$USER $chemin
  echo "Script installé avec success ;-)"
}

function fileapache_source()
{
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
}

function fileapache_php() 
{
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
}

function php_create()  
{
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
}

#/* Fin des fonctions */#

#/* Début du script */#
echo -n Entrer Mot de passe sudo: 
read -s password
echo password | sudo apt update ; echo password | sudo apt upgrade -y
echo password |  sudo apt install apache2 php mysql-server libapache2-mod-php php-mysql git phpmyadmin -y

symlink_check

success_script

fileapache_source

fileapache_php

php_create

#/* Fin du script */#