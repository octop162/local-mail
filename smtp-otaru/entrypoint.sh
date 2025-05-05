#!/bin/bash
set -e

ip route add default via 192.168.101.200 

cp /etc/resolv.conf /var/spool/postfix/etc/resolv.conf

exec postfix start-fg
