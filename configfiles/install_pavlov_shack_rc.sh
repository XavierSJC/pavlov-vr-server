#!/bin/bash

if [ -f "~/Steam/steamcmd.sh" ];
then
echo -e "Beginning Pavlov VR update run on $(date)\n\n"
else
  echo "Installing Steam client"
  mkdir ~/Steam && cd ~/Steam && curl -sqL "https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz" | tar zxvf -
  mkdir -p ~/.steam/sdk64
fi

echo "Installing Pavlov Steam"
~/Steam/steamcmd.sh +force_install_dir /home/steam/pavlovserver +login anonymous +app_update 622970 -beta shack_beta +exit
chmod +x ~/pavlovserver/PavlovServer.sh

echo "Updating Steam Client"
~/Steam/steamcmd.sh +login anonymous +app_update 1007 +quit
cp ~/Steam/steamapps/common/Steamworks\ SDK\ Redist/linux64/steamclient.so ~/.steam/sdk64/steamclient.so
cp ~/Steam/steamapps/common/Steamworks\ SDK\ Redist/linux64/steamclient.so ~/pavlovserver/Pavlov/Binaries/Linux/steamclient.so
