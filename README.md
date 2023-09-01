# Pavlov VR Servers
This repository provides images with server to the game [Pavlov VR Shack](https://www.oculus.com/experiences/quest/3649611198468269) and [Pavlov VR](https://store.steampowered.com/app/555160/Pavlov_VR/)

## Quick Start
The commands below provide a way to start a server with:
* **Name Server:** My Awesome Server
* **RCON Port:** 9100
* **RCON Password:** 5gWXLAKCtBjA

**Warning:** The commands below are just a example, do **NOT** use the same passoword!
### Pavlov STEAM
```
docker run -d --name pavlov-steam-server -p 7000:7000/udp -p 7400:7400/udp -p 7777:7777 -p 7777:7777/udp -p 8177:8177 -p 8177:8177/udp -p 9100:9100 -e SERVER_NAME="My Awesome Server" -e RCON_PWD=5gWXLAKCtBjA -e RCON_PORT=9100 -v pavlovPcData:/home/steam/pavlovserver/Pavlov/Saved powersjk/pavlov-vr-server:latest
```

### Pavlov SHACK
```
docker run -d --name pavlov-shack-server -p 7000:7000/udp -p 7400:7400/udp -p 7777:7777 -p 7777:7777/udp -p 8177:8177 -p 8177:8177/udp -p 9100:9100 -e SERVER_NAME="My Awesome Server" -e RCON_PWD=5gWXLAKCtBjA -e RCON_PORT=9100 -v pavlovShackData:/home/steam/pavlovserver/Pavlov/Saved powersjk/pavlov-vr-shack-server:latest
```

After executing the command above your server will be available to play.
You can check if your server is available looking for him on the page [Pavlov Horde](https://pavlovhorde.com/).
Pay attention if you selected the right list ([Shack](https://pavlovhorde.com/) or [PC](https://pavlovhorde.com/pcServers)).

## Management of your server
### Admin Panel - Shack
The server does not provide an admin panel but provides remote access using the RCON.
To connect with RCON you can follow the steps described in the [Pavlov Wiki](http://wiki.pavlov-vr.com/index.php?title=Dedicated_server#Connecting_to_RCON).

OR

You can use these sites that provide a UI admin:
* [Pavlov RCON](https://pavlovrcon.com/)
* [Pavlvo HORDE](https://pavlovhorde.com/rcon)

### Admin Panel - PC and Shack RC
The game has a admin panel on the menu game, to enable this menu put your Quest username on the file `/home/steam/pavlovserver/Pavlov/Saved/Config/mods.txt`

### Management maps
These images don't provide custom maps

#### Installing Custom Maps
The <name_map> must be “UGC” followed by the map ID. 

You can find the map id in the [mod.io](mod.io) page. Choose the map and in the righ side of the page use de number "Resource ID".

___
# To Advanced Docker Users
## To build
You can build any of the images in this repository using the command below:
```
docker build -t <tag>:<label> -f ./dockerfiles/Dockerfile .
```

**Environment Variable**
* **SERVER_NAME**(Mandatory): This is the name of your server
* **RCON_PWD**(Optional): Password to enable RCON access.
* **RCON_PORT**(Optional): Port to RCON access, default value = 9100
* **UPDATE_SERVER**(Optional): Update server and client on start the container, default value = "True"

The RCON is only enabled if you set a password

## Docker Compose
You can use a compose file example to start your server.
Download the file [docker-compose.yml](https://raw.githubusercontent.com/XavierSJC/pavlov-vr-quest-server/main/dockerfiles/docker-compose.yml) and execute:
```
docker-compose up -d
```
**Warning**: Do not forget to change the variable SERVER_NAME in the docker-compose.yml file (and other variables either).

## Changes log
[`1.5.0`](https://github.com/XavierSJC/pavlov-vr-quest-server/tree/v1.5.0), [`latest`](https://github.com/XavierSJC/pavlov-vr-quest-server/tree/main): Removed the chanel 'shack_beta', this channel was merged to chanel 'shack'

[`1.4.0`](https://github.com/XavierSJC/pavlov-vr-quest-server/tree/v1.4.0), [`latest`](https://github.com/XavierSJC/pavlov-vr-quest-server/tree/main): Avoid replace the name server and other configurations when restart the docker

[`1.3.0`](https://github.com/XavierSJC/pavlov-vr-quest-server/tree/v1.3.0): Small improvements to avoid duplicated code

[`1.2.0`](https://github.com/XavierSJC/pavlov-vr-quest-server/tree/v1.2.0): Removed template files

[`1.1.0`](https://github.com/XavierSJC/pavlov-vr-quest-server/tree/v1.1.0): Auto-Update

[`1.0.0`](https://github.com/XavierSJC/pavlov-vr-quest-server/tree/v1.0.0): Initial version


# References
These commands and links used was extracted from the [Pavlovs oficial wiki](http://wiki.pavlov-vr.com/index.php?title=Dedicated_server)

Doubts about `game_mode`, `name_map`, `ports` please check the link above.

I recommend joining [Pavlovs Discord](https://discord.gg/pavlov-vr), where you will find help and other custom maps.