#!/bin/bash

USER="steam"
INSTALLDIRNAME="pavlovserver"
USERHOME="/home/$USER"

echo -e "Beginning Pavlov VR update run on $(date)\n\n"

"$USERHOME/Steam/steamcmd.sh" +login anonymous +force_install_dir "$USERHOME/$INSTALLDIRNAME" +app_update 622970 +exit
"$USERHOME/Steam/steamcmd.sh" +login anonymous +app_update 1007 +quit
cp "$USERHOME/Steam/steamapps/common/Steamworks SDK Redist/linux64/steamclient.so" "$USERHOME/.steam/sdk64/steamclient.so"
cp "$USERHOME/Steam/steamapps/common/Steamworks SDK Redist/linux64/steamclient.so" "$USERHOME/pavlovserver/Pavlov/Binaries/Linux/steamclient.so"

echo -e "Ending Pavlov VR update run on $(date)"
