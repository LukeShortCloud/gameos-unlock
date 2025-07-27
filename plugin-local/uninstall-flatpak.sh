#!/bin/bash

set -x

sudo flatpak uninstall -y --noninteractive "${2}"

flatpak_name_no_newlines="$(echo "${1}" | tr -d '\n')"
if [ -n "${flatpak_name_no_newlines}" ]; then
    rm -r -f /home/playtron/.local/share/playtron/apps/local/"${1}"
fi
