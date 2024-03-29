# Security group と Network ACL について
ec2インスタンスや一部マネジメントサービスへのネットワークトラフィック制御については以下の2つが利用できる
- Security Grup(以下SG)
- Network ACL (以下NACL)

上記について説明する

## SGとNACLの比較
- [参考URL](https://docs.aws.amazon.com/ja_jp/vpc/latest/userguide/infrastructure-security.html)

基本的な違いは以下である
| 項目 | SG | NACL |
|---|---|---|
|動作レベル|インスタンスレベル|サブネットレベル|
|適用|インスタンスと関連付けされている場合にのみインスタンスに適用|関連付けられているサブネットにデプロイされているすべてのインスタンスに適用|
|ルール|ホワイトリスト(許可)|ホワイト(許可)、ブラック(拒否)|
|評価|すべてのルールを評価|低い番号順にルールを評価|
|ステート|ステートフル|ステートレス|

それぞれ適用できる範囲としては、SGであればサブネット内のリソース、NACLはサブネット間通信の制御に利用される   
(下図参照)

<img src="https://github.com/YoichiSoma/sites/assets/125415634/d41c71d8-e923-47d5-93c1-3f2a9de38fc7" width="500">

----
## SGの使い方([参考](https://docs.aws.amazon.com/ja_jp/vpc/latest/userguide/security-group-rules.html#security-group-referencing))
SGの基本は以下である

| インバウンド or アウトバウンド | IPバージョン(v4 or v6) | タイプ | プロトコル | ポート範囲 | ソース |
|---|---|---|---|---|---|

この中でポート範囲において指定方法がいくつかある
- 単一のIPアドレス/32で指定
   - 例として ***203.0.113.1/32*** 
   - 単一IPを指定する場合"/32"をつけるのを忘れずに！
- CIDRブロック表記の範囲
   - /24とか
- プレフィクスリストID
   - マネージドプレフィックスリストのIDで指定する
   - ”マネージドプレフィックスリスト”とはCIDRブロックのセットであり、例えばS3のCIDRブロックであったり、自前のIPアドレスをまとめたリストでもある
- セキュリティグループID
   - 例えばECSのサービスをELBで指定する場合、サービスのIPアドレスはデプロイするごとに変わるためセキュリティグループIDを指定する
   - オートスケールの場合EC2の付与IPは可変なのでこの場合においてもオートスケールで起動するEC2のセキュリティーグループIDを指定することにより送信元を制限することが可能である


## NACLについて([参考](https://docs.aws.amazon.com/ja_jp/vpc/latest/userguide/vpc-network-acls.html))
- NACLについてはよほど厳しいセキュリティ要件がない限り未設定でも問題ない
- ただし、VPCをまたいだ通信がある場合は明示的に設定することもある




