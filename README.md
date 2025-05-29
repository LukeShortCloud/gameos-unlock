# GameOS Unlock

Table of Contents:
- [Introduction](#introduction)
- [Requirements](#requirements)
- [Getting Started](#getting-started)
- [Scripts](#scripts)
    - [Enable Sideloading Support](#enable-sideloading-support)
        - [Install Any Flatpak](#install-any-flatpak)
        - [Install Web Browsers](#install-web-browsers)
        - [Install Game Streaming Services](#install-game-streaming-services)
        - [Install Minecraft](#install-minecraft)
        - [Install a Desktop Environment](#install-a-desktop-environment)
- [License](#license)

## Introduction

Unlock the full potential of [Playtron GameOS](https://github.com/playtron-os/gameos) with unofficial community scripts!

## Requirements

- 1x PC with Playtron GameOS Beta 1 (0.21.0.21) or newer installed
- 1x PC with Linux, macOS, or Windows installed to manage GameOS remotely
    - [Windows Subsystem for Linux (WSL) 2](https://learn.microsoft.com/en-us/windows/wsl/install) is recommended for Windows users

## Getting Started

- Enable SSH access on GameOS.
    - Settings > Advanced > Remote Access: On
- Find the IP address.
    - Settings > Internet > (select your Wi-Fi network) > (scroll down and look for "IP Address")
- Set an environment variable for the IP address. Be sure to use your actual IP address from the previous step.
    ```shell
    export GAMEOS_IP_ADDRESS=192.168.1.123
    ```
- Generate a SSH key if you do not have one already.
    ```shell
    ssh-keygen
    ```
- Copy the public SSH key to the device for easier access. The default password for the user `playtron` is `playtron`.
    ```shell
    ssh-copy-id playtron@$GAMEOS_IP_ADDRESS
    ```
- It is strongly recommended to also change the default password.
    ```shell
    ssh playtron@$GAMEOS_IP_ADDRESS password
    ```
- Enable passwordless `sudo`.
    ```shell
    ssh playtron@$GAMEOS_IP_ADDRESS
    ```
    ```shell
    sudo touch /etc/sudoers.d/playtron
    sudo chmod 0440 /etc/sudoers.d/playtron
    echo "playtron ALL=(root) NOPASSWD:ALL" | sudo tee /etc/sudoers.d/playtron
    exit
    ```

## Scripts

### Enable Sideloading Support

The [local plugin](https://github.com/playtron-os/plugin-local) is installed but not enabled by default. Copy and run these commands to enable it. This will take some time for the Playtron service to restart.

```shell
scp plugin-local/plugin-local-enable.sh playtron@$GAMEOS_IP_ADDRESS:/home/playtron/
ssh playtron@$GAMEOS_IP_ADDRESS /bin/bash /home/playtron/plugin-local-enable.sh
ssh playtron@$GAMEOS_IP_ADDRESS rm -f /home/playtron/plugin-local-enable.sh
```

Some applications and games have no way to exit. Use the "GUIDE" button to go back to the Home screen. Then use the "Y" button to force close it.

#### Install Any Flatpak

Any Flatpak can be installed by specifying a human-friendly name and the Flatpak package name. Optionally provide a URL to a 1080p image. Search on [Flathub](https://flathub.org/) to see what applications and games are available.

Define the required for the Flatpak values first.

```shell
export FLATPAK_NAME="Minecraft"
export FLATPAK_PACKAGE="org.prismlauncher.PrismLauncher"
```

Optionally, define the image URL.

```shell
export FLATPAK_IMAGE="https://wallpapers.com/images/hd/hd-minecraft-logo-3nehf0ctjgk3d0zp.jpg"
```

Then run these commands to install it.

```shell
scp plugin-local/install-flatpak.sh playtron@$GAMEOS_IP_ADDRESS:/home/playtron/
ssh playtron@$GAMEOS_IP_ADDRESS /bin/bash /home/playtron/install-flatpak.sh "${FLATPAK_NAME}" "${FLATPAK_PACKAGE}" "${FLATPAK_IMAGE}"
ssh playtron@$GAMEOS_IP_ADDRESS rm -f /home/playtron/install-flatpak.sh
```

#### Install Web Browsers

On handhelds, after installation, use the Quick Access Menu (QAM) button to access the virtual keyboard.

Install Google Chrome.

```shell
export FLATPAK_NAME="Chrome"
export FLATPAK_PACKAGE="com.google.Chrome"
export FLATPAK_IMAGE="https://wallpapersok.com/images/high/seamless-google-chrome-art-ascghdz14kzmk87u.webp"
scp plugin-local/install-flatpak.sh playtron@$GAMEOS_IP_ADDRESS:/home/playtron/
ssh playtron@$GAMEOS_IP_ADDRESS /bin/bash /home/playtron/install-flatpak.sh "${FLATPAK_NAME}" "${FLATPAK_PACKAGE}" "${FLATPAK_IMAGE}"
ssh playtron@$GAMEOS_IP_ADDRESS rm -f /home/playtron/install-flatpak.sh
```

Install Mozilla Firefox.

```shell
export FLATPAK_NAME="Firefox"
export FLATPAK_PACKAGE="org.mozilla.firefox"
export FLATPAK_IMAGE="https://img.goodfon.com/original/1920x1080/0/83/mozilla-firefox-brauzer-5087.jpg"
scp plugin-local/install-flatpak.sh playtron@$GAMEOS_IP_ADDRESS:/home/playtron/
ssh playtron@$GAMEOS_IP_ADDRESS /bin/bash /home/playtron/install-flatpak.sh "${FLATPAK_NAME}" "${FLATPAK_PACKAGE}" "${FLATPAK_IMAGE}"
ssh playtron@$GAMEOS_IP_ADDRESS rm -f /home/playtron/install-flatpak.sh
```

#### Install Game Streaming Services

Install chiaki4deck for PlayStation Remote Play.

```shell
export FLATPAK_NAME="chiaki4deck"
export FLATPAK_PACKAGE="io.github.streetpea.Chiaki4deck"
export FLATPAK_IMAGE="https://static1.thegamerimages.com/wordpress/wp-content/uploads/2021/01/remote-play.jpeg"
scp plugin-local/install-flatpak.sh playtron@$GAMEOS_IP_ADDRESS:/home/playtron/
ssh playtron@$GAMEOS_IP_ADDRESS /bin/bash /home/playtron/install-flatpak.sh "${FLATPAK_NAME}" "${FLATPAK_PACKAGE}" "${FLATPAK_IMAGE}"
ssh playtron@$GAMEOS_IP_ADDRESS rm -f /home/playtron/install-flatpak.sh
```

#### Install Minecraft

Install and configure Prism Launcher via Flatpak to be able to play vanilla or modded Minecraft.

```shell
export FLATPAK_NAME="Minecraft"
export FLATPAK_PACKAGE="org.prismlauncher.PrismLauncher"
export FLATPAK_IMAGE="https://wallpapers.com/images/hd/hd-minecraft-logo-3nehf0ctjgk3d0zp.jpg"
scp plugin-local/install-flatpak.sh playtron@$GAMEOS_IP_ADDRESS:/home/playtron/
ssh playtron@$GAMEOS_IP_ADDRESS /bin/bash /home/playtron/install-flatpak.sh "${FLATPAK_NAME}" "${FLATPAK_PACKAGE}" "${FLATPAK_IMAGE}"
ssh playtron@$GAMEOS_IP_ADDRESS rm -f /home/playtron/install-flatpak.sh
```

#### Install a Desktop Environment

By default, Playtron GameOS only provides a basic Weston desktop environment. Examples are provided on how to install a fully featured desktop environment. This requires building a local container image. Additional customizations can be added first.

Copy the example files to start from.

```shell
cp bootc/desktop/Containerfile.example bootc/desktop/Containerfile
cp bootc/desktop/install-desktop-mode.sh.example bootc/desktop/install-desktop-mode.sh
```

By default, KDE Plasma is configured. Run the following `sed` commands if you want GNOME instead.

```shell
sed -i 's/kde-desktop/gnome-desktop/g' bootc/desktop/Containerfile
sed -i 's/Session=plasma/Session=gnome-wayland/g' bootc/desktop/install-desktop-mode.sh
sed -i 's/Icon=\/usr\/share\/plasma\/desktoptheme\/default\/icons\/mobile.svgz/Icon=\/usr\/share\/icons\/gnome\/32x32\/devices\/input-gaming.png/g' bootc/desktop/install-desktop-mode.sh
```

Install the desktop environment.

```shell
scp bootc/desktop/Containerfile playtron@$GAMEOS_IP_ADDRESS:/home/playtron/
ssh playtron@$GAMEOS_IP_ADDRESS sudo podman build --tag desktop:1 .
ssh playtron@$GAMEOS_IP_ADDRESS sudo bootc switch --transport containers-storage localhost/desktop:1
scp bootc/desktop/install-desktop-mode.sh playtron@$GAMEOS_IP_ADDRESS:/home/playtron/
ssh playtron@$GAMEOS_IP_ADDRESS /bin/bash /home/playtron/install-desktop-mode.sh
ssh playtron@$GAMEOS_IP_ADDRESS rm -f /home/playtron/install-desktop-mode.sh
```

A reboot is required to load the changes.

```shell
ssh playtron@$GAMEOS_IP_ADDRESS sync
ssh playtron@$GAMEOS_IP_ADDRESS sudo reboot
```

A new "Desktop Mode" application will appear in Playtron GameOS to switch into the desktop environment. Once in Desktop Mode, there is a "Game Mode" desktop shortcut to switch back.

## License

[Apache-2.0](LICENSE)
