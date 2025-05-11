#!/bin/bash

sudo flatpak install -y org.prismlauncher.PrismLauncher

mkdir ~/.local/share/playtron/apps/local/minecraft/

echo '#!/bin/bash
/usr/bin/flatpak run org.prismlauncher.PrismLauncher' >  ~/.local/share/playtron/apps/local/minecraft/launcher.sh

chmod +x ~/.local/share/playtron/apps/local/minecraft/launcher.sh

echo 'name: Minecraft
executable: ./launcher.sh
image: https://wallpapers.com/images/hd/hd-minecraft-logo-3nehf0ctjgk3d0zp.jpg
os: linux' > ~/.local/share/playtron/apps/local/minecraft/gameinfo.yaml

systemctl --user restart playserve
