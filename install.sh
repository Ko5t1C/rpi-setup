#!/bin/bash
sudo apt update ; sudo apt upgrade -y
sudo apt install apache2 php mysql-server libapache2-mod-php php-mysql git -y
sudo ln -s /var/www/html /home/$USER
sudo chown -R /var/www/html ; sudo chown -R /home/$USER/html 
