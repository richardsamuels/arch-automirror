#!/bin/sh
set -e

if [ "$(id -u)" != "0" ]; then
    echo "This script must be run as root" 1>&2
    exit 1
fi

if [ "$1" = "-h" ]; then
    echo "Usage: $0 [country code] [ipv6]" 
    exit 0
fi

if [ -z "$1" ]; then
    COUNTRY="US"
else
    COUNTRY=$1
fi

if [ -z "$2" ]; then
    IPV6="ip_version=6&"
else
    if [ "$2" = "true" ]; then
        IPV6="ip_version=6&"
    fi
fi


URL="https://www.archlinux.org/mirrorlist/?country=${COUNTRY}&protocol=http&ip_version=4&${IPV6}use_mirror_status=on"

rm -f /tmp/mirrorlist

if which wget > /dev/null; then
    wget -O /tmp/mirrorlist ${URL}
    wait

elif which curl > /dev/null; then
    curl ${URL} > /tmp/mirrorlist
fi

if [ -f /tmp/mirrorlist ]; then
    echo "Ranking mirrors" 1>&2

    sed -i 's/^#Server/Server/' /tmp/mirrorlist
    rankmirrors -n 6 /tmp/mirrorlist > /etc/pacman.d/mirrorlist
    rm -f /tmp/mirrorlist

else
    echo "Can't download mirrorlist" 1>&2
    exit 1;
fi
