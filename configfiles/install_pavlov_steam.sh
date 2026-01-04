#!/bin/bash
set -euo pipefail

STEAM_HOME="/home/steam"
INSTALL_DIR="${STEAM_HOME}/pavlovserver"
SDK_SRC="$STEAM_HOME/Steam/steamapps/common/Steamworks SDK Redist/linux64/steamclient.so"

echo -e "Beginning Pavlov VR update run on $(date)\n\n"

echo "Updating Steam Client"
"$STEAM_HOME/steamcmd/steamcmd.sh" +login anonymous +app_update 1007 +quit

echo "Installing Pavlov Steam"
mkdir -p "$HOME/.steam/sdk64"
"$STEAM_HOME/steamcmd/steamcmd.sh" +force_install_dir $INSTALL_DIR +login anonymous +app_update 622970 +exit
chmod +x $INSTALL_DIR/PavlovServer.sh
cp "$SDK_SRC" "$STEAM_HOME/.steam/sdk64/steamclient.so"
cp "$SDK_SRC" "$STEAM_HOME/pavlovserver/Pavlov/Binaries/Linux/steamclient.so"
