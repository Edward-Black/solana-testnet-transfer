#!/bin/bash
GREEN='\033[0;32m'
YELLOW='\033[33m'
NC='\033[0m'

echo -e ${YELLOW}
while true; do
  read -sn1 -p "Put your private keys to /root/solana then ENTER to continue..." key
  case $key in
    '') echo "ok"; break;;
    * ) echo "Please press ENTER.";;
  esac
done

echo -e ${NC}
while true; do
  read -r -p "Have you placed your private keys in /root/solana? (Y/N): " answer
  case $answer in
    [Yy]* ) echo -e ${GREEN}"Done"${NC}; break;;
    [Nn]* ) exit;;
    * ) echo "Please answer Y or N.";;
  esac
done
