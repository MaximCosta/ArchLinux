```bash
loadkeys fr
pacman -Sy
pacman -S --noconfirm wget dhcpcd
systemctl start dhcpcd.service
wget -qO- https://bit.ly/3g9fOhy | bash -
```
