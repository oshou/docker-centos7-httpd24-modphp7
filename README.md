# docker-centos7-httpd24

# 設定内容
- ロケール設定
- タイムゾーン
- インストール
  - 運用ツール
  - Apache httpd & mod_ssl
  - PHP7関連
- yumキャッシュクリア
- 運用ユーザの追加(www-data)
  - vagrantユーザからアクセス可能なようuid1000,gid1000に設定
- Apache httpd設定(mod_php連携)
- http, httpsポートの開放

# 起動方法
- $ docker pull oshou/docker-centos7-httpd24-modphp7:latest
- $ docker run -d -p 80:80 -p 443:443 oshou/docker-centos7-httpd24-modphp7:latest
