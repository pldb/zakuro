# Zakuro - 石榴
zakuro は日本の暦を扱う暦算ライブラリです。

# 前掲
石榴（ざくろ）は古来より珍重され、シルクロードを通じて洋の東西に広く伝播した落葉小高木です。

すなわち、中華世界においては `太陰太陽暦` 、地中海世界においては `太陽暦` のもとで育ち、これら東西の暦はシルクロードの東端たる日本に深い影響を与えております。

日本の暦は中国に端を発しますが、江戸時代以降は西洋の文物からも深く学び、日本人は暦算を自らのものとしました。

石榴はただ伝来しただけでなく、日本の地に根づいております。これを日本の暦になぞらえ、和名の「ざくろ」を冠することと致します。

## 導入

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

現時点では宣明暦の暦日の1日検索のみ対応しております。

# 使用方法

```
require 'zakuro'

# 西暦日 -> 和暦日への変換方法を示す

# ざくろ商人（Zakuro::Merchant）に西暦日を渡し、和暦日を受け取る
western_date = Date.new(862, 2, 3)

# 初期化時の設定
merchant = Zakuro::Merchant.new(condition: { date: western_date })
puts merchant.commit.to_json
# => {"year":{"first_gengou":{"name":"貞観","number":4},"second_gengou":{"name":"","number":-1},"zodiac_name":"壬午","total_days":354},"month":{"number":1,"leaped":false,"days_name":"大","first_day":{"number":1,"zodiac_name":"庚午","remainder":"6-1282","western_date":"0862-02-03"},"odd_solar_terms":[{"index":5,"remainder":"34-5368"}],"even_solar_terms":[{"index":4,"remainder":"19-3532"}]},"day":{"number":1,"zodiac_name":"庚午","remainder":"6-1282","western_date":"0862-02-03"}}

western_date = Date.new(1685, 2, 3)

# 再設定
# merchant = Zakuro::Merchant.new
merchant.offer(condition: { date: western_date })
puts merchant.commit.to_json
# => {"year":{"first_gengou":{"name":"貞享","number":1},"second_gengou":{"name":"","number":-1},"zodiac_name":"甲子","total_days":354},"month":{"number":12,"leaped":false,"days_name":"大","first_day":{"number":1,"zodiac_name":"壬辰","remainder":"28-4182","western_date":"1685-01-05"},"odd_solar_terms":[{"index":1,"remainder":"30-890"}],"even_solar_terms":[{"index":2,"remainder":"45-2726"}]},"day":{"number":30,"zodiac_name":"辛酉","remainder":"57-4182","western_date":"1685-02-03"}}
```

# 条件

条件（condition）のバリエーションを示します。

| 項目名         | キー名  | hash内キー名 | データ型 | 備考               |
|----------------|---------|--------------|----------|--------------------|
| 基準日         | date    |              | Date     | 西暦日             |
|                |         |              | String   | 和暦日             |
| 範囲（開始日） | range   | start        | Date     |                    |
| 範囲（終了日） |         | last         | Date     |                    |
| 列             | columns |              | Array    | 取得したい列の列名 |
| オプション     | options |              | Array    | 取得オプション     |

現時点では `date` の西暦日のみ対応中です。

## オプション

| 項目名 | キー名    | データ型 | データ | 備考                   |
|--------|-----------|----------|--------|------------------------|
| 単位   | unit      | String   | year   | 年単位                 |
|        |           |          | month  | 月単位                 |
|        |           |          | day    | 日単位（デフォルト）   |
| 没日   | lost_days | TRUE     |        | 没日あり               |
|        |           | FALSE    |        | 没日なし（デフォルト） |
| 四季   | seasons   | TRUE     |        | 四季あり               |
|        |           | FALSE    |        | 四季なし（デフォルト） |

# 期待値
暦算値は『日本暦日原典』、元号の切り替えは『日本史年表　第5版』を範とします。

## 種類

現状は一日検索のみ対応しております。

| 項目名   | データ型               |
|----------|------------------------|
| 一日検索 | Zakuro::Result::Single |
| 範囲検索 | Zakuro::Result::Range  |

### Zakuro::Result::Single

| 項目名   | キー名    | - | - | データ型                  | 参考値 | 備考 |
|----------|-----------|---|---|---------------------------|--------|------|
| 日付情報 | data      |   |   | Zakuro::Result::SingleDay | -      | -    |
| 運用情報 | operation |   |   | Zakuro::Result::Operation | -      | -    |

### Zakuro::Result::SingleDay

| 項目名                   | キー名 | -                | -            | データ型                  | 参考値     | 備考                       |
|--------------------------|--------|------------------|--------------|---------------------------|------------|----------------------------|
| 年情報                   | year   |                  |              | Zakuro::Result::Year      |            |                            |
| 年号                     |        | first_gengou     |              | Zakuro::Result::Gengou    |            |                            |
| 元号                     |        |                  | name         | String                    | 貞観       |                            |
| 元号年                   |        |                  | number       | Integer                   | 4          |                            |
| 年号（南北朝時代の北朝） |        | second_gengou    |              | Zakuro::Result::Gengou    |            |                            |
| 元号                     |        |                  | name         | String                    | -          | 南北朝時代の北朝のみ       |
| 元号年                   |        |                  | number       | Integer                   | -          | 南北朝時代の北朝のみ       |
| 年の干支                 |        | zodiac_name      |              | String                    | 壬午       |                            |
| 年の日数                 |        | total_days       |              | Integer                   | 354        |                            |
| 月                       | month  |                  |              | Zakuro::Result::Month     |            |                            |
| 月番号                   |        | number           |              | Integer                   | 1          | x月                        |
| 閏月判定                 |        | leaped           |              | True/False                | FALSE      | 閏月（true）/平月（false） |
| 月の大小                 |        | days_name        |              | String                    | 大         | 大（30日） / 小（29日）    |
| 月初日                   |        | first_day        | number       | Integer                   | 1          | x日（1日固定）             |
| 月初日の干支             |        |                  | zodiac_name  | String                    | 庚午       |                            |
| 月初日の大余小余         |        |                  | remainder    | String                    | 6-1282     |                            |
| 西暦日                   |        |                  | western_date | String                    | 0862-02-03 |                            |
| 節気                     |        | odd_solar_terms  |              | Zakuro::Result::SolarTerm |            |                            |
| 二十四節気番号           |        |                  | index        | Integer                   | 5          | 番号（冬至0始まり）        |
| 二十四節気の大余小余     |        |                  | remainder    | String                    | 34-5368    | 大余小余                   |
| 中気                     |        | even_solar_terms |              | Zakuro::Result::SolarTerm |            |                            |
| 二十四節気番号           |        |                  | index        | Integer                   | 4          | 番号（冬至0始まり）        |
| 二十四節気の大余小余     |        |                  | remainder    | String                    | 19-3532    | 大余小余                   |
| 日                       | day    |                  |              | Zakuro::Result::Day       |            |                            |
| 日番号                   |        | number           |              | Integer                   | 1          | x日                        |
| 日の干支                 |        | zodiac_name      |              | String                    | 庚午       | 日の干支                   |
| 日の大余小余             |        | remainder        |              | String                    | 6-1282     | 大余小余                   |
| 西暦日                   |        | western_date     |              | String                    | 0862-02-03 | 西暦日                     |

### Zakuro::Result::Operation

| 項目名       | キー名     | -           | - | データ型                          | 参考値                                                                        | 備考                 |
|--------------|------------|-------------|---|-----------------------------------|-------------------------------------------------------------------------------|----------------------|
| 運用有無     | operated   |             |   | True/False                        | TRUE                                                                          |                      |
| 原文頁数     | page       |             |   | Integer                           | 354                                                                           |                      |
| 原文注釈番号 | number     |             |   | Integer                           | 1                                                                             |                      |
| 注釈         | annotation |             |   | Array<Zakuro::Result::Annotation> |                                                                               |                      |
| 注釈内容     |            | description |   | String                            | 計算では47辛亥, 朔旦冬至にするため庚戌朔, そのユリウス暦日は12月15日になる。  |                      |
| 注釈補記     |            | note        |   | String                            | -                                                                             | 原文訂正             |
| 計算値       | original   |             |   | Zakuro::Result::SingleDay         |                                                                               | 運用値差替前の計算値 |

# 元号

[一覧](./doc/gengou.md) を参照してください。

# 暦算

[宣明暦](./lib/zakuro/version/senmyou/README.md) のみ記載しております。

## コントリビュート（Contributing）

バグ報告/修正はこちらまで。

https://github.com/pldb/zakuro


## ライセンス

gem は [MIT License](https://opensource.org/licenses/MIT) の条件の下、オープンソースとして利用可能です。
