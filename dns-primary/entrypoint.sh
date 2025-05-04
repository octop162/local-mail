#!/bin/bash
set -e

# 設定ファイルの権限を修正
chown -R bind:bind /etc/bind /var/cache/bind /var/lib/bind 2>/dev/null || true

# デフォルトルート
ip route del default
ip route add default via 192.168.100.200

# フォアグラウンドでnamedを実行
exec /usr/sbin/named -g -c /etc/bind/named.conf -u bind
