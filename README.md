# GameOS Unlock

Table of Contents:
- [Introduction](#introduction)
- [Requirements](#requirements)
- [Getting Started](#getting-started)
- [Scripts](#scripts)
    - [Enable Sideloading Support](#enable-sideloading-support)
        - [Install Minecraft](#install-minecraft)
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

## License

[Apache-2.0](LICENSE)
