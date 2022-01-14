FROM ubuntu:20.04

LABEL maintainer "XavierSJC"

ENV SERVER_NAME=Your_name_server
ENV RCON_PWD=ChangeThisPassword
ENV RCON_PORT=9100
ENV UPDATE_SERVER=True

# Install steam and create user
RUN apt update && apt install -y gdb curl wget nano lib32gcc1 libc++-dev unzip 
RUN useradd -m steam
USER steam

# Install Pavlov Shack Server
RUN mkdir ~/Steam && cd ~/Steam && curl -sqL "https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz" | tar zxvf -
RUN ~/Steam/steamcmd.sh +login anonymous +force_install_dir /home/steam/pavlovserver +app_update 622970 -beta shack +exit
RUN ~/Steam/steamcmd.sh +login anonymous +app_update 1007 +quit

# Update Steam client
RUN mkdir -p ~/.steam/sdk64
RUN cp ~/Steam/steamapps/common/Steamworks\ SDK\ Redist/linux64/steamclient.so ~/.steam/sdk64/steamclient.so
RUN cp ~/Steam/steamapps/common/Steamworks\ SDK\ Redist/linux64/steamclient.so ~/pavlovserver/Pavlov/Binaries/Linux/steamclient.so

# Make script runnable
RUN chmod +x ~/pavlovserver/PavlovServer.sh

# Server configuration
RUN mkdir -p /home/steam/pavlovserver/Pavlov/Saved/Logs
RUN mkdir -p /home/steam/pavlovserver/Pavlov/Saved/Config/LinuxServer
RUN mkdir -p /home/steam/pavlovserver/Pavlov/Saved/maps

RUN touch /home/steam/pavlovserver/Pavlov/Saved/Config/mods.txt
RUN touch /home/steam/pavlovserver/Pavlov/Saved/Config/blacklist.txt
RUN touch /home/steam/pavlovserver/Pavlov/Saved/Config/whitelist.txt

# Configuration and map list
COPY --chown=steam:steam ../configfiles/Game.ini.template /home/steam/pavlovserver/Pavlov/Saved/Config/LinuxServer/

# Configure RCON
COPY --chown=steam:steam ../configfiles/RconSettings.txt.template /home/steam/pavlovserver/Pavlov/Saved/Config/

COPY --chown=steam:steam ../configfiles/ConfigureServer.sh /home/steam/pavlovserver/
COPY --chown=steam:steam ../configfiles/update_pavlov.sh /home/steam/pavlovserver/

# Update the templates files by the environment variables
RUN chmod +x /home/steam/pavlovserver/ConfigureServer.sh
RUN chmod +x /home/steam/pavlovserver/update_pavlov.sh

EXPOSE 7000/udp 7400/udp 7777 7777/udp 8177 8177/udp 9100

ENTRYPOINT ["/home/steam/pavlovserver/ConfigureServer.sh"]