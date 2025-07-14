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
        - [Install Alternative Game Launchers](#install-alternative-game-launchers)
        - [Install a Desktop Environment](#install-a-desktop-environment)
    - [Uninstall](#uninstall)
- [License](#license)

## Introduction

**Unlock the full potential of [Playtron GameOS](https://github.com/playtron-os/gameos) with unofficial community scripts!**

This guide must be followed in order. For example, to [install a desktop environment](#install-a-desktop-environment), you must first follow the [getting started](#getting-started) section and then [enable sideloading support](#enable-sideloading-support).

For running commands again, always set the `GAMEOS_IP_ADDRESS` environment variable with your actual IP address, navigate back to the `gameos-unlock` directory, and download the latest updates.

```shell
export GAMEOS_IP_ADDRESS=192.168.1.123
cd gameos-unlock
git pull --rebase origin main
```

**USE AT YOUR OWN RISK!** If you run into any major issues, it is possible to [uninstall](#uninstall) GameOS Unlock modifications.

## Requirements

- 1x PC with Playtron GameOS Beta 1 (0.21.0.21) through Beta 2.1 (0.21.2.4) only
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
    ssh playtron@$GAMEOS_IP_ADDRESS passwd
    ```
- Enable passwordless `sudo`.
    ```shell
    ssh playtron@$GAMEOS_IP_ADDRESS
    ```
    ```shell
    sudo touch /etc/sudoers.d/playtron
    echo "playtron ALL=(root) NOPASSWD:ALL" | sudo tee /etc/sudoers.d/playtron
    sudo chmod 0440 /etc/sudoers.d/playtron
    exit
    ```
- Clone the GameOS Unlock repository to start using the provided scripts.
    ```shell
    git clone https://github.com/LukeShortCloud/gameos-unlock.git
    cd gameos-unlock
    ```

## Scripts

### Enable Sideloading Support

The [local plugin](https://github.com/playtron-os/plugin-local) is installed but not enabled by default on GameOS Beta 1 (0.21.0.21). Copy and run these commands to enable it. This will take some time for the Playtron service to restart.

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

Install NVIDIA GeForce NOW.

```shell
export FLATPAK_NAME="NVIDIA_GeForce_NOW"
export FLATPAK_PACKAGE="com.google.Chrome"
export FLATPAK_IMAGE="https://static1.thegamerimages.com/wordpress/wp-content/uploads/2021/08/GeForce-Now-Comment.jpg"
scp plugin-local/install-flatpak.sh playtron@$GAMEOS_IP_ADDRESS:/home/playtron/
ssh playtron@$GAMEOS_IP_ADDRESS /bin/bash /home/playtron/install-flatpak.sh "${FLATPAK_NAME}" "${FLATPAK_PACKAGE}" "${FLATPAK_IMAGE}"
ssh playtron@$GAMEOS_IP_ADDRESS rm -f /home/playtron/install-flatpak.sh
ssh -o SendEnv=FLATPAK_NAME playtron@$GAMEOS_IP_ADDRESS sed -i -- "s/com.google.Chrome/com.google.Chrome\ --app=https:\\\/\\\/play.geforcenow.com/g" /home/playtron/.local/share/playtron/apps/local/"${FLATPAK_NAME}"/launcher.sh
```

Install Xbox Cloud Gaming.

```shell
export FLATPAK_NAME="Xbox_Cloud_Gaming"
export FLATPAK_PACKAGE="com.google.Chrome"
export FLATPAK_IMAGE="https://ixbt.online/gametech/covers/2021/06/28/4tismLfc71Vrqp9TaTkj7QA2AKZla4emBgGDLwtE.jpg"
scp plugin-local/install-flatpak.sh playtron@$GAMEOS_IP_ADDRESS:/home/playtron/
ssh playtron@$GAMEOS_IP_ADDRESS /bin/bash /home/playtron/install-flatpak.sh "${FLATPAK_NAME}" "${FLATPAK_PACKAGE}" "${FLATPAK_IMAGE}"
ssh playtron@$GAMEOS_IP_ADDRESS rm -f /home/playtron/install-flatpak.sh
ssh -o SendEnv=FLATPAK_NAME playtron@$GAMEOS_IP_ADDRESS sed -i -- "s/com.google.Chrome/com.google.Chrome\ --app=https:\\\/\\\/www.xbox.com\\\/en-us\\\/play/g" /home/playtron/.local/share/playtron/apps/local/"${FLATPAK_NAME}"/launcher.sh
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

#### Install Alternative Game Launchers

Instead of having Playtron GameOS manage all games, an alternative game launcher can be used.

Install [Lutris](https://lutris.net/).

```shell
export FLATPAK_NAME="Lutris"
export FLATPAK_PACKAGE="net.lutris.Lutris"
export FLATPAK_IMAGE="https://cdn2.steamgriddb.com/logo_thumb/2f51fec74d2549dad27f0dc57c5c8ddc.png"
scp plugin-local/install-flatpak.sh playtron@$GAMEOS_IP_ADDRESS:/home/playtron/
ssh playtron@$GAMEOS_IP_ADDRESS /bin/bash /home/playtron/install-flatpak.sh "${FLATPAK_NAME}" "${FLATPAK_PACKAGE}" "${FLATPAK_IMAGE}"
ssh playtron@$GAMEOS_IP_ADDRESS rm -f /home/playtron/install-flatpak.sh
```

#### Install a Desktop Environment

> [!WARNING]
> The Software Update feature in GameOS will no longer work with the full desktop environment installed. All future operating system updates will need to be handled via the Containerfile instead.

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

### Uninstall

Remove all modifications made by GameOS Unlock and go back to a stock Playtron GameOS experience.

```shell
scp gameos-unlock-uninstall.sh playtron@$GAMEOS_IP_ADDRESS:/home/playtron/
ssh playtron@$GAMEOS_IP_ADDRESS /bin/bash /home/playtron/gameos-unlock-uninstall.sh
```

## License

[Apache-2.0](LICENSE)
