#!/bin/sh
pacman --noconfirm -Sy xfce4 xorg
curl https://raw.githubusercontent.com/MaximCosta/ArchLinux/main/.xinitrc -o ~/.xinitrc
