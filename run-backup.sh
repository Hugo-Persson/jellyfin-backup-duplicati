#!/bin/bash
cleanup() {

  systemctl start jellyfin
}

# Run cleanup function on EXIT
trap cleanup EXIT
# CD to the directory of the script

cd "$(dirname "$0")" || exit

discord_url="$(cat ./discord-url.txt)"

# Define a function to send a message
send_discord_notification() {
  local message=$1

  # Construct payload using jq for proper JSON escaping
  local payload=$(jq -n --arg content "$message" '{"content": $content}')

  # Send POST request to Discord Webhook
  curl -H "Content-Type: application/json" -X POST -d "$payload" $discord_url
}

send_discord_notification "Starting Jellyfin backup"

systemctl stop jellyfin

URL="$(cat ./backup-url.txt)"
DUPLICATI_PASSPHRASE="$(cat ./duplicati-passphrase.txt)"

output=$(duplicati-cli backup "$URL" \
  "/var/lib/jellyfin" \
  "/etc/jellyfin" \
  --dblock-size=50mb \
  --backup-name="jellyfin" \
  --passphrase="$DUPLICATI_PASSPHRASE" \
  --retention-policy="1W:1D,4W:1W,12M:1M" | tee /dev/tty | tail -n 10)

echo "Done: $output"
send_discord_notification "$output"
