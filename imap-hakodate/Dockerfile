FROM debian:stable

RUN apt update && \
    apt install -y \
    dovecot-core \
    dovecot-imapd \
    dovecot-pop3d \
    dovecot-lmtpd \
    openssl \
    supervisor \
    iproute2 \
    traceroute \
    iputils-ping \
    net-tools 

RUN groupadd -g 5000 vmail && \
    useradd -g vmail -u 5000 vmail -d /var/mail/vhosts -m -s /usr/sbin/nologin

RUN useradd -m ika \
 && echo "ika:password" | chpasswd \
 && mkdir -p /home/ika/Maildir \
 && chown -R ika /home/ika/Maildir

RUN mkdir -p \
    /var/mail/vhosts/hakodate.test/user \
    && chown -R vmail:vmail /var/mail/vhosts

COPY dovecot.conf /etc/dovecot/dovecot.conf
COPY 10-auth.conf /etc/dovecot/conf.d
COPY 10-mail.conf /etc/dovecot/conf.d
COPY 10-ssl.conf /etc/dovecot/conf.d
COPY 10-master.conf /etc/dovecot/conf.d
COPY 20-lmtp.conf /etc/dovecot/conf.d
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

EXPOSE 110 143 993 995

COPY entrypoint.sh /
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]