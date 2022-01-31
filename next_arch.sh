#!/bin/sh
pacman –Syu
pacman -S xfce4 xfce4-goodies xorg xorg-init lightdm lightdm-gtk-greeter openssh zsh git dnf virtualbox-guest-utils
pacman --sync sudo
cp /etc/X11/xinit/xinitrc ~/.xinitrc
systemctl enable sshd.service
groupadd adm
groupadd epitech
groupadd managers
useradd -G adm,epitech -m leslie -p toto
useradd -G managers,epitech -m romain -p toto
echo "romain ALL=(ALL) ALL" >> /etc/sudoers

sudo su - root
sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/agkozak/zsh-z $ZSH_CUSTOM/plugins/zsh-z
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install
chsh -s $(which zsh)
echo "exec zsh" >> .bashrc
echo "replace plugins=(git) by :"
echo "plugins=(fzf git history-substring-search colored-man-pages zsh-autosuggestions zsh-syntax-highlighting zsh-z)"

sudo su - leslie
sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/agkozak/zsh-z $ZSH_CUSTOM/plugins/zsh-z
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install
chsh -s $(which zsh)
echo "exec zsh" >> .bashrc
echo "replace plugins=(git) by :"
echo "plugins=(fzf git history-substring-search colored-man-pages zsh-autosuggestions zsh-syntax-highlighting zsh-z)"

sudo su - romain
sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/agkozak/zsh-z $ZSH_CUSTOM/plugins/zsh-z
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install
chsh -s $(which zsh)
echo "exec zsh" >> .bashrc
echo "replace plugins=(git) by :"
echo "plugins=(fzf git history-substring-search colored-man-pages zsh-autosuggestions zsh-syntax-highlighting zsh-z)"
