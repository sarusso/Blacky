#!/bin/bash

#----------------------
# Main Blacky
#----------------------

# Always create dir if not existent
mkdir -p /etc/letsencrypt/live/$BLACKY_HOST/

# If there are no certificates, use snakeoils
if [ ! -f "/etc/letsencrypt/live/$BLACKY_HOST/cert.pem" ]; then
    echo "Using default self-signed certificate cer file for $BLACKY_HOST as not existent..."
    cp -a /root/certificates/selfsigned.crt /etc/letsencrypt/live/$BLACKY_HOST/cert.pem
else
    echo "Not using default self-signed certificate cer file for $BLACKY_HOST as already existent."
fi

if [ ! -f "/etc/letsencrypt/live/$BLACKY_HOST/privkey.pem" ]; then
    echo "Using default self-signed certificate privkey file for $BLACKY_HOST as not existent..."
    cp -a /root/certificates/selfsigned.key /etc/letsencrypt/live/$BLACKY_HOST/privkey.pem
else
    echo "Not using default self-signed certificate privkey file for $BLACKY_HOST as already existent."
fi

if [ ! -f "/etc/letsencrypt/live/$BLACKY_HOST/fullchain.pem" ]; then
    echo "Using default self-signed certificate fullchain file for $BLACKY_HOST as not existent..."
    cp -a /root/certificates/selfsigned.ca-bundle /etc/letsencrypt/live/$BLACKY_HOST/fullchain.pem
else
    echo "Not using default self-signed certificate fullchain file for $BLACKY_HOST as already existent."
fi


#----------------------
# Plex Blacky
#----------------------

# Always create dir if not existent
mkdir -p /etc/letsencrypt/live/plex.$BLACKY_HOST/

# If there are no certificates, use snakeoils
if [ ! -f "/etc/letsencrypt/live/plex.$BLACKY_HOST/cert.pem" ]; then
    echo "Using default self-signed certificate cer file for plex.$BLACKY_HOST as not existent..."
    cp -a /root/certificates/selfsigned.crt /etc/letsencrypt/live/plex.$BLACKY_HOST/cert.pem
else
    echo "Not using default self-signed certificate cer file for plex.$BLACKY_HOST as already existent."
fi

if [ ! -f "/etc/letsencrypt/live/plex.$BLACKY_HOST/privkey.pem" ]; then
    echo "Using default self-signed certificate privkey file for plex.$BLACKY_HOST as not existent..."
    cp -a /root/certificates/selfsigned.key /etc/letsencrypt/live/plex.$BLACKY_HOST/privkey.pem
else
    echo "Not using default self-signed certificate privkey file for plex.$BLACKY_HOST as already existent."
fi

if [ ! -f "/etc/letsencrypt/live/plex.$BLACKY_HOST/fullchain.pem" ]; then
    echo "Using default self-signed certificate fullchain file for plex.$BLACKY_HOST as not existent..."
    cp -a /root/certificates/selfsigned.ca-bundle /etc/letsencrypt/live/plex.$BLACKY_HOST/fullchain.pem
else
    echo "Not using default self-signed certificate fullchain file for plex.$BLACKY_HOST as already existent."
fi


#----------------------
# Owncloud Blacky
#----------------------

# Always create dir if not existent
mkdir -p /etc/letsencrypt/live/owncloud.$BLACKY_HOST/

# If there are no certificates, use snakeoils
if [ ! -f "/etc/letsencrypt/live/owncloud.$BLACKY_HOST/cert.pem" ]; then
    echo "Using default self-signed certificate cer file for owncloud.$BLACKY_HOST as not existent..."
    cp -a /root/certificates/selfsigned.crt /etc/letsencrypt/live/owncloud.$BLACKY_HOST/cert.pem
else
    echo "Not using default self-signed certificate cer file for owncloud.$BLACKY_HOST as already existent."
fi

if [ ! -f "/etc/letsencrypt/live/owncloud.$BLACKY_HOST/privkey.pem" ]; then
    echo "Using default self-signed certificate privkey file for owncloud.$BLACKY_HOST as not existent..."
    cp -a /root/certificates/selfsigned.key /etc/letsencrypt/live/owncloud.$BLACKY_HOST/privkey.pem
else
    echo "Not using default self-signed certificate privkey file for owncloud.$BLACKY_HOST as already existent."
fi

if [ ! -f "/etc/letsencrypt/live/owncloud.$BLACKY_HOST/fullchain.pem" ]; then
    echo "Using default self-signed certificate fullchain file for owncloud.$BLACKY_HOST as not existent..."
    cp -a /root/certificates/selfsigned.ca-bundle /etc/letsencrypt/live/owncloud.$BLACKY_HOST/fullchain.pem
else
    echo "Not using default self-signed certificate fullchain file for owncloud.$BLACKY_HOST as already existent."
fi


#----------------------
# Final commands
#----------------------

# Replace the BLACKY_HOST in the Apache proxy conf. Directly using an env var doen not wotk
# with the letsencryot client, which has a bug: https://github.com/certbot/certbot/issues/8243
sudo sed -i "s/__BLACKY_HOST__/$BLACKY_HOST/g" /etc/apache2/sites-available/proxy-global.conf
