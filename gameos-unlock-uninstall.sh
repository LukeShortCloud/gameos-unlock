#!/bin/bash

# Remove local apps managed by GameOS Unlock.
rm -r -f /home/playtron/.local/share/playtron/apps/local/{chiaki4deck,Chrome,desktop,Firefox,"Heroic Games Launcher",Heroic,Minecraft,"NVIDIA GeForce NOW",NVIDIA_GeForce_NOW,RetroArch,RetroDeck,"Xbox Cloud Gaming",Xbox_Cloud_Gaming}/
sudo flatpak uninstall -y --noninteractive \
  io.github.streetpea.Chiaki4deck \
  com.google.Chrome \
  org.mozilla.firefox \
  com.heroicgameslauncher.hgl \
  net.lutris.Lutris \
  org.prismlauncher.PrismLauncher \
  org.libretro.RetroArch \
  net.retrodeck.retrodeck
# Remove unused dependencies.
sudo flatpak uninstall --unused -y --noninteractive
# Re-add the Fedora remote repository for Flatpak.
sudo flatpak remote-add --if-not-exists fedora oci+https://registry.fedoraproject.org

# Remove any session overrides so that Game Mode is loaded by default.
sudo rm -f /etc/sddm.conf.d/60-playtron-session-override.conf

# Switch to the upstream image in case local modifications were used.
sudo bootc switch ghcr.io/playtron-os/playtron-os:latest

# Use a single command to delete the sudoers file and reboot.
# Otherwise, the reboot may not work.
sudo sh -c 'rm -f /etc/sudoers.d/playtron; reboot'
