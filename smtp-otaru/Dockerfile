FROM debian:stable

# 設定ファイルをコピー
COPY main.cf /etc/postfix/

RUN apt-get update && apt-get install -y postfix

# ポートを公開
EXPOSE 25 587

# エントリポイントスクリプト
COPY entrypoint.sh /
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]