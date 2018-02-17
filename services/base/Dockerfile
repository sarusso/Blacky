FROM reyns/reyns-base-ubuntu14.04
MAINTAINER Stefano Alberto Russo <stefano.russo@gmail.com>

# Update apt here so if the prject is build without cache we get a refresh
RUN apt-get update

# Create the media user (used for audio/video serivces)
# We chose GID 65527 and UID 65528 to try avoiding conflicts.
#RUN groupadd -g 65528 media
#RUN useradd media -d /media -u 65528 -g 65528 -m -s /bin/bash

# Add the media user to the www-data group (to allow access to certain folders from web)
#RUN usermod -a -G www-data media

# Create base matauser user. We assign the same UID as the user who is building MetaBox to minimize permissions problems.
#RUN useradd metauser -m -s /bin/bash # UID=1001 (if not taken)
RUN groupadd -g 65529 metauser
RUN useradd metauser -d /home/metauser -u 65529 -g 65529 -m -s /bin/bash


# Create other users here. You can just keep the metauser user, change it above, or add your entire family.
#RUN useradd anotheruser1 -m -s /bin/bash # UID=1001 (if not taken)
#RUN useradd anotheruser2 -m -s /bin/bash # UID=1002 (if not taken)


# Blacky userers and UIDs
#drwxr-xr-x  2 1005 1005 4.0K Sep 23 19:07 giu
#drwxr-xr-x 12 1001 1001 4.0K Jul  2 10:43 media
#drwxr-xr-x  2 1002 1002 4.0K Apr  3  2016 mity
#drwxr-xr-x  5 1003 1003 4.0K Apr  2  2016 nino
#drwxr-xr-x 95 1000 1000 4.0K Oct  3 10:51 ste
#drwxr-xr-x  7 1004 1004 4.0K Aug 12  2013 trusso


# Create users
RUN useradd ste -m -s /bin/bash     # 1000
RUN useradd media -m -s /bin/bash   # 1001
RUN useradd mity -m -s /bin/bash    # 1002
RUN useradd nino -m -s /bin/bash    # 1003
RUN useradd trusso -m -s /bin/bash  # 1004
RUN useradd giu -m -s /bin/bash     # 1005


# Add user metauser to sudo
RUN adduser metauser sudo


# Prestartup
COPY prestartup_base.sh /prestartup/

# Disable reyns user over ssh to allow exposing ssh on a public IP (i.e. for the Desktop service)
RUN echo "DenyUsers reyns" >> /etc/ssh/sshd_config

# Add metabox rsa key
COPY keys/metauser.rsa.pub /etc/ssh/metauser.rsa.pub
RUN sudo mkdir -p /home/metauser/.ssh && ln -s /etc/ssh/metauser.rsa.pub /home/metauser/.ssh/authorized_keys && chown -R metauser:metauser /home/metauser/.ssh

# Note 1: If you use the Samba service, you need to achange/dd the users even there.
# Note 2: If you use the Vnc desktop service, you need to change/add the users even there.
# Note 3: Vnc desktop still do not support multiuser.

# Add the media user to the www-data group
# to be able to access ownCloud data from Plex
RUN usermod -a -G www-data media
