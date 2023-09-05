#!/bin/bash
GREEN='\033[0;32m'
YELLOW='\033[33m'
NC='\033[0m'

echo -e ${GREEN}
read -r -p "Enter release number: " release
echo -e ${NC}
curl -sSf https://raw.githubusercontent.com/solana-labs/solana/v$release/install/solana-install-init.sh | sh -s - $release