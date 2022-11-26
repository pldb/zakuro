# Zakuro - 石榴
zakuro は日本の暦を扱う暦算ライブラリです。

# 前掲
石榴（ざくろ）は古来より珍重され、シルクロードを通じて洋の東西に広く伝播した落葉小高木です。

すなわち、中華世界においては `太陰太陽暦` 、地中海世界においては `太陽暦` のもとで育ち、これら東西の暦はシルクロードの東端たる日本に深い影響を与えております。

日本の暦は中国に端を発しますが、江戸時代以降は西洋の文物からも深く学び、日本人は暦算を自らのものとしました。

石榴はただ伝来しただけでなく、日本の地に根づいております。これを日本の暦になぞらえ、和名の「ざくろ」を冠することと致します。

## 導入

### Ruby

次の範囲で動作確認しております。

`2.6.x - 3.0.x`

### Gem

[rubygem](https://rubygems.org/gems/zakuro) に登録しております。

```ruby
gem 'zakuro'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install zakuro

# 進捗

開発途中です。

1日検索/期間検索に対応しております。

下記表で暦算ありの暦は使用可能です。

|開始日|暦   |計算方法|暦算|没日|滅日|
|:----|:----|:----|:---|:---|:---|
|445/01/24|元嘉暦| |✓|-|-|
|698/02/16|儀鳳暦|A|✓|-|-|
| | |B|-|-|-|
| | |C|-|-|-|
|764/02/07|大衍暦|A|✓|✓|✓|
| | |B|-|-|-|
| | |C|-|-|-|
|862/02/03|宣明暦| |✓|✓|✓|
|1685/02/04|貞享暦| |-|-|-|
|1755/02/11|宝暦暦| |-|-|-|
|1798/02/16|寛政暦| |-|-|-|
|1844/02/18|天保暦| |-|-|-|
|1872/12/09|グレゴリオ暦| |-|-|-|

表中A-Cは月の運動の計算手順ごとに分類されます。

現在は「長慶宣明暦算法」の計算手順Aのみ対応しております。

# 使用方法

[使用方法](./doc/usage.md) を参照してください。

# 条件

[条件](./doc/condition.md) を参照してください。

# 期待値

[期待値](./doc/expection.md) を参照してください。

# 元号

[一覧](./doc/gengou.md) を参照してください。

# 運用値

一部の月では計算値から運用値への書き換えが発生します。

経緯は [実運用](./doc/operation.md) を参照してください。

# 暦算

暦算の解説は次の通りです。

## 暦別

|暦   |有無|
|:----|:----|
|[元嘉暦](./doc/version/genka.md)|✓|
|[儀鳳暦](./doc/version/gihou.md)|✓|
|[大衍暦](./doc/version/daien.md)|✓|
|[宣明暦](./doc/version/senmyou.md)|✓|
|貞享暦|-|
|宝暦暦|-|
|寛政暦|-|
|天保暦|-|
|グレゴリオ暦|-|

## 項目別

|項目   |有無|
|:----|:----|
|[没日](./doc/dropped_date.md)|✓|
|滅日|-|

# 例外

条件不正などで例外が発生します。
詳細は [例外処理](./doc/error.md) を参照してください。

## コントリビュート（Contributing）

バグ報告/修正はこちらまで。

https://github.com/pldb/zakuro


## ライセンス

gem は [MIT License](https://opensource.org/licenses/MIT) の条件の下、オープンソースとして利用可能です。
