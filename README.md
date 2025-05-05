## 概要
勉強用にメール環境をつくりたかったので基本構成で作成してたい。
ネイティブのLinux上で動かしており、WSL上ではうまくいかないことを確認している。

- Ubuntu 24.04.2 LTS
- Docker 28.1.1

## 全体像
以下のような構成にしてみる。

![](docs/mail-local.drawio.svg)

最終的にはこれをしたい。

- otaru.testからメール送信する
- asahikawa.testを中継してhakodate.testで受信する
- hakodate.testからotaru.testへ返信する

メールアドレスは以下で設定した。

- taruo@otaru.test
- ika@hakodate.test

## ネットワーク情報

| 名前             | CIDR             | 用途      |
| :------------- | :--------------- | :------ |
| sapporo.test   | 192.168.100.0/24 | DNSサーバ用 |
| otaru.test     | 192.168.101.0/24 | メール送信側  |
| asahikawa.test | 192.168.102.0/24 | メール中継   |
| hakodate.test  | 192.168.103.0/24 | メール受信側  |
| R0-R1          | 172.16.101.0/24  |         |
| R0-R2          | 172.16.102.0/24  |         |
| R0-R3          | 172.16.103.0/24  |         |

## サーバー情報

| 名前           | ネットワーク                | IPアドレス                                                      | 備考                  |
|:---------------|:----------------------------|:----------------------------------------------------------------|:----------------------|
| R0             | sapporo.test                | 192.168.100.200<br>172.16.101.1<br>172.16.102.1<br>172.16.103.1 |                       |
| R1             | sapporo.test-otaru.test     | 192.168.101.200<br>172.16.101.200                               |                       |
| R2             | sapporo.test-asahikawa.test | 192.168.102.200<br>172.16.102.200                               |                       |
| R3             | sapporo.test-hakodate.test  | 192.168.103.200<br>172.16.103.200                               |                       |
| DNS(primary)   | sapporo.test                | 192.168.100.100                                                 |                       |
| WEB            | sapporo.test                | 192.168.100.102                                                 | DNS、疎通周りテスト用 |
| Client         | otaru.test                  | 192.168.101.1                                                   |                       |
| SMTP           | otaru.test                  | 192.168.101.30                                                  |                       |
| IMAP           | otaru.test                  | 192.168.101.31                                                  |                       |
| SMTP           | asahikawa.test              | 192.168.102.30                                                  |                       |
| Client         | hakodate.test               | 192.168.103.1                                                   |                       |
| SMTP           | hakodate.test               | 192.168.103.30                                                  |                       |
| IMAP           | hakodate.test               | 192.168.103.31                                                  |                       |

## ソフトウェア
有名所の構成にする。
- DNS
	- bind
- IMAP
	- dovecot
- SMAP
	- postfix
- ルーター
	- FRRouting

## 動作確認

ルーティング確認

```bash
docker compose exec client-otaru
traceroute 192.168.103.1
```

DNSとHTTPサーバの接続確認

```bash
docker compose exec client-otaru
curl www.sapporo.test
```

メール送信

```bash
docker compose exec client-otaru
echo "hello taruo" | s-nail --account taruo -s "hello me" taruo@otaru.test 
```

```bash
docker compose exec client-otaru
echo "hello ika" | s-nail --account taruo -s "hello ika" ika@hakodate.test
```

メール受信

```bash
docker compose exec client-otaru
s-nail --account taruo
```


## 現状の問題
- 25番ポートで送信している
- SMTPサーバとIMAPサーバをLMTPで接続しているが暗号化や認証を全くしていない
- SPF/DKIM/DMARC対応していない

## メモ
これをやる必要がある？多分ない。

```bash
sudo iptables -P FORWARD ACCEPT
sudo apt install iptables-persistent
sudo netfilter-persistent save
```
