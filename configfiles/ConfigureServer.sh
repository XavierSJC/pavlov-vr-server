#!/bin/bash
echo "Configuring Pavlov Server"
if [ "$UPDATE_SERVER" = "True" ]; then
    install_pavlov=$(find /home/steam/pavlovserver/ -name 'install_pavlov_*')
    $install_pavlov
fi

if [ "$SERVER_NAME" = "Your_name_server" ]; then
    echo "Please use the environment variable SERVER_NAME to configure a name for your server"
    exit 1
fi
sed -i "/ServerName=\"Your_name_server\"/c\ServerName=\"$SERVER_NAME\"" /home/steam/pavlovserver/Pavlov/Saved/Config/LinuxServer/Game.ini
echo "Updated the name server to $SERVER_NAME"

if [ "$RCON_PWD" != "ChangeThisPassword" ]; then
    sed -i "/Password=ChangeThisPassword/c\Password=$RCON_PWD" /home/steam/pavlovserver/Pavlov/Saved/Config/RconSettings.txt
    echo "Updated RCON password"

    sed -i "/Port=0000/c\Port=$RCON_PORT" /home/steam/pavlovserver/Pavlov/Saved/Config/RconSettings.txt
    echo "Updated port RCON to $RCON_PORT"
fi

if [ "$SHUFFLE_MAPS" = "True" ]; then
    echo "Shuffling map rotation"
    /home/steam/pavlovserver/shuffleMaps.sh /home/steam/pavlovserver/Pavlov/Saved/Config/LinuxServer/Game.ini
fi

if [ "$STATS_ENDPOINT" != "/api/PavlovShackStats/" ]; then
    echo "Starting export stats task"
    /home/steam/pavlovserver/ExportPavlovShackStats.sh $STATS_ENDPOINT >> /home/steam/pavlovserver/Pavlov/Saved/Logs/ExportPavlovShackStats.log &
fi

echo "Starting Pavlov Server"
/home/steam/pavlovserver/PavlovServer.sh -PORT=$SERVER_PORT