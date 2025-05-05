#!/bin/bash

set -e 

ip route add default via 192.168.101.200 

exec /usr/bin/supervisord -c /etc/supervisor/conf.d/supervisord.conf