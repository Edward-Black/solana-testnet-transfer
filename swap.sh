#!/bin/bash
GREEN='\033[0;32m'
YELLOW='\033[33m'
NC='\033[0m'

echo -e ${GREEN}
swapoff /swap.img
sed -i '/swap.img/d' /etc/fstab
cp /dev/null /swap.img
chmod 0600 "/swap.img"
read -r -p "Enter swap size in Gb: " swap
echo -e ${NC}
fallocate -l "$swap"G /swap.img && mkswap /swap.img && swapon /swap.img
swapon --show
echo '/swap.img none swap sw 0 0' >> /etc/fstab