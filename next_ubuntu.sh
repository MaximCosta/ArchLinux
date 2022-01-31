#!/bin/sh
sudo apt update
sudo apt upgrade
sudo apt update
sudo apt install apache2 curl
sudo chown -R pi:www-data /var/www/html/
sudo chmod -R 770 /var/www/html/
wget -O verif_apache.html http://127.0.0.1
cat ./verif_apache.html
sudo apt install php php-mbstring
sudo rm /var/www/html/index.html
echo "<?php phpinfo(); ?>" > /var/www/html/index.php
sudo apt install mariadb-server php-mysql
sudo apt install phpmyadmin
sudo phpenmod mysqli
sudo /etc/init.d/apache2 restart
sudo ln -s /usr/share/phpmyadmin /var/www/html/phpmyadmin
sudo chmod -R 777 /var/www
sudo mkdir -p /var/www/intra.asrlab.lan
echo "Welcome to the Epitech students' intranet" > /var/www/intra.asrlab.lan/index.php
curl https://raw.githubusercontent.com/MaximCosta/ArchLinux/main/intra.asrlab.lan.conf -o /etc/apache2/sites-available/intra.asrlab.lan.conf
a2ensite intra.asrlab.lan

sudo mkdir -p /var/www/intra-adm.asrlab.lan
echo "Welcome to Epitech's ADM intranet" > /var/www/intra-adm.asrlab.lan/index.php
curl https://raw.githubusercontent.com/MaximCosta/ArchLinux/main/intra-adm.asrlab.lan.conf -o /etc/apache2/sites-available/intra-adm.asrlab.lan.conf
a2ensite intra-adm.asrlab.lan

sudo apache2ctl restart
echo "127.0.0.1 intra.asrlab.lan" > "/etc/hosts"
echo "127.0.0.1 intra-adm.asrlab.lan" > "/etc/hosts"
