# Pavlov VR Shack Server
This image provides a server to Pavlov VR Shack (Meta Quest only)


## The Image

### Tags
`1.1.0`, `latest`: All maps of [PavlovHorde](https://pavlovhorde.com/mapsList) and Auto-Update

`1.0.0`: Initial version, few maps

### To build
```
docker build -t <tag>:<label> -f ./dockerfiles/Dockerfile .
```

### To execute this container
```
docker run -d --name pavlov-shack-server -p 7000:7000/udp -p 7400:7400/udp -p 7777:7777 -p 7777:7777/udp -p 8177:8177 -p 8177:8177/udp -p 9100:9100 -e SERVER_NAME=<your_server_name> -e [RCON_PWD=<rcon_password>] -e [RCON_PORT=<rcon_port>] -v pavlovData:/home/steam/pavlovserver/Pavlov/Saved powersjk/pavlov-vr-shack-server:latest
```

**Environment Variable**
* **SERVER_NAME**(Mandatory): This is the name of your server
* **RCON_PWD**(Optional): Password to enable the RCON access.
* **RCON_PORT**(Optional): Port to RCON access, default value = 9100

The RCON is only enabled if you set a password

### Compose
```
docker-compose up -d
```
**Warning**: Do not forget to change the variable SERVER_NAME in the docker-compose.yml file (or add new variables).

## Maps
This image provides only the maps available in the  

## Custom Maps
To download more maps you will need to download them and copy to folder `/home/steam/pavlovserver/Pavlov/Saved/maps`.
You can download all the custom maps using this [script](https://cdn.discordapp.com/attachments/841189246903386122/898218113223516241/inst-all.sh).

One copy of this script already exists in the folder `/home/steam/pavlovserver/Pavlov/Saved/maps`, you can run it :smiley:.

After downloading the maps, enable the maps adding this line in the file `Game.ini`
```
MapRotation=(MapId="<name_map>", GameMode="<game_mode>") 
```
You can see a list of these lines in the file `/home/steam/pavlovserver/Pavlov/Saved/Config/LinuxServer/maplist.txt`

## Check server
You can check if your server is available looking for him on the page:
https://pavlovhorde.com/

# Reference
These commands and links used was extracted from http://wiki.pavlov-vr.com/index.php?title=Dedicated_server

Doubts about `game_mode`,  `name_map`, `ports` please check the link above.


