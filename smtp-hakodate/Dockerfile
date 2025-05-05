FROM debian:stable

# 設定ファイルをコピー（先にコピーしておかないとインストールに失敗した）
COPY main.cf /etc/postfix/
COPY master.cf /etc/postfix/
COPY 10-postfix.conf /etc/rsyslog.d

RUN apt-get update \
&& apt-get install -y \
postfix \
libsasl2-modules \
sasl2-bin \
openssl \
telnet \
iproute2 \
traceroute \
iputils-ping \
net-tools \
dnsutils

# SSL証明書の生成
RUN mkdir -p /etc/ssl/private && \
    openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout /etc/ssl/private/postfix.key \
    -out /etc/ssl/certs/postfix.pem \
    -subj "/C=JP/ST=Hokkaido/L=Hakodate/O=HakodateMail/CN=smtp.hakodate.test"

# シンプル認証
RUN mkdir -p /etc/postfix/sasl && \
echo 'taruo:password' > /etc/postfix/sasl/passwd \
chmod 600 /etc/postfix/sasl/passwd && \
postmap hash:/etc/postfix/sasl/passwd

# IMAP
COPY transport /etc/postfix
RUN postmap /etc/postfix/transport

# VirtualMailbox
COPY virtual_mailbox /etc/postfix
RUN postmap /etc/postfix/virtual_mailbox

# エントリポイントスクリプト
COPY entrypoint.sh /
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]