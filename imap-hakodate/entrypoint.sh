#!/bin/bash

set -e 

ip route add default via 192.168.103.200 

exec /usr/bin/supervisord -c /etc/supervisor/conf.d/supervisord.conf