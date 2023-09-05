#!/bin/bash
rm -rf "/root/solana/" "/root/solana-scripts/" "/root/solana-snapshot-finder/" "/root/.config/solana/" "/root/.local/share/solana/" "/etc/systemd/system/solana.service" "/etc/systemd/system/solana_sys_tuner.service"
GREEN='\033[0;32m'
YELLOW='\033[33m'
NC='\033[0m'

apt-get -yq update && apt-get -yq install screen mc htop strace  wget curl git unzip etckeeper tmux psmisc dnsutils bc jq lynx ntp net-tools software-properties-common wget whois pciutils curl lsof vim gawk rsync sudo build-essential netcat-openbsd pv ethtool file logrotate iptables
mkdir /root/solana-scripts
wget https://gist.githubusercontent.com/Edward-Black/6207d47145c7b749d62fa0e9a104d6ee/raw/bb8a92710870feed96f598faaf8e85851c56e234/swap.sh -O /root/solana-scripts/swap.sh
chmod +x /root/solana-scripts/swap.sh
wget https://gist.githubusercontent.com/Edward-Black/cec8c082ce4fe25a1e53f1996bf6fb18/raw/159e11afcc3886d0f1f97f10ac042512b7659ba6/solana_release -O /root/solana-scripts/solana_release.sh
chmod +x /root/solana-scripts/solana_release.sh
wget https://gist.githubusercontent.com/Edward-Black/e8085bde464862aca8f2bbb248d00dbf/raw/4b8bdc3d66590c19c97f74c8fab7b60b564b8d9c/solana_keys.sh -O /root/solana-scripts/solana_keys.sh
chmod +x /root/solana-scripts/solana_keys.sh
wget https://gist.githubusercontent.com/Edward-Black/0a3c37a1f6afd6862221836905343b56/raw/32ac3f328c9a4afaf82d6a4c379678f860216980/solana_sys_tuner.sh -O /root/solana-scripts/solana_sys_tuner.sh
chmod +x /root/solana-scripts/solana_sys_tuner.sh

#making a swap file
/root/solana-scripts/swap.sh

#choosing a release
/root/solana-scripts/solana_release.sh
export PATH="/root/.local/share/solana/install/active_release/bin:$PATH"

wget https://gist.githubusercontent.com/Edward-Black/1fddb5dd4463b812ad2b80f43fc29df2/raw/763630f98c73ab538beedeb404f8165018150f0a/solana_sys_tuner_servise -O /etc/systemd/system/solana_sys_tuner.service
chmod 0644 /etc/systemd/system/solana_sys_tuner.service
wget https://gist.githubusercontent.com/Edward-Black/d024b377c6b7f88d2e1968834a0d7656/raw/1596dd7ce22916c9e0eb72de906df8fcc1452586/solana_testnet_service -O /etc/systemd/system/solana.service
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
/root/solana-scripts/solana_keys.sh

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
