# Pavlov VR Shack Server
This image provides a server to Pavlov VR Shack (Meta Quest only)

If you wish for other kinds of servers (Shack RC, PC, or PC Beta), you can build your own image.
Just clone this repository, change line 13 at file [`configfiles/install_pavlov.sh`](https://raw.githubusercontent.com/XavierSJC/pavlov-vr-quest-server/main/configfiles/install_pavlov.sh) to:
* **PC**: 
~/Steam/steamcmd.sh +force_install_dir /home/steam/pavlovserver +login anonymous +app_update 622970 +exit

* **PC Beta**: 
~/Steam/steamcmd.sh +force_install_dir /home/steam/pavlovserver +login anonymous +app_update 622970 -beta beta_server +exit

* **Shack RC**: 
~/Steam/steamcmd.sh +force_install_dir /home/steam/pavlovserver +login anonymous +app_update 622970 -beta shack_beta +exit

## To build
```
docker build -t <tag>:<label> -f ./dockerfiles/Dockerfile .
```

## The Image

### Tags
[`1.3.0`](https://github.com/XavierSJC/pavlov-vr-quest-server/tree/v1.3.0), [`latest`](https://github.com/XavierSJC/pavlov-vr-quest-server/tree/main): Small improvements to avoid duplicated code

[`1.2.0`](https://github.com/XavierSJC/pavlov-vr-quest-server/tree/v1.2.0): Removed template files

[`1.1.0`](https://github.com/XavierSJC/pavlov-vr-quest-server/tree/v1.1.0): Auto-Update

[`1.0.0`](https://github.com/XavierSJC/pavlov-vr-quest-server/tree/v1.0.0): Initial version

### To execute this container
```
docker run -d --name pavlov-shack-server -p 7000:7000/udp -p 7400:7400/udp -p 7777:7777 -p 7777:7777/udp -p 8177:8177 -p 8177:8177/udp -p 9100:9100 -e SERVER_NAME=<your_server_name> [-e RCON_PWD=<rcon_password>] [-e RCON_PORT=<rcon_port>] [-e UPDATE_SERVER=True] -v pavlovData:/home/steam/pavlovserver/Pavlov/Saved powersjk/pavlov-vr-shack-server:latest
```

**Environment Variable**
* **SERVER_NAME**(Mandatory): This is the name of your server
* **RCON_PWD**(Optional): Password to enable the RCON access.
* **RCON_PORT**(Optional): Port to RCON access, default value = 9100
* **UPDATE_SERVER**(Optional): Update server and client on start the container, default value = "True"

The RCON is only enabled if you set a password

### Compose
```
docker-compose up -d
```
**Warning**: Do not forget to change the variable SERVER_NAME in the docker-compose.yml file (or changes the other variables).

## Maps
This image doesn't provides custom maps

## Custom Maps
To download more maps you will need to download them and copy to folder `/home/steam/pavlovserver/Pavlov/Saved/maps`.
You can download custom maps in the PavlovHorde.com [here](https://drive.google.com/drive/folders/1m_CSwuqJ2TdO56jY0Kv-YgrV0-LKJHav) or in PavlovQuest.com [here](https://app.mediafire.com/68y2fkoxhik3b).

After downloaded the maps, enable the maps adding this line in the file `Game.ini`
```
MapRotation=(MapId="<name_map>", GameMode="<game_mode>") 
```
You can see a list of these lines in the file `/home/steam/pavlovserver/Pavlov/Saved/Config/LinuxServer/maplist.txt`

## Check server
You can check if your server is available looking for him on the page:
https://pavlovhorde.com/

# Reference
These commands and links used was extracted from the [Pavlovs oficial wiki](http://wiki.pavlov-vr.com/index.php?title=Dedicated_server)

Doubts about `game_mode`,  `name_map`, `ports` please check the link above.

I recommend joining [Pavlovs Discord](https://discord.gg/pavlov-vr), where you will find help and other custom maps.