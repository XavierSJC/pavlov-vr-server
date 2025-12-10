# Pavlov VR Servers
This repository provides images with server to the game [Pavlov VR Shack](https://www.meta.com/experiences/pavlov-shack/2443267419018232/) and [Pavlov VR](https://store.steampowered.com/app/555160/Pavlov_VR/)

## Images
**powersjk/pavlov-vr-server**: Pavlov to PC

**powersjk/pavlov-vr-shack-server**: Pavlov to Meta Quest

## Quick Start
The commands below provide a way to start a server with:
* **Name Server:** My Awesome Server
* **Port Server:** 7777
* **RCON Port:** 9100
* **RCON Password:** 5gWXLAKCtBjA

**Warning:** The commands below are just a example, do **NOT** use the same passoword!
### Pavlov STEAM
```
docker run -d --name pavlov-steam-server -p 7777:7777 -p 7777:7777/udp -p 8177:8177 -p 8177:8177/udp -p 9100:9100 -e SERVER_NAME="My Awesome Server" -e RCON_PWD=5gWXLAKCtBjA -e RCON_PORT=9100 -v pavlovPcData:/home/steam/pavlovserver/Pavlov/Saved powersjk/pavlov-vr-server:latest
```

### Pavlov SHACK
```
docker run -d --name pavlov-shack-server -p 7777:7777 -p 7777:7777/udp -p 8177:8177 -p 8177:8177/udp -p 9100:9100 -e SERVER_NAME="My Awesome Server" -e RCON_PWD=5gWXLAKCtBjA -e RCON_PORT=9100 -v pavlovShackData:/home/steam/pavlovserver/Pavlov/Saved powersjk/pavlov-vr-shack-server:latest
```

### Using Docker Compose
Download the file [docker-compose.yml](https://raw.githubusercontent.com/XavierSJC/pavlov-vr-quest-server/main/dockerfiles/docker-compose.yml) and execute:
```
docker compose up
```
**Warning**: Do not forget to change the variables values in the docker-compose.yml file or the image value if you wish to execute the Pavlov to PC.

After executing the command above your server will be available to play.
You can check if your server is available looking for him on the page [Pavlov Horde](https://pavlovhorde.com/).

## Management of your server
### Admin Panel - Shack
The server does not provide an admin panel but provides remote access using the RCON.
To connect with RCON you can follow the steps described in the [Pavlov Wiki](https://pavlovwiki.com/index.php/Rcon_Overview_and_Commands#Connecting_to_RCON).

OR

You can use these sites that provide a UI admin:
* [Pavlov RCON](https://pavlovrcon.com/)
* [Pavlvo HORDE](https://pavlovhorde.com/rcon)

### Admin Panel - PC and Shack
The game has a admin panel on the menu game, to enable this menu put your Quest username on the file `/home/steam/pavlovserver/Pavlov/Saved/Config/mods.txt`

### Management maps
These images don't provide custom maps

#### Installing Custom Maps
The <name_map> must be “UGC” followed by the map ID. 

You can find the map id in the [mod.io](mod.io) page. Choose the map and in the righ side of the page use de number "Resource ID".

### Running multiples servers
In case you are hosting just ONE SERVER, this section is useless.
Case you choose host multiples servers, you need to specify to container which ports use, for this will be necessary to use the environement variable `-e SERVER_PORT`.

The servers use the ports:
|Port|Protocol|Description|
| - | - | - | 
|7777| TCP/UDP | **Default port to game**, using the variable `SERVER_PORT` this port will be changed|
|8177| TCP/UDP | The server user the **default port value** + 400 for communication, when configuring multiple servers, don't forget to enable this port too |
|9100| TCP | **The default port to RCON** |

### Aditional Features
#### Shuffle Rotation map
If you use set the environment variable `SHUFFLE_MAPS=True`, the map rotation will be shuffled always that containner is started/restarted.

#### Auto update
This image checks if the game has a update when started, case you wish to disable it please set the environment variable `UPDATE_SERVER=True`.

#### Create match DB
This image is used with the project [PavlovShackStats](https://github.com/XavierSJC/PavlovShackStats), when used the environment variable `STATS_ENDPOINT` the statistics of the match is sent to a endpoint to be saved and fetch for a API.

___
# To Advanced Docker Users
## To build
You can build any of the images in this repository using the command below:
```
docker build -t <tag>:<label> -f ./dockerfiles/Dockerfile .
```

**Environment Variable**
* **SERVER_NAME**(Mandatory): This is the name of your server
* **SERVER_PORT**(Optional): This is port that the server uses, default value = 7777
* **RCON_PWD**(Optional): Password to enable RCON access.
* **RCON_PORT**(Optional): Port to RCON access, default value = 9100
* **UPDATE_SERVER**(Optional): Update server and client on start the container, default value = "True"
* **SHUFFLE_MAPS**(Optional): Shuffle the map rotation on start the container, default value = "False"
* **STATS_ENDPOINT**(Optional): Configure the server to send the match data for a endpoint specified.


**The RCON is only enabled if you set a password**

## Changes log
[`1.7.0`](https://github.com/XavierSJC/pavlov-vr-quest-server/tree/v1.7.0), [`latest`](https://github.com/XavierSJC/pavlov-vr-quest-server/tree/main): Fixed script to works with docker-compose. Build on Pavlov Version 1.0.26

[`1.6.0`](https://github.com/XavierSJC/pavlov-vr-quest-server/tree/v1.6.0), [`latest`](https://github.com/XavierSJC/pavlov-vr-quest-server/tree/main): Added the shuffle rotation maps and the option to choose the port server. Build on Pavlov Version 1.0.20

[`1.5.0`](https://github.com/XavierSJC/pavlov-vr-quest-server/tree/v1.5.0): Removed the chanel 'shack_beta', this channel was merged to chanel 'shack'

[`1.4.0`](https://github.com/XavierSJC/pavlov-vr-quest-server/tree/v1.4.0): Avoid replace the name server and other configurations when restart the docker

[`1.3.0`](https://github.com/XavierSJC/pavlov-vr-quest-server/tree/v1.3.0): Small improvements to avoid duplicated code

[`1.2.0`](https://github.com/XavierSJC/pavlov-vr-quest-server/tree/v1.2.0): Removed template files

[`1.1.0`](https://github.com/XavierSJC/pavlov-vr-quest-server/tree/v1.1.0): Auto-Update

[`1.0.0`](https://github.com/XavierSJC/pavlov-vr-quest-server/tree/v1.0.0): Initial version


# References
These commands and links used was extracted from the [Pavlovs oficial wiki](https://pavlovwiki.com/index.php/Main_Page)

Doubts about `game_mode`, `name_map`, `ports` please check the link above.

I recommend joining [Pavlovs Discord](https://discord.gg/pavlov-vr), where you will find help and other custom maps.
