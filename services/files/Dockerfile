FROM blackymetabox/base
MAINTAINER Stefano Alberto Russo <stefano.russo@gmail.com>

# Install Samba
RUN apt-get update
RUN apt-get install -y samba

# Copy conf
COPY smb_blacky.conf /etc/samba/smb.conf

# Create samba users. Linux user MUST exists!
RUN (echo metapass; echo metapass) | smbpasswd -a metauser
RUN (echo pippopluto; echo pippoplutoweno) | smbpasswd -a ste
RUN (echo pippopluto; echo pippoplutowena) | smbpasswd -a giu
#RUN (echo pippopluto; echo pippopluto) | smbpasswd -a media

# Create link to home on /mnt/md1 (mounted trought volumes)
RUN rm -rf /home/ste   && ln -s /mnt/md1/home/ste   /home/ste
RUN rm -rf /home/giu   && ln -s /mnt/md1/home/giu   /home/giu
RUN rm -rf /home/media && ln -s /mnt/md1/home/media /home/media

# Setup supervisord
COPY supervisord_smbd.conf /etc/supervisor/conf.d/
COPY supervisord_nmbd.conf /etc/supervisor/conf.d/

# reyns: expose 445/tcp

