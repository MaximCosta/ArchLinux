#!/bin/bash
echo "[i] Welcome to chroot."
echo "> Linking /hostlvm to /run/lvm..."
ln -s /hostlvm /run/lvm
sleep 1

echo "> Setting the persistant timezone to Europe/Paris..."
ln -sf /usr/share/zoneinfo/Europe/Paris /etc/localtime
sleep 1

echo "> Syncing clock with hardware clock..."
hwclock --systohc --utc
sleep 1

echo "> Setting locale to English (US) (UTF-8)..."
echo "en_US.UTF-8 UTF-8" > /etc/locale.gen
locale-gen
sleep 1

echo "LANG=en_US.UTF-8" > /etc/locale.conf
echo "> Setting the persistant keymap to French AZERTY..."
echo "KEYMAP=fr-latin1" > /etc/vconsole.conf
echo "> Setting hostname to labasr.lan..."
echo "asrlab.lan" > /etc/hostname
echo "> Installing wget (to download config files from GitHub Gist)..."
pacman --noconfirm -S wget lvm2
sleep 1

echo "set your passwd"
passwd root

echo "> Editing /etc/hosts..."
curl https://raw.githubusercontent.com/MaximCosta/ArchLinux/main/host -o /etc/hosts
chmod 644 /etc/hosts
sleep 1

echo "> Recreating init cpio..."
#pacstrap /mnt base linux linux-firmware nano grub dhcpcd 
mkinitcpio -p linux
sleep 1

echo "> install dhcpcd & xfce4"
pacman --noconfirm -S xfce4 dhcpcd 
sleep 1

echo "> auto start dhcpcd"
systemctl enable dhcpcd
sleep 1

echo "> Setting root password to 'password'..."
usermod --password $(openssl passwd -1 password) root
echo "> Installing the GRUB 2 bootloader (in UEFI mode)..."
pacman --noconfirm -S grub efibootmgr
grub-install --target=x86_64-efi --efi-directory=/efi --bootloader-id=GRUB
sleep 1

echo "> Generating config file for Grub"
grub-mkconfig -o /boot/grub/grub.cfg
sleep 1

echo "Done. Going back to arch iso..."
echo "[i] It is now safe to reboot your computer, using the 'reboot' command"
exit
