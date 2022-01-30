#!/bin/bash
echo "[B-SAD-200_my-web part 1] auto installer for Arch Linux in my-client"

echo "> Loading french (AZERTY) keys..."
loadkeys fr-latin1
sleep 1

echo "> Enabling auto time update via NTP..."
timedatectl set-ntp true
sleep 1

echo "> Setting timezone to Europe/Paris..."
timedatectl set-timezone Europe/Paris
sleep 1

echo "> Creating a GPT partition table..."
parted -s /dev/sda mktable gpt
sleep 1

echo "> Creating the EFI ESP partition (550MB)..."
parted -s /dev/sda mkpart primary fat32 0 550MB
sleep 1

echo "> Setting the esp flag on the partition..."
parted -s /dev/sda set 1 esp on
sleep 1

echo "> Creating the LVM partition for Arch Linux (16GB)..."
parted -s /dev/sda mkpart primary ext2 550MB 16550MB
sleep 1

#echo "> Creating the Deb partition for Arch Linux (16GB)..."
#parted -s /dev/sda mkpart primary ext2 16550MB 33000MB
#sleep 1

echo "> Setting the lvm flag on the partition..."
parted -s /dev/sda set 2 lvm on
sleep 1

echo "> Creating the root partition for Debian (10GB)..."
parted -s /dev/sda mkpart primary ext4 16550MB 26550MB
sleep 1

echo "> Creating the home partition for Debian (4.5GB)..."
parted -s /dev/sda mkpart primary ext4 26550MB 31050MB
sleep 1

echo "> Creating the boot partition for Debian (500MB)..."
parted -s /dev/sda mkpart primary ext2 31050MB 31550MB
sleep 1

echo "> Creating the swap partition for Debian (500MB)..."
parted -s /dev/sda mkpart primary linux-swap 31550MB 32050MB
sleep 1

echo "> Creating the volume group archvg..."
vgcreate archvg /dev/sda2
sleep 1

echo "> Creating the logical volume for ROOT (9GB)..."
lvcreate -L 9G archvg -n ROOT
sleep 1

echo "> Creating the logical volume for HOME (5GB)..."
lvcreate -L 5G archvg -n HOME
sleep 1

echo "> Creating the logical volume for BOOT (400MB)..."
lvcreate -L 400M archvg -n BOOT
sleep 1

echo "> Creating the logical volume for SWAP (500MB)..."
lvcreate -L 500M archvg -n SWAP
sleep 1

echo "> Formatting the EFI ESP partition to fat32..."
mkfs.fat -F32 /dev/sda1
sleep 1

echo "> Formatting the logical volume for ROOT to ext4..."
mkfs.ext4 /dev/archvg/ROOT
sleep 1

echo "> Formatting the logical volume for HOME to ext4..."
mkfs.ext4 /dev/archvg/HOME
sleep 1

echo "> Formatting the logical volume for BOOT to ext2..."
mkfs.ext2 /dev/archvg/BOOT
sleep 1

echo "> Formatting the logical volume for SWAP to linux-swap..."
mkswap /dev/archvg/SWAP
sleep 1

echo "> Formatting the root partition for Debian to ext4..."
mkfs.ext4 /dev/sda3
sleep 1

echo "> Formatting the home partition for Debian to ext4..."
mkfs.ext4 /dev/sda4
sleep 1

echo "> Formatting the boot partition for Debian to ext2..."
mkfs.ext2 /dev/sda5
sleep 1

echo "> Formatting the swap partition for Debian to linux-swap..."
mkswap /dev/sda6
sleep 1

echo "> Enabling swap for Arch Linux..."
swapon /dev/archvg/SWAP
sleep 1

echo "> Mounting /root..."
mount /dev/archvg/ROOT /mnt
sleep 1

echo "> Creating mount points..."
mkdir /mnt/boot
mkdir /mnt/efi
mkdir /mnt/home
sleep 1

echo "> Mounting /home..."
mount /dev/archvg/HOME /mnt/home
sleep 1

echo "> Mounting /boot..."
mount /dev/archvg/BOOT /mnt/boot
sleep 1

echo "> Mounting the EFI ESP partition..."
mount /dev/sda1 /mnt/efi
sleep 1

echo "> Settings mirror list to use archlinux.fr only..."
echo "Server = http://mir.archlinux.fr/\$repo/os/\$arch" > /etc/pacman.d/mirrorlist
echo "> Installing base packages..."
pacstrap /mnt base
sleep 1

echo "> Installing base-devel packages..."
pacstrap /mnt base-devel
sleep 1

echo "> Installing /mnt packages..."
pacstrap /mnt base linux nano
sleep 1

echo "> Editing mkinitcpio.conf to be able to boot on LVM..."
curl https://raw.githubusercontent.com/MaximCosta/ArchLinux/main/mkinitcpio.conf -o /mnt/etc/mkinitcpio.conf
chmod 644 /mnt/etc/mkinitcpio.conf
sleep 1

echo "> Generating fstab..."
genfstab -U /mnt >> /mnt/etc/fstab
sleep 1

echo "> Mounting /hostlvm (workaround for a lvm2 bug)..."
mkdir /mnt/hostlvm
mount --bind /run/lvm /mnt/hostlvm
sleep 1

echo "> Going in chroot into your 
new system. Downloading new script..."
curl https://raw.githubusercontent.com/MaximCosta/ArchLinux/main/install_arch.sh -o /mnt/root/arch_install_script_chroot.sh
chmod 755 /mnt/root/arch_install_script_chroot.sh

arch-chroot /mnt /root/arch_install_script_chroot.sh

echo "> Deleting junk files..."
rm /mnt/root/arch_install_script_chroot.sh

# echo "Done. Rebooting in 10 seconds..."
# sleep 1
# echo "> Rebooting..."
# reboot
