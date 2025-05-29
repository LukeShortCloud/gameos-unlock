#!/bin/bash

# Remove the `fedora` repository and only use `flathub` for
# simplicity of having one repository, more packages, and more up-to-date packages.
sudo flatpak remote-delete fedora
sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

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
