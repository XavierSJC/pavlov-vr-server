#!/bin/sh
set -e

echo "Running container validation..."

EXPECTED_SERVER_NAME="My Awesome Server"
EXPECTED_RCON_PWD="5gWXLAKCtBjA"
EXPECTED_RCON_PORT="9100"

# Validate RCON settings
if ! grep -q "Password=${EXPECTED_RCON_PWD}" /home/steam/pavlovserver/Pavlov/Saved/Config/RconSettings.txt; then
  echo "❌ Invalid RCON password configuration"
  exit 1
fi

if ! grep -q "Port=${EXPECTED_RCON_PORT}" /home/steam/pavlovserver/Pavlov/Saved/Config/RconSettings.txt; then
  echo "❌ Invalid RCON port configuration"
  exit 1
fi

# Validate server settings
if ! grep -q "ServerName=\"${EXPECTED_SERVER_NAME}\"" /home/steam/pavlovserver/Pavlov/Saved/Config/LinuxServer/Game.ini; then
  echo "❌ Invalid RCON port configuration"
  exit 1
fi

echo "✅ All validations passed"
