# solana-testnet-transfer
Transferring Solana testnet to another server

This script is written to quickly automatically transfer the Solana testnet node to another server. There is an actual service file (logs are written to /dev/null), a tuner, swap settings, release selection, interactive key insertion (handles). And also downloading a fresh snapshot through the solana-snapshot-finder.
The script installs the node in the root directory. If you are working in your home directory, modify the script to suit your needs.

## Installation

1. Install git if needed:
```
sudo apt install git
```
2. Clone project:
```
git clone https://github.com/Edward-Black/solana-testnet-transfer.git
cd solana-testnet-transfer/
chmod +x *.sh
```

## Start script
```
/root/solana-testnet-transfer/solana_testnet_transfer.sh
```
## Usage

When the program asks for the size of the swap file or the release number, you need to enter only numbers.

e.g.:
- 128
- 1.16.10

## Update
```
cd solana-testnet-transfer/
git pull
```
