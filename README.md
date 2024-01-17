# Foodmatchapp

## アプリ概要

ゼルダの伝説 ティアーズオブザキングダム<sup>[^1]</sup>というゲームに出てくる料理作りシステムを簡易的にシミュレーションすることができます。

### URL
[https://foodmatchapp-9f8c45cddd1d.herokuapp.com](https://foodmatchapp-9f8c45cddd1d.herokuapp.com)

## 開発背景

ゲームやシミュレーション好きな方に***長く楽しく遊んでもらいたい***という思いから。
題材に「ゼルダの伝説」を選んだ理由としては、有名であるかつ多数の食材による組み合わせで料理ができること、以上の２点からシミュレーションにうってつけだと考えたからです。

## 主な機能

- ユーザーログイン/ログアウト(CRUD)機能（`devise`利用）
- ゲストログイン機能
- 管理者権限ユーザー機能
- 料理シミュレーション機能
  - 食材の組み合わせによる料理表示
  - 食材や料理の詳細情報は画像クリックでモーダル表示
  - 選択した食材は詳細ページへのリンク
- 料理に関する投稿(CRUD)機能
  - 管理者権限を持つユーザーのみ作成することが可能
- 料理詳細ページには料理レシピを一つ掲載
- 投稿へのいいね機能
- いいね通知機能
- 投稿種類の切り替えタブ機能
  - 最新の投稿順(降順)
  - いいね数が多い順
  - 自分がいいねした投稿(投稿日降順)

## データベース構造

![Foodmatchapp_erd](https://github.com/Takeru-doroid/foodmatchapp/assets/108878703/c81bef6b-6ff5-4b09-951a-a927bb64ce9c)
> このER図は、GitMind<sup>[^2]</sup>を使用して作成しています。

## 遊び方

1. 好きな食材を**選択**して、「**料理する**」ボタンを押す。
2. 組み合わせ応じた料理が表示される。
> [!TIP]
> 食材が持つ特殊効果が料理に反映されることもあります。
3. 作成した料理についての記事を「**投稿**」ボタンから作成できる。
4. title・bodyを書くと、投稿の作成ができる。
5. 投稿には**いいね**したり、自分の投稿は後から編集することができる。

料理シミュレーションの操作デモ動画

![foodmatchapp_sample_video](https://github.com/Takeru-doroid/foodmatchapp/assets/108878703/a8e755d9-2b5b-4731-a595-4f43e00e8ade)

## ツールバージョン

+ MacBook Air（macOS Monterey 12.4）
+ Ruby 3.1.4
+ Ruby on Rails 7.0.7
+ Docker Desktop 4.24.0
+ Docker Engine 24.0.6
+ Heroku CLI 8.7.1
  > クラウドストレージには、**AWS S3**を使用
+ mysql 8.0.32

[^1]: 2023年5月12日に任天堂より発売されたオープンアドベンチャーゲーム。 [公式サイト](https://www.nintendo.co.jp/zelda/totk/index.html)
[^2]: AI（ChatGPT）搭載のマインドマップ作成ソフト。 [公式URL](https://gitmind.com/jp/)
