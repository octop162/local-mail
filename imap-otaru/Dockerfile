FROM debian:stable

RUN apt update && apt install -y dovecot-imapd

RUN echo 'protocols = imap' >> /etc/dovecot/dovecot.conf 
RUN echo 'ssl = no' >> /etc/dovecot/conf.d/10-ssl.conf

CMD ["/dovecot/sbin/dovecot", "-F"]