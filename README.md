# GameOS Unlock

Table of Contents:
- [Introduction](#introduction)
- [Requirements](#requirements)
- [Getting Started](#getting-started)
    - [Install Any Flatpak](#install-any-flatpak)
    - [Install Web Browsers](#install-web-browsers)
    - [Install Game Streaming Services](#install-game-streaming-services)
    - [Install Minecraft](#install-minecraft)
    - [Install LocalSend](#install-localsend)
        - [Install Emulators](#install-emulators)
        - [Install Alternative Game Launchers](#install-alternative-game-launchers)
    - [OS Modifications](#os-modifications)
        - [Install a Desktop Environment](#install-a-desktop-environment)
        - [Use the Mesa Drivers for NVIDIA](#use-the-mesa-drivers-for-nvidia)
- [Uninstall](#uninstall)
- [License](#license)

## Introduction

**Unlock the full potential of [Playtron GameOS](https://github.com/playtron-os/gameos) with unofficial community scripts!**

> [!WARNING]
> **USE AT YOUR OWN RISK!** If you run into any major issues, it is possible to [uninstall](#uninstall) GameOS Unlock modifications.
>
> Playtron will not provide support for any issues encountered with these modifications! Please direct all feature requesets and bug reports to the [GitHub Issues page for GameOS Unlock](https://github.com/LukeShortCloud/gameos-unlock/issues).

This guide must be followed in order. For example, to [install an alternative game launcher](#install-alternative-game-launchers), you must first follow the [getting started](#getting-started) section and then the [install LocalSend](#install-localsend) section second.

For running commands again, always set the `GAMEOS_IP_ADDRESS` environment variable with your actual IP address.

```shell
export GAMEOS_IP_ADDRESS=192.168.1.123
```

## Requirements

- 1x PC with Playtron GameOS 1.0 Stable Release (1.0.0.30) or newer installed
- 1x PC with Linux, macOS, or Windows installed to manage GameOS remotely
    - [Windows Subsystem for Linux (WSL) 2](https://learn.microsoft.com/en-us/windows/wsl/install) is required for Windows users
        - Open "WSL" (not "Command Prompt") to run commands

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

Some applications and games installed by these scripts have no way to exit. Use the "GUIDE" button to go back to the Home screen. Then use the "Y" button to force close it.

### Install Any Flatpak

Any Flatpak can be installed by specifying a human-friendly name and the Flatpak package name. Optionally provide a URL to a 1080p image. Search on [Flathub](https://flathub.org/) to see what applications and games are available.

First define the required values for the Flatpak.

```shell
export FLATPAK_NAME="Minecraft"
export FLATPAK_PACKAGE="org.prismlauncher.PrismLauncher"
```

Optionally, define the image URL.

```shell
export FLATPAK_IMAGE="https://wallpapers.com/images/hd/hd-minecraft-logo-3nehf0ctjgk3d0zp.jpg"
```

Then run this command to install it.

```shell
ssh playtron@$GAMEOS_IP_ADDRESS "curl https://raw.githubusercontent.com/LukeShortCloud/gameos-unlock/refs/heads/main/plugin-local/install-flatpak.sh | bash -s -- \"${FLATPAK_NAME}\" ${FLATPAK_PACKAGE} ${FLATPAK_IMAGE}"
```

### Install Web Browsers

On handhelds, after installation, use the Quick Access Menu (QAM) button to access the virtual keyboard.

Install [Google Chrome](https://www.google.com/chrome/).

```shell
ssh playtron@$GAMEOS_IP_ADDRESS "curl https://raw.githubusercontent.com/LukeShortCloud/gameos-unlock/refs/heads/main/plugin-local/install-flatpak.sh | bash -s -- "Chrome" "com.google.Chrome" "https://wallpapersok.com/images/high/seamless-google-chrome-art-ascghdz14kzmk87u.webp""
```

Install [Mozilla Firefox](https://www.firefox.com/).

```shell
ssh playtron@$GAMEOS_IP_ADDRESS "curl https://raw.githubusercontent.com/LukeShortCloud/gameos-unlock/refs/heads/main/plugin-local/install-flatpak.sh | bash -s -- "Firefox" "org.mozilla.firefox" "https://img.goodfon.com/original/1920x1080/0/83/mozilla-firefox-brauzer-5087.jpg""
```

### Install Game Streaming Services

Install [chiaki4deck](https://github.com/DieHertz/chiaki4deck) for [PlayStation (PS) Remote Play](https://www.playstation.com/en-us/remote-play/).

```shell
ssh playtron@$GAMEOS_IP_ADDRESS "curl https://raw.githubusercontent.com/LukeShortCloud/gameos-unlock/refs/heads/main/plugin-local/install-flatpak.sh | bash -s -- "chiaki4deck" "io.github.streetpea.Chiaki4deck" "https://static1.thegamerimages.com/wordpress/wp-content/uploads/2021/01/remote-play.jpeg""
```

Install [NVIDIA GeForce NOW](https://www.nvidia.com/en-us/geforce-now/).

```shell
ssh playtron@$GAMEOS_IP_ADDRESS "curl https://raw.githubusercontent.com/LukeShortCloud/gameos-unlock/refs/heads/main/plugin-local/install-flatpak.sh | bash -s -- \"NVIDIA GeForce NOW\" com.google.Chrome https://static1.thegamerimages.com/wordpress/wp-content/uploads/2021/08/GeForce-Now-Comment.jpg"
ssh playtron@$GAMEOS_IP_ADDRESS sed -i -- "s/com.google.Chrome/com.google.Chrome\ --kiosk\ --app=https:\\\/\\\/play.geforcenow.com/g" \"/home/playtron/.local/share/playtron/apps/local/NVIDIA GeForce NOW/launcher.sh\"
```

Install [Xbox Cloud Gaming](https://www.xbox.com/en-US/cloud-gaming).

```shell
ssh playtron@$GAMEOS_IP_ADDRESS "curl https://raw.githubusercontent.com/LukeShortCloud/gameos-unlock/refs/heads/main/plugin-local/install-flatpak.sh | bash -s -- \"Xbox Cloud Gaming\" com.google.Chrome https://ixbt.online/gametech/covers/2021/06/28/4tismLfc71Vrqp9TaTkj7QA2AKZla4emBgGDLwtE.jpg"
ssh playtron@$GAMEOS_IP_ADDRESS sed -i -- "s/com.google.Chrome/com.google.Chrome\ --kiosk\ --app=https:\\\/\\\/www.xbox.com\\\/en-us\\\/play/g" \"/home/playtron/.local/share/playtron/apps/local/Xbox Cloud Gaming/launcher.sh\"
```

### Install Minecraft

Install [Prism Launcher](https://prismlauncher.org/) to be able to play vanilla or modded [Minecraft](https://www.minecraft.net).

```shell
ssh playtron@$GAMEOS_IP_ADDRESS "curl https://raw.githubusercontent.com/LukeShortCloud/gameos-unlock/refs/heads/main/plugin-local/install-flatpak.sh | bash -s -- "Minecraft" "org.prismlauncher.PrismLauncher" "https://wallpapers.com/images/hd/hd-minecraft-logo-3nehf0ctjgk3d0zp.jpg""
```

Install the [Luanti (previously Minetest)](https://www.luanti.org/) game engine. It can be used to play games such as [VoxeLibre (previously MineClone2)](https://content.luanti.org/packages/wuzzy/mineclone2/) which is inspired by Minecraft.

```shell
ssh playtron@$GAMEOS_IP_ADDRESS "curl https://raw.githubusercontent.com/LukeShortCloud/gameos-unlock/refs/heads/main/plugin-local/install-flatpak.sh | bash -s -- "Luanti" "org.luanti.luanti" "https://docs.luanti.org/images/server/Minetest_serverlist.png""
```

### Install LocalSend

Install [LocalSend](https://localsend.org/) to send and receive files. This is useful for copying screenshots off the device from `/var/home/playtron/.local/share/playtron/screenshots/`, copying emulators files to the device, copying apps or games to the device, etc.

```shell
ssh playtron@$GAMEOS_IP_ADDRESS "curl https://raw.githubusercontent.com/LukeShortCloud/gameos-unlock/refs/heads/main/plugin-local/install-flatpak.sh | bash -s -- "LocalSend" "org.localsend.localsend_app" "https://repository-images.githubusercontent.com/578822531/6c3c4f46-0ab9-4737-9afe-7fa7f2f929d7""
ssh playtron@$GAMEOS_IP_ADDRESS sudo flatpak override --socket=system-bus --filesystem=home org.localsend.localsend_app
```

#### Install Emulators

Install [RetroArch which provides many emulators](https://en.wikipedia.org/wiki/RetroArch#Supported_systems).

```shell
ssh playtron@$GAMEOS_IP_ADDRESS "curl https://raw.githubusercontent.com/LukeShortCloud/gameos-unlock/refs/heads/main/plugin-local/install-flatpak.sh | bash -s -- "RetroArch" "org.libretro.RetroArch" "https://gbatemp.net/attachments/1804196-1684057088-png.437393/""
```

Install [RetroDeck which provides many emulators and managers](https://retrodeck.readthedocs.io/en/latest/wiki_about/what-is-included/) including emulators that RetroArch does not have and RetroArch itself. This is a large download and may take a long time to install.

```shell
ssh playtron@$GAMEOS_IP_ADDRESS "curl https://raw.githubusercontent.com/LukeShortCloud/gameos-unlock/refs/heads/main/plugin-local/install-flatpak.sh | bash -s -- "RetroDeck" "net.retrodeck.retrodeck" "https://retrodeck.net/assets/screens/screen01.png""
```

#### Install Alternative Game Launchers

Instead of having Playtron GameOS manage all games, an alternative game launcher can be used.

Install [Heroic Games Launcher](https://heroicgameslauncher.com/).

```shell
ssh playtron@$GAMEOS_IP_ADDRESS "curl https://raw.githubusercontent.com/LukeShortCloud/gameos-unlock/refs/heads/main/plugin-local/install-flatpak.sh | bash -s -- \"Heroic Games Launcher\" "com.heroicgameslauncher.hgl" "https://cdn2.steamgriddb.com/grid/726d04d0731a3930f3359dca8f721168.png""
```

Install [Lutris](https://lutris.net/).

```shell
ssh playtron@$GAMEOS_IP_ADDRESS "curl https://raw.githubusercontent.com/LukeShortCloud/gameos-unlock/refs/heads/main/plugin-local/install-flatpak.sh | bash -s -- "Lutris" "net.lutris.Lutris" "https://cdn2.steamgriddb.com/logo_thumb/2f51fec74d2549dad27f0dc57c5c8ddc.png""
```

### OS Modifications

> [!WARNING]
> The Software Update feature in GameOS will no longer work with any of these OS modifications installed. All future operating system updates will need to be handled via the Containerfile instead.

#### Install a Desktop Environment

> [!WARNING]
> The Software Update feature in GameOS will no longer work with any of these OS modifications installed. All future operating system updates will need to be handled via the Containerfile instead.

By default, Playtron GameOS only provides a basic [Weston desktop environment](https://wayland.pages.freedesktop.org/weston/). Examples are provided on how to install a fully featured desktop environment. This requires building a local container image. Additional customizations can be added first.

Navigate back to the `gameos-unlock` directory and download the latest updates.

```shell
cd gameos-unlock
git pull --rebase origin main
```

Copy the example files to start from.

```shell
cp bootc/desktop/Containerfile.example bootc/desktop/Containerfile
cp bootc/desktop/install-desktop-mode.sh.example bootc/desktop/install-desktop-mode.sh
```

By default, [KDE Plasma](https://kde.org/plasma-desktop/) is configured. Run the following `sed` commands if you want [GNOME](https://www.gnome.org/) instead.

```shell
sed -i 's/kde-desktop/gnome-desktop/g' bootc/desktop/Containerfile
sed -i 's/Session=plasma/Session=gnome-wayland/g' bootc/desktop/install-desktop-mode.sh
sed -i 's/Icon=\/usr\/share\/plasma\/desktoptheme\/default\/icons\/mobile.svgz/Icon=\/usr\/share\/icons\/gnome\/32x32\/devices\/input-gaming.png/g' bootc/desktop/install-desktop-mode.sh
```

Install the desktop environment. This will take a very long time to complete.

```shell
scp bootc/desktop/Containerfile playtron@$GAMEOS_IP_ADDRESS:/home/playtron/
export CONTAINER_TAG="$(date +"%Y-%m-%dT%H_%M_%S%z" | sed 's/+/-/g')"
ssh playtron@$GAMEOS_IP_ADDRESS sudo podman build --no-cache --pull=always --tag desktop:${CONTAINER_TAG} .
ssh playtron@$GAMEOS_IP_ADDRESS sudo bootc switch --transport containers-storage localhost/desktop:${CONTAINER_TAG}
scp bootc/desktop/install-desktop-mode.sh playtron@$GAMEOS_IP_ADDRESS:/home/playtron/
ssh playtron@$GAMEOS_IP_ADDRESS /bin/bash /home/playtron/install-desktop-mode.sh
ssh playtron@$GAMEOS_IP_ADDRESS rm -f /home/playtron/install-desktop-mode.sh
```

A reboot is required to load the changes.

```shell
ssh playtron@$GAMEOS_IP_ADDRESS "sync && sudo reboot"
```

A new "Desktop Mode" application will appear in Playtron GameOS to switch into the desktop environment. Once in Desktop Mode, there is a "Game Mode" desktop shortcut to switch back.

#### Use the Mesa Drivers for NVIDIA

> [!WARNING]
> The Software Update feature in GameOS will no longer work with any of these OS modifications installed. All future operating system updates will need to be handled via the Containerfile instead.

> [!WARNING]
> This is highly experimental. [Performance of the NVK Vulkan driver in Mesa can be up to 4x slower](https://www.phoronix.com/review/mesa-252-nvk-nvidia). [DLSS is also not currently supported](https://gitlab.freedesktop.org/mesa/mesa/-/issues/12439).

Navigate back to the `gameos-unlock` directory and download the latest updates.

```shell
cd gameos-unlock
git pull --rebase origin main
```

Copy the example file to start from.

```shell
cp bootc/nvidia-mesa/Containerfile.example bootc/nvidia-mesa/Containerfile
```

Switch from the official NVIDIA driver to the open source Mesa drivers. This will take a very long time to complete.

```shell
scp bootc/nvidia-mesa/Containerfile playtron@$GAMEOS_IP_ADDRESS:/home/playtron/
export CONTAINER_TAG="$(date +"%Y-%m-%dT%H_%M_%S%z" | sed 's/+/-/g')"
ssh playtron@$GAMEOS_IP_ADDRESS sudo podman build --no-cache --pull=always --tag nvidia-mesa:${CONTAINER_TAG} .
ssh playtron@$GAMEOS_IP_ADDRESS sudo bootc switch --transport containers-storage localhost/nvidia-mesa:${CONTAINER_TAG}
```

A reboot is required to load the changes.

```shell
ssh playtron@$GAMEOS_IP_ADDRESS "sync && sudo reboot"
```

## Uninstall

Remove a specific Flatpak. Define both the `FLATPAK_NAME` and `FLATPAK_PACKAGE` used to install it.

```shell
export FLATPAK_NAME="Minecraft"
export FLATPAK_PACKAGE="org.prismlauncher.PrismLauncher"
```
```shell
ssh playtron@$GAMEOS_IP_ADDRESS "curl https://raw.githubusercontent.com/LukeShortCloud/gameos-unlock/refs/heads/main/plugin-local/uninstall-flatpak.sh | bash -s -- \"${FLATPAK_NAME}\" ${FLATPAK_PACKAGE}"
```

Remove all modifications made by GameOS Unlock and go back to a stock Playtron GameOS experience.

```shell
ssh playtron@$GAMEOS_IP_ADDRESS "curl https://raw.githubusercontent.com/LukeShortCloud/gameos-unlock/refs/heads/main/gameos-unlock-uninstall.sh | bash -s --"
```

If removing all modifications fails, use the emergency utilities menu to factory reset the device.

-  Use a Xbox-style controller to hold down `LT`, `LB`, `RT`, `RB`, and `X` (or the equivalent) for 5 seconds.

In a worst-case scenario, you may need to [reinstall Playtron GameOS](https://www.playtron.one/game-os#download-playtron-os).

## License

[Apache-2.0](LICENSE)
