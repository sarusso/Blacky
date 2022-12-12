# Blacky

## Requirements

To build Blacky, you need Docker, Git, Python and Bash, plus Internet connectivity.

This version is based on Ubuntu 20.04

## Services

* Proxy: proxy and light web services, including access to Desktop's web-based VNC.

* Samba: provides access for files in the "Data" folder of metauser home directory trough Samba (Windows File Sharing protocol).

* Zeroconf: provides zero configuration for services discovery when running on a LAN network or VPN.

* Hamachi: provides access to the host through Hamachi VPN service. Requires creating an account on Hamachi's website. Read more below.

* ownCloud: a dropbox-like solution.

* Plex: a media server.

## Build

    $ blacky/build [service]

## Run

    $ blacky/run [service]


## List

    $ blacky/ps

## Shell

    $ blacky/shell service

## Stop

    $ blacky/clean [service]

## Rerun

    $ blacky/rerun [service]

## Logs

    $ blacky/logs service [process]

Examples:
    
    $ blacky/logs hamachi [hamachi]
    $ blacky/logs samba [smbd,nmbd]
    $ blacky logs proxy [apache]
    $ blacky logs owncloud [apache,mysql]

## Authentication

Default user is metauser. Default password for Web and Files services: "metapass". Change it!!

For Apache (with the service running):

    $ blacky/shell apache
    $ cd /data && sudo htpasswd -bc htpasswd metauser YOUR_NEW_PASS
    $ exit
    $ blacky/rerun apache

For Samba (with the service running):

    $ blacky/shell samba
    $ sudo bash -c "(echo YOUR_NEW_PASS; echo YOUR_NEW_PASS) | smbpasswd -a metauser"
    $ exit
    $ blacky/rerun samba


## Setting up the Hamachi VPN

MetaBox uses Hamachi to provide VPN access which, even if requires a third-party intermediary (their servers), provides an extremely simplified setup process. Moreover, once established, the connection is directly tunneled to your MetaBox host in the majority of the cases, even across Firewalls and NATs.

To set it up, first you need to go on http://vpn.net (Hamachi's website) and signup for a free account. Then you need to create a new network. We suggest type "mesh", without password, and to require members approval. Copy the network ID (in the format xxx-yyy-zzz, if you already created the network you can find it under the "Members" section). Then:

    $ blacky/shell hamachi
    $ hamachi login
    $ hamachi  # Will show status
    $ hamachi do-join xxx-yyy-zzz  # Type [enter] on password prompt
    
Now, on vpn.net, accept the new join request you will see. Then:
    
    $ hamachi  # Will show status    
    $ exit
    $ exit

The final step is to install the Hamachi client for tour laptop and join the network from there as well. Your MetaBox will be assigned a static private IP, which will never change (unless you delete MetaBox's data folder).


## Certificates for the proxy

Certificates can be automatically handled with Letsencrypt. By default, a snakeoil certificate is used. To set up letsencrypt, first of all run inside the proxy (only once in its lifetime):

	$ sudo rm -rf /etc/letsencrypt/live/blacky.terra32.net

Then, edit the `/etc/apache2/sites-available/proxy-global.conf` file and change the certificates for the domain that you want to enable with Letsencrypt to use snakeoils (otherwise nex comamnd will fail), then:

	$  sudo apache2ctl -k graceful

Now:

    $ sudo certbot certonly --apache --register-unsafely-without-email --agree-tos -d blacky.terra32.net
    
...or for the domain that you want to enable with Letsencrypt. This will initialize the certificate in /etc/letsencypt, which is stored on the host in `./data/proxy/letsencrypt`

Finally, re-change the `/etc/apache2/sites-available/proxy-global.conf` file to use the correct certificates for the domain (or just restart the proxy service but wiht clean and then run).



## Internal passwords:

Mysql: root:r92cg479, oc_ste:297gr30r
