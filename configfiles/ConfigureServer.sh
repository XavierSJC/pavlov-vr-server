#!/bin/bash
echo "Configuring Pavlov Server"
if [ "$UPDATE_SERVER" = "True" ] 
then
    /home/steam/pavlovserver/install_pavlov.sh
fi

if [ "$SERVER_NAME" = "Your_name_server" ] 
then
    echo "Please use the environment variable SERVER_NAME to configure a name for your server"
    exit 1
fi
sed -i "/ServerName=/c\ServerName=\"$SERVER_NAME\"" /home/steam/pavlovserver/Pavlov/Saved/Config/LinuxServer/Game.ini
echo "Updated the name server to $SERVER_NAME"

if [ "$RCON_PWD" != "ChangeThisPassword" ] 
then
    sed -i "/Password=/c\Password=$RCON_PWD" /home/steam/pavlovserver/Pavlov/Saved/Config/RconSettings.txt
    echo "Updated RCON password"

    sed -i "/Port=/c\Port=$RCON_PORT" /home/steam/pavlovserver/Pavlov/Saved/Config/RconSettings.txt
    echo "Updated port RCON to $RCON_PORT"
fi

echo "Starting Pavlov Server"
/home/steam/pavlovserver/PavlovServer.sh