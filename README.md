# arch-automirror

Automatically accesses Arch's mirrorlist, downloads it, ranks them by speed (using rankmirrors), and replaces the default mirror list with the new one

Assumes US by default

IPV6 also enabled by default

## Usage

``arch-automirror.sh [country code] [ipv6]``

## Options

### Country Code
Supply country code as used on Arch's [mirrorlist](https://www.archlinux.org/mirrorlist).

### IPV6
enabled by default, set this to anything other than true to disable it
