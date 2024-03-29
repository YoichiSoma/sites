# サーバレスでWEBサイトを構築してみる

- 通常はec2インスタンスを作成し、httpdアプリをインストールしてWEBサイトを構築することが多い。
- 簡単な静的コンテンツであればサーバレスで配信できるので簡単な静的配信サイトを構築してみる。

## まずはS3のみでやってみる

- [sites3.lab.bsaly.net]というFQDNでアクセスできるサイトを作ってみる

### 設定
- [sites3.lab.bsaly.net]バケットを作成
- 作成したバケットにindex.htmlファイルを格納
- ブロックパブリックアクセス (バケット設定)を全て無効(全チェックを外す)にする
- バケットポリシーの作成
  ```
  {
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "PublicReadGetObject",
            "Effect": "Allow",
            "Principal": "*",
            "Action": "s3:GetObject",
            "Resource": "arn:aws:s3:::<S3バケット名>/*"
        }
    ]
  }
  ```
- プロパティ > 静的ウェブサイトホスティング の[編集]ボタンをクリックし、「静的ウェブサイトホスティングを編集」画面にて以下のように設定する
  - 静的ウェブサイトホスティング : 有効にする
  - インデックスドキュメント : index.html
  - その他はそのまま
- route53にて設定
  - レコードの作成画面で以下通り設定し、[レコード作成]ボタンをクリックする
    - レコード名 : S３バケット名 （例 sites3.hoge.comとした場合はsites3)
    - レコードタイプ: A
    - エイリアス : 有効 (スイッチが色付きになる)
    - トラフィックのルーティング先
      - エンドポイントを選択 : S3ウェブサイトエンドポイントへのエイリアス
      - リージョンを選択 : アジアパシフィック(東京)
      - S3エンドポイントを入力 : <作成したバケットを選択>
### 確認
- "http://FQDN"にブラウザからアクセスし、index.htmlの内容が表示されることを確認
  - "https"ではないので注意！（S3バケットのwebアクセスはhttpのみ対応である！）

---
## cloudfrontを利用したhttpsアクセス可能な静的WEBサイト構築

前項ではhttpであればアクセス可能であったが、httpsに対応する場合はcloudfrontを利用する必要がある

そのためバケットはそのままでhttpsでアクセスでききるようにcloudfrontの設定を行う

### 事前準備
- CloudFrontでhttpsを利用するためにACMでサーバ証明書を発行する
  - サーバ証明書は米国東部 (バージニア北部) リージョン (us-east-1) に設定する必要があるため、リージョンを変更して作成する
  - ※ DNS検証でRoute53に設定した場合、証明書削除時にレコードは削除されないので注意

### CloudFrontの設定
- CloudFrontのページを開き、[CloudFrontディストリビューションを作成]をクリック
- 作成画面で以下の通り設定し、[ディストリビューションを作成]をクリックする
  - ※ 記載のない項目はデフォルトのままで
  - オリジンドメイン : S3バケットに設定されているドメインを指定
    - バケットを指定するとS3エンドポイントの使用を推奨されるので[Webサイトのエンドポイントを使用]ボタンをクリックする
    - クリックするとエンドポイント名が自動で入力される
  - プロトコル
    - HTTPSのみ
    - HTTPポート: 80
  - セキュリティ保護を有効にしないでください : 選択
  - 代替ドメイン名(CNAME) : ACMで指定したFQDNを入力
  - カスタム SSL 証明書 - オプション
    - 作成したACMのサーバ証明書を指定
### Route63の設定
- CF向けのレコードを作成する
- 「レコード」の作成画面で以下の項目を設定し、[レコードを作成]ボタンをクリック
   - レコード名 : ACM作成時に指定したサブドメインを入力
   - エイリアス : 有効化
   - トラフィックのルーティング先
     - エンドポイントを選択 : CloudFront ディストリビューションへのエイリアス
     - リージョンを選択 : ここは自動で”米国東部(バージニア北部)”が選択される （変更不可）
     - ディストリビューションの選択 : CFで作成したディストリビューション名を選択

## 確認
- 作成したFQDNにHTTPとHTTPSでアクセスを行い、S3バケット内にあるindex.htmlの内容が表示されれば問題がない
