FROM debian:stable-slim

RUN apt update && \
    apt install -y \
        iproute2 \
        traceroute \
        iputils-ping \
        net-tools \
        dnsutils \
        telnet \
        curl \
        vim \
        s-nail \
        sendmail

COPY .mailrc /root