#!/bin/bash

apt install jq

# Check if Duplicati is already installed
if ! command -v duplicati-cli >/dev/null 2>&1; then
  echo "Installing Duplicati..."
  ./install-linux.sh
else
  echo "Duplicati is already installed"
fi

echo "What is the URL of the backup destination?"
if [ ! -f backup-url.txt ]; then
  read -r url
  echo "$url" >backup-url.txt
else
  echo "Backup URL already configured in backup-url.txt"
fi

echo "What is the passphrase for the backup?"
if [ ! -f duplicati-passphrase.txt ]; then
  read -r passphrase
  echo "$passphrase" >duplicati-passphrase.txt
else
  echo "Passphrase already configured in duplicati-passphrase.txt"
fi

echo "What discord URL would you like to use for notifications?"
if [ ! -f discord-url.txt ]; then
  read -r discord_url
  echo "$discord_url" >discord-url.txt
else
  echo "Discord URL already configured in discord-url.txt"
fi
