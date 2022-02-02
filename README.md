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

1日検索/期間検索に対応しております。

下記表で対応済の暦は使用可能です。

|開始日|暦   |計算方法|対応|
|:----|:----|:----|:----|
|445/01/24|元嘉暦| |✓|
|698/02/16|儀鳳暦|A|✓|
| | |B|-|
| | |C|-|
|764/02/07|大衍暦|A|✓|
| | |B|-|
| | |C|-|
|862/02/03|宣明暦| |✓|
|1685/02/04|貞享暦| |-|
|1755/02/11|宝暦暦| |-|
|1798/02/16|寛政暦| |-|
|1844/02/18|天保暦| |-|
|1872/12/09|グレゴリオ暦| |-|

# 使用方法

```
require 'zakuro'

# 西暦日 -> 和暦日への変換方法を示す

# ざくろ商人（Zakuro::Merchant）に西暦日を渡し、和暦日を受け取る
western_date = Date.new(862, 2, 3)

# 初期化時の設定
merchant = Zakuro::Merchant.new(condition: { date: western_date })
puts merchant.commit.to_json
# => {"data":{"year":{"first_gengou":{"name":"貞観","number":4},"second_gengou":{"name":"","number":-1},"zodiac_name":"壬午","total_days":354},"month":{"number":1,"leaped":false,"days_name":"大","first_day":{"number":1,"zodiac_name":"庚午","remainder":"6-1282","western_date":"0862-02-03"},"odd_solar_terms":[{"index":5,"remainder":"34-5368"}],"even_solar_terms":[{"index":4,"remainder":"19-3532"}]},"day":{"number":1,"zodiac_name":"庚午","remainder":"6-1282","western_date":"0862-02-03"}},"operation":{"operated":false,"month":{"current":{"id":"","western_date":"","page":-1,"number":-1,"annotations":[]},"parent":{"id":"","western_date":"","page":-1,"number":-1,"annotations":[]}},"original":{"year":{"first_gengou":{"name":"貞観","number":4},"second_gengou":{"name":"","number":-1},"zodiac_name":"壬午","total_days":354},"month":{"number":1,"leaped":false,"days_name":"
大","first_day":{"number":1,"zodiac_name":"庚午","remainder":"6-1282","western_date":"0862-02-03"},"odd_solar_terms":[{"index":5,"remainder":"34-5368"}],"even_solar_terms":[{"index":4,"remainder":"19-3532"}]},"day":{"number":1,"zodiac_name":"庚午","remainder":"6-1282","western_date":"0862-02-03"}}}}

western_date = Date.new(1685, 2, 3)

# 再設定
# merchant = Zakuro::Merchant.new
merchant.offer(condition: { date: western_date })
puts merchant.commit.to_json
# => {"data":{"year":{"first_gengou":{"name":"貞享","number":1},"second_gengou":{"name":"","number":-1},"zodiac_name":"甲子","total_days":354},"month":{"number":12,"leaped":false,"days_name":"大","first_day":{"number":1,"zodiac_name":"壬辰","remainder":"28-4182","western_date":"1685-01-05"},"odd_solar_terms":[{"index":1,"remainder":"30-890"}],"even_solar_terms":[{"index":2,"remainder":"45-2726"}]},"day":{"number":30,"zodiac_name":"辛酉","remainder":"57-4182","western_date":"1685-02-03"}},"operation":{"operated":false,"month":{"current":{"id":"","western_date":"","page":-1,"number":-1,"annotations":[]},"parent":{"id":"","western_date":"","page":-1,"number":-1,"annotations":[]}},"original":{"year":{"first_gengou":{"name":"貞享","number":1},"second_gengou":{"name":"","number":-1},"zodiac_name":"甲子","total_days":354},"month":{"number":12,"leaped":false,"days_name":"大","first_day":{"number":1,"zodiac_name":"壬辰","remainder":"28-4182","western_date":"1685-01-05"},"odd_solar_terms":[{"index":1,"remainder":"30-890"}],"even_solar_terms":[{"index":2,"remainder":"45-2726"}]},"day":{"number":30,"zodiac_name":"辛酉","remainder":"57-4182","western_date":"1685-02-03"}}}}

# 期間検索
merchant = Zakuro::Merchant.new(condition: { range: {start: Date.new(862, 2, 3), last: Date.new(862, 2, 4)}})
puts merchant.commit.to_json
{"list":[{"data":{"year":{"first_gengou":{"name":"貞観","number":4},"second_gengou":{"name":"","number":-1},"zodiac_name":"壬午","total_days":354},"month":{"number":1,"leaped":false,"days_name":"大","first_day":{"number":1,"zodiac_name":"庚午","remainder":"6-1282","western_date":"0862-02-03"},"odd_solar_terms":[{"index":5,"remainder":"34-5368"}],"even_solar_terms":[{"index":4,"remainder":"19-3532"}]},"day":{"number":1,"zodiac_name":"庚午","remainder":"6-1282","western_date":"0862-02-03"}},"operation":{"operated":false,"month":{"current":{"id":"","western_date":"","page":-1,"number":-1,"annotations":[]},"parent":{"id":"","western_date":"","page":-1,"number":-1,"annotations":[]}},"original":{"year":{"first_gengou":{"name":"貞観","number":4},"second_gengou":{"name":"","number":-1},"zodiac_name":"壬午","total_days":354},"month":{"number":1,"leaped":false,"days_name":"大","first_day":{"number":1,"zodiac_name":"庚午","remainder":"6-1282","western_date":"0862-02-03"},"odd_solar_terms":[{"index":5,"remainder":"34-5368"}],"even_solar_terms":[{"index":4,"remainder":"19-3532"}]},"day":{"number":1,"zodiac_name":"庚午","remainder":"6-1282","western_date":"0862-02-03"}}}},{"data":{"year":{"first_gengou":{"name":"貞観","number":4},"second_gengou":{"name":"","number":-1},"zodiac_name":"壬午","total_days":354},"month":{"number":1,"leaped":false,"days_name":"大","first_day":{"number":1,"zodiac_name":"庚午","remainder":"6-1282","western_date":"0862-02-03"},"odd_solar_terms":[{"index":5,"remainder":"34-5368"}],"even_solar_terms":[{"index":4,"remainder":"19-3532"}]},"day":{"number":2,"zodiac_name":"辛未","remainder":"7-1282","western_date":"0862-02-04"}},"operation":{"operated":false,"month":{"current":{"id":"","western_date":"","page":-1,"number":-1,"annotations":[]},"parent":{"id":"","western_date":"","page":-1,"number":-1,"annotations":[]}},"original":{"year":{"first_gengou":{"name":"貞観","number":4},"second_gengou":{"name":"","number":-1},"zodiac_name":"壬午","total_days":354},"month":{"number":1,"leaped":false,"days_name":"大","first_day":{"number":1,"zodiac_name":"庚午","remainder":"6-1282","western_date":"0862-02-03"},"odd_solar_terms":[{"index":5,"remainder":"34-5368"}],"even_solar_terms":[{"index":4,"remainder":"19-3532"}]},"day":{"number":2,"zodiac_name":"辛未","remainder":"7-1282","western_date":"0862-02-04"}}}}]}
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

| 項目名   | キー名    | - | - | データ型                          | 参考値 | 備考                                　 |
|----------|-----------|---|---|-----------------------------------|--------|---------------------------------------|
| 日付情報 | data      |   |   | Zakuro::Result::Data::SingleDay   | -      | 運用値（計算値は運用情報内を参照のこと）|
| 運用情報 | operation |   |   | Zakuro::Result::Operation::Bundle | -      | -                                     |

### Zakuro::Result::Range

| 項目名   | キー名    | - | - | データ型                               | 参考値 | 備考                                　 |
|----------|-----------|---|---|---------------------------------------|--------|---------------------------------------|
| 日リスト | list      |   |   | Array\<Zakuro::Result::Data::Single\>  | -      | 範囲内の日付情報すべて                  |

### Zakuro::Result::SingleDay

| 項目名                   | キー名 | -                | -            | データ型                        | 参考値     | 備考                       |
|--------------------------|--------|------------------|--------------|---------------------------------|------------|----------------------------|
| 年情報                   | year   |                  |              | Zakuro::Result::Data::Year      |            |                            |
| 年号                     |        | first_gengou     |              | Zakuro::Result::Data::Gengou    |            |                            |
| 元号                     |        |                  | name         | String                          | 承平       |                            |
| 元号年                   |        |                  | number       | Integer                         | 7          |                            |
| 年号（南北朝時代の北朝） |        | second_gengou    |              | Zakuro::Result::Data::Gengou    |            |                            |
| 元号                     |        |                  | name         | String                          | -          | 南北朝時代の北朝のみ       |
| 元号年                   |        |                  | number       | Integer                         | -          | 南北朝時代の北朝のみ       |
| 年の干支                 |        | zodiac_name      |              | String                          | 丁酉       |                            |
| 年の日数                 |        | total_days       |              | Integer                         | 354        |                            |
| 月                       | month  |                  |              | Zakuro::Result::Data::Month     |            |                            |
| 月番号                   |        | number           |              | Integer                         | 1          | x月                        |
| 閏月判定                 |        | leaped           |              | True/False                      | false      | 閏月（true）/平月（false） |
| 月の大小                 |        | days_name        |              | String                          | 大         | 大（30日） / 小（29日）    |
| 月初日                   |        | first_day        | number       | Integer                         | 1          | x日（1日固定）             |
| 月初日の干支             |        |                  | zodiac_name  | String                          | 甲寅       |                            |
| 月初日の大余小余         |        |                  | remainder    | String                          | 50-2479     |                            |
| 西暦日                   |        |                  | western_date | String                          | 0937-02-13 |                            |
| 節気                     |        | odd_solar_terms  |              | Zakuro::Result::Data::SolarTerm |            |                            |
| 二十四節気番号           |        |                  | index        | Integer                         | 5          | 番号（冬至0始まり）        |
| 二十四節気の大余小余     |        |                  | remainder    | String                          | 7-8293     | 大余小余                   |
| 中気                     |        | even_solar_terms |              | Zakuro::Result::Data::SolarTerm |            |                            |
| 二十四節気番号           |        |                  | index        | Integer                         | 4          | 番号（冬至0始まり）        |
| 二十四節気の大余小余     |        |                  | remainder    | String                          | 52-6457    | 大余小余                   |
| 日                       | day    |                  |              | Zakuro::Result::Data::Day       |            |                            |
| 日番号                   |        | number           |              | Integer                         | 2          | x日                        |
| 日の干支                 |        | zodiac_name      |              | String                          | 乙卯       | 日の干支                   |
| 日の大余小余             |        | remainder        |              | String                          | 51-2479    | 大余小余                   |
| 西暦日                   |        | western_date     |              | String                          | 0937-02-14 | 西暦日                     |

### Zakuro::Result::Operation

| 項目名       | キー名   | -          | -           | データ型                                   | 参考値   | 備考                 |
|--------------|----------|------------|-------------|--------------------------------------------|---------|----------------------|
| 運用有無     | operated | 　         | 　          | True/False                                 | true     | 　                   |
| 月別履歴情報 | month    | 　         | 　          | Zakuro::Result::Operation::Month::Bundle   | 　       | 　                   |
| 計算値       | original | 　         | 　          | Zakuro::Result::Data::SingleDay            | 　       | 運用値差替前の計算値 |

### Zakuro::Result::Operation::Month::Bundle

| 項目名                   | キー名   | -          | -        | データ型                                   | 参考値        | 備考                                         |
|--------------------------|----------|------------|----------|--------------------------------------------|--------------|---------------------------------------------|
| 月別履歴情報（当月）     | current  | 　         | 　          | Zakuro::Result::Operation::Month::History |              |該当月の履歴情報                              |
| 月別履歴情報（親）       | parent   | 　         | 　          | Zakuro::Result::Operation::Month::History | 　            |前後の月により副次的に影響を受けた時の履歴情報|


### Zakuro::Result::Operation::Month::History

| 項目名            | キー名   | -              | -           | データ型                                          | 参考値                                                                                                              | 備考                 |
|-------------------|----------|--------------|-------------|----------------------------------------------------|--------------------------------------------------------------------------------------------------------------------|----------------------|
| ID                |          | id           | 　            | String                                          | 178-1-1                                                                                                              | zakuro内の一意なID  |
| 月初日の西暦日     |          | western_date | 　          | String                                            | 0937-02-13                                                                                                          | 計算値               |
| 原文頁数          |          | page         | 　          | Integer                                           | 178                                                                                                                 | 　                   |
| 原文注釈番号      |          | number       | 　          | Integer                                            | 1                                                                                                                   | 　                   |
| 注釈              |          | annotations | 　          | Array\<Zakuro::Result::Operation::MonthAnnotation\> | 　                                                                                                                  | 　                   |
| 注釈内容          | 　       |              | description | String                                             | 計算は51乙卯であるが, 日本紀略に甲寅朔とある。<br>正月甲寅朔のユリウス暦日は2月13日となる。（元旦日食 をさけるための変更か） | 　                   |
| 注釈補記          | 　       |              | note        | String                                             | -                                                                                                                   | 原文訂正             |


# 元号

[一覧](./doc/gengou.md) を参照してください。

# 運用値

一部の月では計算値から運用値への書き換えが発生します。
経緯は [実運用](./doc/operation.md) を参照してください。

# 暦算

[宣明暦](./lib/zakuro/version/senmyou/README.md) のみ記載しております。

## コントリビュート（Contributing）

バグ報告/修正はこちらまで。

https://github.com/pldb/zakuro


## ライセンス

gem は [MIT License](https://opensource.org/licenses/MIT) の条件の下、オープンソースとして利用可能です。
