

#--------------------
#  Net
#--------------------

In /etc/network/interfaces:

auto enp0s3
iface enp0s3 inet static
    address 192.168.1.214
    netmask 255.255.255.0
    gateway 192.168.1.1
    dns-nameservers 8.8.8.8


#--------------------
#  Raid
#--------------------

In /etc/mdadm/mdadm.conf:

ARRAY /dev/md1 UUID=861c37aa:590bfa14:ffffc990:54fd2123

In /etc/fstab:
UUID=99df4d39-ad59-4d1c-882e-27f32d72eb82 /mnt/md1        ext4    noauto,errors=remount-ro 0       1

WARNING: array might be nabed md127 as well. 

Then:
mkdir /mnt/md1

#--------------------
#  Home folders
#--------------------

sudo mv /home /or_home
sudo ln -s /mnt/md1/home /home

#--------------------
#  Fix Python 2-3
#--------------------

(On Ubuntu server 16 there is no "python" but only "python3")

sudo ln -s /usr/bin/python3 /usr/bin/python 

#--------------------
#  Docker & MetaBox
#--------------------

sudo apt-get update
sudo apt-get install docker.io
sudo usermod -aG docker ste
exit
Then:
/home/ste/Devel/workspaces/BlackyMetaBox/

#--------------------
#  rc.local
#--------------------

# Mount devices
mount /mnt/md1

# Start Blacky-DockerOps project
cd /home/ste/Devel/workspaces/BlackyMetaBox/ && metabox/clean all,force=True && metabox/run all,conf=blacky


#--------------------
# No terminal sleep
#--------------------

In /etc/default/grub:
GRUB_CMDLINE_LINUX_DEFAULT="quiet splash consoleblank=0"

Then:
sudo update-grub



