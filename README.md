# Pavlov VR Shack Server
This image provides a server to Pavlov VR Shack (Meta Quest only)


## The Image
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
* **UPDATE_SERVER**(Optional): Update steam client and Pavlov Server when starting container, default value = True

The RCON is only enabled if you set a password.

The Pavlov Server and the Steam client always update when the container starts, except if you change it.

### Compose
```
docker-compose up -d
```
You can use the file `.env` to set all the variables

**Warning**: Do not forget to change the variable SERVER_NAME.


## Maps
This image has all the images from [Pavlov Horde](https://pavlovhorde.com/mapsList).
For default only the maps `datacenter` and `sand` are available, to enable the map please remove the comments tags in the file `Game.ini.template` and restart your container.

## Custom Maps
You can add new maps, to do this you will need to download them and copy to folder `/home/steam/pavlovserver/Pavlov/Saved/maps`.

After downloading the maps, enable the maps adding this line in the file `Game.ini.template` and restart the server.
```
MapRotation=(MapId="<name_map>", GameMode="<game_mode>") 
```
You can access a list of custom maps by this [link](https://pavlovhorde.com/mapsList)

## Check server
You can check if your server is available looking for him on the page:
https://pavlovhorde.com/

# Reference
These commands and links used was extracted from http://wiki.pavlov-vr.com/index.php?title=Dedicated_server

Doubts about `game_mode`,  `name_map`, `ports` please check the link above.