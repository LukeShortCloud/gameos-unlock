#!/bin/bash

mkdir -p ~/Desktop/ ~/.local/bin/ ~/.local/share/playtron/apps/local/desktop/
sudo mkdir /etc/sddm.conf.d/ 2> /dev/null

mkdir -p ~/.config/systemd/user/
echo '[Unit]
Description=Convert the built-in controller to work as mouse and keyboard for Desktop Mode

# Wait for Plasma to be ready.
After=plasma-workspace.target
# Wati for Playserve to stop so it does not manage the controller
After=playserve.service

[Service]
Type=oneshot

# Allow using more than one ExecStart instruction.
RemainAfterExit=no

# Avoid a rash condition where switching to keyboard mouse mode happens too soon.
ExecStartPre=/usr/bin/sleep 5

# Some handhelds have two devices so configure them both.
# For example: GPD Win4 2025.
ExecStart=inputplumber device 0 intercept set none
ExecStart=inputplumber device 0 targets set keyboard mouse touchscreen
ExecStart=inputplumber device 0 profile load /usr/share/inputplumber/profiles/mouse_keyboard_wasd.yaml
ExecStart=inputplumber device 1 intercept set none
ExecStart=inputplumber device 1 targets set keyboard mouse touchscreen
ExecStart=inputplumber device 1 profile load /usr/share/inputplumber/profiles/mouse_keyboard_wasd.yaml

[Install]
# Only run this service when Plasma is activated.
WantedBy=plasma-workspace.target' > ~/.config/systemd/user/controller-to-kbm.service
systemctl --user daemon-reload

echo '#!/bin/bash
echo -e "[Autologin]\nSession=plasma" | sudo tee /etc/sddm.conf.d/60-playtron-session-override.conf
sudo systemctl restart sddm
systemctl --user enable --now controller-to-kbm.service
systemctl --user disable --now playserve' > ~/.local/share/playtron/apps/local/desktop/switch-to-desktop-mode.sh
chmod +x ~/.local/share/playtron/apps/local/desktop/switch-to-desktop-mode.sh

echo '#!/bin/bash

sudo rm -f /etc/sddm.conf.d/60-playtron-session-override.conf
systemctl --user disable --now controller-to-kbm.service
systemctl --user enable --now playserve
sudo systemctl restart sddm' > ~/.local/share/playtron/apps/local/desktop/switch-to-game-mode.sh
chmod +x ~/.local/share/playtron/apps/local/desktop/switch-to-game-mode.sh

echo 'name: Desktop Mode
executable: ./switch-to-desktop-mode.sh
image: https://images.pexels.com/photos/6424590/pexels-photo-6424590.jpeg
os: linux
runtime: false' > ~/.local/share/playtron/apps/local/desktop/gameinfo.yaml

# Add the shortcut here for KDE Plasma.
echo '[Desktop Entry]
Exec=/bin/bash /home/playtron/.local/share/playtron/apps/local/desktop/switch-to-game-mode.sh
Name=Game Mode
Comment=Switch from Desktop Mode back to Game Mode
Encoding=UTF-8
Icon=/usr/share/plasma/desktoptheme/default/icons/mobile.svgz
Terminal=false
Type=Application
Categories=Application' > ~/Desktop/switch-to-game-mode.desktop
chmod +x ~/Desktop/switch-to-game-mode.desktop
# Add the shortcut here for GNOME.
mkdir ~/.local/share/applications/ 2> /dev/null
cp ~/Desktop/switch-to-game-mode.desktop ~/.local/share/applications/
