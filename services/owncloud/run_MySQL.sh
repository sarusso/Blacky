#!/bin/bash

# Source env
source /env.sh

# Ensure right permissions
chown -R mysql:mysql /mnt/md1/var/lib/mysql

# Exec Apache in foreground
exec sudo -u mysql /usr/bin/mysqld_safe
