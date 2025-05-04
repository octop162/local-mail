FROM debian:stable-slim

RUN apt update &&\
    apt install -y \
        iproute2 \
        bind9 \
        bind9utils

COPY named.conf.local /etc/bind
COPY db.sapporo.test /etc/bind

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT [ "/entrypoint.sh" ]
