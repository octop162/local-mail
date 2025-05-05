FROM debian:stable-slim

RUN apt update &&\
    apt install -y \
        iproute2 \
        bind9 \
        bind9utils

COPY named.conf.local /etc/bind
COPY db.sapporo.test /etc/bind
COPY db.otaru.test /etc/bind
COPY db.asahikawa.test /etc/bind
COPY db.hakodate.test /etc/bind
COPY db.192.168.101 /etc/bind
COPY db.192.168.102 /etc/bind
COPY db.192.168.103 /etc/bind

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT [ "/entrypoint.sh" ]
