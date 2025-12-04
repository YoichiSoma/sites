# AutoHotkey 設定

## なぜAutoHotkeyを利用するのか？
- 業務でWindowsマシンを利用することが多い
- 払い出しマシンが日本語キーボードである
- そのため、HHKB（US）を利用するためにはWindowsの設定変更をしなければならない
- ただしマシンは日本語キーボードであるため、MTG等でPCだけ持ち出したときに配置が変わってしまうので面倒である
- そのため、AutoHotkeyにて利用状況にて日本語、英語の配列を使い分けるようにしたい

## AutoHotkeyとは？
- プログラムでキーボード制御を行うツールである
- レジストリを書き換えるのではないので起動しなければキーボードはそのままの配置で利用できる

## 使い方
1. [AutoHotkey](https://www.autohotkey.com/)サイトからプログラムをダウンロードする
   - バージョンはV2を選択
2. インストールは普通に行う
3. スクリプトの準備
   - 別途用意したスクリプトファイルを任意のフォルダに配置する
   - ドキュメント配下にフォルダを作成し、その中に配置するといいかも
4. スクリプトを実行する

## スクリプトについて
- defo.ahk
  - 日本語キー配列でvimカーソル移動(ctrl + hjkl)をするためのスクリプト
- HHK.ahk
  - HHKのUS配列で利用するためのスクリプト
  - vimカーソル移動

---
# 追加設定
## AltキーにIME変換機能を割り当てる
日本語キーボード場合はスペースキーの左に無変換キー、右に変換キーの割当がある   
英語キーボードの場合IME切り替えのキーがない  
そのため標準のUSキーボードにはスペースキーの両脇にALTキーがあるのでこれをIME切り替えに利用する

## CapsキーをCtrlキーに変更する
**これはAUとHotKeyで実現できるので割当しない**   
HHKBの場合は左小指辺りにctrlキーが配置されるのでvim操作がやりやすいが、日本語配列の場合は同じ位置がcapsキーとなっている   
そのためカーソル移動がやりづらくなるので入れ替えを行う   
端末によってはBIOS設定等でハードウェア的に入れ替えることも可能であるが、払い出しマシンのBIOS設定はたいていいじれないので   

## 変更方法
- [Microsoft PowerToys](https://learn.microsoft.com/en-us/windows/powertoys/)をインストール
- PowerToysの管理画面を開き、Keyboard Managerを選択
- 「Keyboard Manager」画面で以下の設定を行う
  - Keyboard Managerを有効化する
    - オン
- キーの再マップ項目を開き、以下の設定をいれる
  -  ![PowerToys KeyboardManagerEditor_NQqcwi66JP](https://github.com/user-attachments/assets/47a937b5-c811-47cf-9f7c-4a1c7e1303f4)
  -  Alt(Left)
      - 送信 :キーショットカットの送信
      - IME Non-Convert
  - Alt(Right)
     - 送信 :キーショットカットの送信
     - IME Non-Convert

---
# Winキーに変換、無変換を割り当て (2025/12/04 追記)
- HHKBキーマップ変更ツールでWinキー（commadキー）に変換、無変換を割り当てるとMACと併用した場合支障がでる
- そのためAutoHotkey側で割当を変更する
- 設定はHHKB.ahkに反映済み

# Google日本語入力の利用 (2025/12/04 追記)
- IMEの変換が賢くないのでGoogle日本語入力が利用できる場合は利用する
   - 割当は以下の通りにしておくといいかもです
   - <img width="671" height="613" alt="Google日本語入力keymap_img" src="https://github.com/user-attachments/assets/798d473f-e517-4edd-a6d0-ee37cff1b9a0" />
   - 念の為キーマップファイルのエクスポートデータもリポジトリに上げておく
