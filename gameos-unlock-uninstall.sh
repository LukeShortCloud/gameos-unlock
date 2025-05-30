#!/bin/bash

# Remove local apps managed by GameOS Unlock.
rm -r -f /home/playtron/.local/share/playtron/apps/local/{chiaki4deck,Chrome,desktop,Firefox,Minecraft,NVIDIA_GeForce_NOW,Xbox_Cloud_Gaming}/
sudo flatpak uninstall -y --noninteractive \
  io.github.streetpea.Chiaki4deck \
  com.google.Chrome \
  org.mozilla.firefox \
  org.prismlauncher.PrismLauncher
# Remove unused dependencies.
sudo flatpak uninstall --unused -y --noninteractive
# Re-add the Fedora remote repository for Flatpak.
sudo flatpak remote-add --if-not-exists fedora oci+https://registry.fedoraproject.org

# Remove any session overrides so that Game Mode is loaded by default.
sudo rm -f /etc/sddm.conf.d/60-playtron-session-override.conf

# Switch to the upstream image in case local modifications were used.
sudo bootc switch ghcr.io/playtron-os/playtron-os:latest

# Delete the uninstall script before rebooting.
rm -f /home/playtron/gameos-unlock-uninstall.sh
sudo reboot
