#!/bin/bash
echo "Configuring Pavlov Server"
if [ "$UPDATE_SERVER" = "True" ] 
then
    /home/steam/pavlovserver/update_pavlov.sh
fi

if [ "$SERVER_NAME" = "Your_name_server" ] 
then
    echo "Please use the environment variable SERVER_NAME to configure a name for your server"
    exit 1
fi
cp -f /home/steam/pavlovserver/Pavlov/Saved/Config/LinuxServer/Game.ini.template /home/steam/pavlovserver/Pavlov/Saved/Config/LinuxServer/Game.ini
sed -i "s/Your_name_server/$SERVER_NAME/" /home/steam/pavlovserver/Pavlov/Saved/Config/LinuxServer/Game.ini
echo "Updated the name server to $SERVER_NAME"

if [ "$RCON_PWD" != "ChangeThisPassword" ] 
then
    cp -f /home/steam/pavlovserver/Pavlov/Saved/Config/RconSettings.txt.template /home/steam/pavlovserver/Pavlov/Saved/Config/RconSettings.txt
    sed -i "s/ChangeThisPassword/$RCON_PWD/" /home/steam/pavlovserver/Pavlov/Saved/Config/RconSettings.txt
    sed -i "s/9100/$RCON_PORT/" /home/steam/pavlovserver/Pavlov/Saved/Config/RconSettings.txt

    echo "Updated RCON password"
    echo "Updated port RCON to $RCON_PORT"
fi

echo "Starting Pavlov Server"
/home/steam/pavlovserver/PavlovServer.sh