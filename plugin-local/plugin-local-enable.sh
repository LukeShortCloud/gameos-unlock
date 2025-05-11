#!/bin/bash

mkdir -p ~/.local/share/playtron/plugins/local/
mkdir -p ~/.local/share/playtron/apps/local/
echo '{
  "id": "local",
  "startup_command": "playtron-plugin-local"
}' > ~/.local/share/playtron/plugins/local/pluginmanifest.json
systemctl --user restart playserve
