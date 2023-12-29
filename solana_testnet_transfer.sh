#!/bin/bash
rm -rf "/root/solana/" "/root/solana-snapshot-finder/" "/root/.config/solana/" "/root/.local/share/solana/" "/etc/systemd/system/solana.service" "/etc/systemd/system/solana_sys_tuner.service"
GREEN='\033[0;32m'
YELLOW='\033[33m'
NC='\033[0m'

#installing default packages for everything
apt-get -yq update && apt-get -yq install screen mc htop strace  wget curl git unzip etckeeper tmux psmisc dnsutils bc jq lynx ntp net-tools software-properties-common wget whois pciutils curl lsof vim gawk rsync sudo build-essential netcat-openbsd pv ethtool file logrotate iptables

#making a swap file
/root/solana-testnet-transfer/swap.sh

#choosing a release
/root/solana-testnet-transfer/solana_release.sh

wget https://gist.githubusercontent.com/Edward-Black/1fddb5dd4463b812ad2b80f43fc29df2/raw/a9bff4c1c3c094890d46c4bf47816143d22f344f/solana_sys_tuner_servise -O /etc/systemd/system/solana_sys_tuner.service
chmod 0644 /etc/systemd/system/solana_sys_tuner.service
wget https://gist.githubusercontent.com/Edward-Black/d024b377c6b7f88d2e1968834a0d7656/raw/5e5402e45afb95512decb9e2a8290c47e0c2e500/solana_testnet_service -O /etc/systemd/system/solana.service
chmod 0644 /etc/systemd/system/solana.service
systemctl daemon-reload
systemctl enable solana_sys_tuner.service
systemctl enable solana.service
systemctl start solana_sys_tuner.service
ln -s /etc/systemd/system/ services

curl -s https://gist.githubusercontent.com/c29r3/0b72e59e5b3169a03a727e75563fb332/raw/dea5af057ca00fb2a705cc6e032ea5deaa080faa/hetz-private-ips.sh | bash
iptables-save

mkdir /root/solana/

#here you need to insert the keys
/root/solana-testnet-transfer/solana_keys.sh

solana config set -ut --keypair /root/solana/validator-keypair.json
solana balance

mkdir -p /root/solana/validator-ledger/
sudo apt-get update && sudo apt-get install python3-venv git -y && git clone https://github.com/c29r3/solana-snapshot-finder.git && cd solana-snapshot-finder && python3 -m venv venv && source ./venv/bin/activate && pip3 install -r requirements.txt
python3 snapshot-finder.py --snapshot_path $HOME/solana/validator-ledger -r http://api.testnet.solana.com
cd
echo
echo
echo -e "${GREEN}If the snapshots downloaded successfully, STOP THE OLD NODE with the same keys then do: ${YELLOW}systemctl start solana${NC}"
echo
echo
