#!/bin/sh
sudo apt update
sudo apt upgrade
sudo apt update
sudo apt install apache2 curl zsh git
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
sudo mkdir -p /var/www/intra.asrlab.lan
sudo mkdir -p /var/www/intra-adm.asrlab.lan
sudo chmod -R 777 /var/www

echo "Welcome to the Epitech students' intranet" > /var/www/intra.asrlab.lan/index.php
sudo curl https://raw.githubusercontent.com/MaximCosta/ArchLinux/main/intra.asrlab.lan.conf -o /etc/apache2/sites-available/intra.asrlab.lan.conf
sudo a2ensite intra.asrlab.lan

echo "Welcome to Epitech's ADM intranet" > /var/www/intra-adm.asrlab.lan/index.php
sudo curl https://raw.githubusercontent.com/MaximCosta/ArchLinux/main/intra-adm.asrlab.lan.conf -o /etc/apache2/sites-available/intra-adm.asrlab.lan.conf
sudo a2ensite intra-adm.asrlab.lan

sudo apache2ctl restart
sudo -u root echo "127.0.0.1 intra.asrlab.lan" >> "/etc/hosts"
sudo -u root echo "127.0.0.1 intra-adm.asrlab.lan" >> "/etc/hosts"

sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/agkozak/zsh-z $ZSH_CUSTOM/plugins/zsh-z
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install
chsh -s $(which zsh)
echo "exec zsh" >> ~/.bashrc
echo "change theme to gnzh"
echo "replace plugins=(git) by :"
echo "plugins=(fzf git history-substring-search colored-man-pages zsh-autosuggestions zsh-syntax-highlighting zsh-z)"
