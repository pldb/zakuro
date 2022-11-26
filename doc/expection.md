# 期待値

次の期待値を参照します。

|対象|文献|
|:----|:----|
|暦算値|『日本暦日原典〔第四版〕』|
|元号|『日本史年表　第5版』|
|没日・滅日|『日本暦日便覧』|

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
| 運用情報 | operation |   |   | Zakuro::Result::Operation         | -      | -                                     |

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
| オプション             | options |                  | | Hash<String, Zakuro::Result::Data::Option::AbstractOption>|  | オプション値              |

### Zakuro::Result::Operation

| 項目名       | キー名   | -          | -           | データ型                                   | 参考値   | 備考                 |
|--------------|----------|------------|-------------|--------------------------------------------|---------|----------------------|
| 運用有無     | operated | 　         | 　          | True/False                                 | true     | 　                   |
| 月別履歴情報  | month    | 　         | 　          | Zakuro::Result::Operation::Month            | 　       | 　                   |
| 計算値       | original | 　         | 　          | Zakuro::Result::Data::SingleDay            | 　       | 運用値差替前の計算値 |

### Zakuro::Result::Operation::Month

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

### Zakuro::Result::Data::Option::AbstractOption

#### Zakuro::Result::Data::Option::DroppedDate::Option

キー: dropped_date

| 項目名               | キー名      | -          | -         | データ型                                               | 参考値   | 備考               |
| -------------------- | ----------- | ---------- | --------- | ------------------------------------------------------ | -------- | ------------------ |
| オプション値有無     | matched     |            |           | True/False                                             | true     |  |
| 演算値               | calculation |            |           | Zakuro::Result::Data::Option::DroppedDate::Calculation |          |              |
| 没余                 |             | remainder  |           | String                                                 | 59-34155 |                    |
| 二十四節気           |             | solar_term |           | Zakuro::Result::Data::Option::DroppedDate::SolarTerm   |          |                    |
| 二十四節気番号       |             |            | index     | Integer                                                | 6        |                    |
| 二十四節気の大余小余 |             |            | remainder | String                                                 | 49-7203  |                    |

#### Zakuro::Result::Data::Option::VanishedDate::Option

キー: vanished_date

| 項目名               | キー名      | -          | -         | データ型                                               | 参考値   | 備考               |
| -------------------- | ----------- | ---------- | --------- | ------------------------------------------------------ | -------- | ------------------ |
| オプション値有無     | matched     |            |           | True/False                                             | true     |  |
| 演算値               | calculation |            |           | Zakuro::Result::Data::Option::VanishedDate::Calculation |          |              |
| 滅余                 |             | remainder  |           | String                                                 | 33-2666 |                    |
| 経朔                   |           | average_remainder |      | String                                             | 5-3769  |                    |
