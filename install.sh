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

######################################################################################
#                                                                                    #
# Ce programme est un logiciel gratuit: vous pouvez le redistribuer et / ou modifier #
#   Sous les termes de la licence publique générale GNU publiée par                  #
#   La Free Software Foundation, soit la version 3 de la licence, soit               #
#   toute version ultérieure.                                                        #
#                                                                                    #
#   Ce programme est distribué dans l'espoir qu'il sera utile,                       #
#   Mais SANS AUCUNE GARANTIE; Sans même la garantie implicite de                    #
#   QUALITÉ MARCHANDE OU ADAPTATION À UN USAGE PARTICULIER. Voir le                  #
#   GNU General Public License pour plus de détails.                                 #
#                                                                                    #
#   Vous devriez avoir reçu une copie de la GNU General Public license               #
#   Avec ce programme. Sinon, voir <http://www.gnu.org/licenses/>                    #
#   ou <https://www.gnu.org/licenses/gpl-3.0.txt/>.                                  #
#                                                                                    #
#                                                                                    #
# This program is free software: you can redistribute it and/or modify               #
#     it under the terms of the GNU General Public License as published by           #
#     the Free Software Foundation, either version 3 of the License, or              #
#     any later version.                                                             #
#                                                                                    #
#     This program is distributed in the hope that it will be useful,                #
#     but WITHOUT ANY WARRANTY; without even the implied warranty of                 #
#     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the                  #
#     GNU General Public License for more details.                                   #
#                                                                                    #
#     You should have received a copy of the GNU General Public License              #
#     along with this program.  If not, see <http://www.gnu.org/licenses/>           #
#     or <https://www.gnu.org/licenses/gpl-3.0.txt/>.                                #
#                                                                                    #
######################################################################################                                              
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

function endof_script()
{
  cd /home/$USER
  echo "url de la page web => http://$ip" 
  echo "url de phpmyadmin => http://$ip/phpmyadmin" 
  echo "url de debug => http://$ip/debug.php"
}

function php_create_base()  
{
#création du fichier php index
touch $chemin/index.php
echo "<!DOCTYPE html>" >> $chemin/index.php
echo "<html lang=\"en\">" >> $chemin/index.php
  echo "<head>" >> $chemin/index.php
    echo "<meta charset=\"utf-8\">" >> $chemin/index.php
    echo "<title>Rpi Serveur web</title>" >> $chemin/index.php
    echo "<link rel=\"stylesheet\" href=\"style.css\">" >> $chemin/index.php
    echo "<script src=\"script.js\"></script>" >> $chemin/index.php
  echo "</head>" >> $chemin/index.php
  echo "<body>" >> $chemin/index.php
    echo "<!-- page content -->" >> $chemin/index.php
  echo "<h1>Serveur en route</h1>" >> $chemin/index.php
  echo "</body>" >> $chemin/index.php
echo "</html>" >> $chemin/index.php
cd /home/$USER
endof_script
}

function php_create()  
{
#création du fichier php index
touch $chemin/index.php
echo "<!DOCTYPE html>" >> $chemin/index.php
echo "<html lang=\"en\">" >> $chemin/index.php
  echo "<head>" >> $chemin/index.php
    echo "<meta charset=\"utf-8\">" >> $chemin/index.php
    echo "<title>$title</title>" >> $chemin/index.php
    echo "<link rel=\"stylesheet\" href=\"style.css\">" >> $chemin/index.php
    echo "<script src=\"script.js\"></script>" >> $chemin/index.php
  echo "</head>" >> $chemin/index.php
  echo "<body>" >> $chemin/index.php
    echo "<!-- page content -->" >> $chemin/index.php
  echo "<h1>Serveur en route</h1>" >> $chemin/index.php
  echo "</body>" >> $chemin/index.php
echo "</html>" >> $chemin/index.php
cd /home/$USER
endof_script
}

function site_create()
{
  read -p "Voulez vous lancer la création de site? " -n 1 -r
  echo    # (optional) move to a new line
  if [[ ! $REPLY =~ ^[Yy]$ ]]
  then
      echo "création du site par défaut en cours..."
      php_create_base
      [[ "$0" = "$BASH_SOURCE" ]] && exit 1 || return 1 # handle exits from shell or function but don't exit interactive shell
  else 
      echo "création du site en cours ..."
      php_create
  fi

#  while true
#  do
 # echo -n Quel est le titre du site ?: 
 # read -s title
 # sleep 2 
 # done
  
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

site_create

#/* Fin du script */#