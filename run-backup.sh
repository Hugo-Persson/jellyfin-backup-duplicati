#!/bin/bash
cleanup() {

  systemctl start jellyfin
}

# Run cleanup function on EXIT
trap cleanup EXIT
systemctl stop jellyfin

URL="$(cat ./backup-url.txt)"
DUPLICATI_PASSPHRASE="$(cat ./duplicati-passphrase.txt)"

duplicati-cli backup "$URL" \
  "/var/lib/jellyfin" \
  "/etc/jellyfin" \
  --dblock-size=50mb \
  --backup-name="jellyfin" \
  --passphrase="$DUPLICATI_PASSPHRASE" \
  --retention-policy="1W:1D,4W:1W,12M:1M"
