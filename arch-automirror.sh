#!/bin/sh
set -e

rm -f /tmp/mirrorlist

if which wget > /dev/null; then

    wget -O /tmp/mirrorlist 'https://www.archlinux.org/mirrorlist/?country=US&protocol=http&ip_version=4&ip_version=6&use_mirror_status=on'
    wait $1


elif which curl > /dev/null; then

    curl 'https://www.archlinux.org/mirrorlist/?country=US&protocol=http&ip_version=4&ip_version=6&use_mirror_status=on' > /tmp/mirrorlist

fi

if [ -f /tmp/mirrorlist ]; then
    sed -i 's/^#Server/Server/' /tmp/mirrorlist
    rankmirrors -n 6 /tmp/mirrorlist > /etc/pacman.d/mirrorlist

else
    echo "Can't download mirrorlist";
    exit 1;
fi
