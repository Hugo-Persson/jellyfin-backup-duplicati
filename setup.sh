#!/bin/bash

# Check if Duplicati is already installed
if ! command -v duplicati-cli >/dev/null 2>&1; then
  echo "Installing Duplicati..."
  ./install-linux.sh
else
  echo "Duplicati is already installed"
fi

echo "What is the URL of the backup destination?"
read -r url
echo "$url" >backup-url.txt

echo "What is the passphrase for the backup?"
read -r passphrase
echo "$passphrase" >duplicati-passphrase.txt
