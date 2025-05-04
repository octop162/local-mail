#!/bin/bash
set -e

# デフォルトルート
ip route del default
ip route add default via 192.168.100.200

# フォアグラウンドでnginxを実行
exec nginx -g "daemon off;"
