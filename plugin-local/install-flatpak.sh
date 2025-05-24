#!/bin/bash

sudo flatpak install -y "${2}"

mkdir ~/.local/share/playtron/apps/local/"${1}"/

echo '#!/bin/bash' >  ~/.local/share/playtron/apps/local/"${1}"/launcher.sh
echo "/usr/bin/flatpak run ${2}" >>  ~/.local/share/playtron/apps/local/"${1}"/launcher.sh
chmod +x ~/.local/share/playtron/apps/local/"${1}"/launcher.sh

echo "name: ${1}
executable: ./launcher.sh
os: linux" > ~/.local/share/playtron/apps/local/"${1}"/gameinfo.yaml
if [ -n "${3}" ]; then
    echo "image: ${3}" >> ~/.local/share/playtron/apps/local/"${1}"/gameinfo.yaml
fi

systemctl --user restart playserve
