# eXtick

[![Build Status](https://travis-ci.org/328--/eXtick.svg?branch=master)](https://travis-ci.org/328--/eXtick)

- ユーザ間でのチケット交換・販売サービスを提供するwebアプリケーション
- [Elevator-pitch](https://github.com/328--/eXtick/wiki/elevator-pitch)

## demo

- [demo-page](https://extick.herokuapp.com/)
- Herokuにてデモを公開


# 使い方

```
$ git clone https://github.com/328--/eXtick
$ echo "export TWITTER_CS_KEY=xxxxxxxxxxxxxxxxxxxx" >> ~/.zshrc
$ echo "export TWITTER_CS_SEC=xxxxxxxxxxxxxxxxxxxx" >> ~/.zshrc
$ source ~/.zshrc
$ cd eXtick
$ bundle install
$ rake db:create
$ rake db:migrate
$ rails server
```


# 注意

- TwitterDevelopperに登録し，以下を環境変数に設定する必要があります
- `TWITTER_CS_KEY`  Consumer Key
- `TWITTER_CS_SEC` Consumer Secret


# ライセンス

- MITライセンスにて提供しています。詳しくは LICENSE.txt ファイルをご確認ください。

