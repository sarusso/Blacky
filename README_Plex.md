

#--------------------
#  Server Settings
#--------------------

Rememebr to enter the server setting section!

  Settings -> Server

#--------------------
#  Logs Settings
#--------------------

Plex log are in:

 /home/media/Library/Application\ Support/Plex\ Media\ Server/Logs/Plex\ Media\ Server.log

To enable dubug and/or verbose logging:

 General -> Enable Plex Media Server debug logging
 General -> Enable Plex Media Server verbose logging


#--------------------
#  Network Settings
#--------------------

Network must accept from local net and docker net. If you lock out try using desktop service.

  Network -> List of networks that are allowed without auth" the following:
    "192.168.1.0/255.255.255.0,172.0.0.0/255.0.0.0"

Also, remember to add custom url or Docker / MacServer IPs will be recognized as public (more or less) and will not work

  Network -> Custom server access URLs 
    "blacky.terra32.net" 
