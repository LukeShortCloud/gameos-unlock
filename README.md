# GameOS Unlock

Table of Contents:
- [Introduction](#introduction)
- [Requirements](#requirements)
- [Getting Started](#getting-started)
- [Scripts](#scripts)
    - [Enable Sideloading Support](#enable-sideloading-support)
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

#### Install Minecraft

Install and configure Prism Launcher via Flatpak to be able to play vanilla or modded Minecraft.

```shell
scp plugin-local/install-minecraft.sh playtron@$GAMEOS_IP_ADDRESS:/home/playtron/
ssh playtron@$GAMEOS_IP_ADDRESS /bin/bash /home/playtron/install-minecraft.sh
ssh playtron@$GAMEOS_IP_ADDRESS rm -f /home/playtron/install-minecraft.sh
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
