# Zakuro - 石榴
zakuro は日本の暦を扱う暦算ライブラリです。

# 前掲
石榴（ざくろ）は古来より珍重され、シルクロードを通じて洋の東西に広く伝播した落葉小高木です。

すなわち、中華世界においては太陰太陽暦、地中海世界においては太陽暦のもとで育ち、これら東西の暦はシルクロードの東端たる日本に深い影響を与えております。

日本の暦は中国に端を発しますが、江戸時代以降は西洋の文物からも深く学び、日本人は暦算を自らのものとしました。

石榴はただ伝来しただけでなく、日本の地に根づいております。これを日本の暦になぞらえ、和名の「ざくろ」を冠することと致します。

## 導入

Add this line to your application's Gemfile:

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

# 期待値
『日本暦日原典』を範とします。

|項目|-|-|参考値|備考|
|:----|:----|:----|:----|:----|
|year|first_gengou|name|貞観|年号|
| | |number|4|年号年|
| |second_gengou|name| |年号（南北朝時代の北朝）|
| | |number|-|年号年|
| |zodiac_name| |壬午|年の干支|
| |total_days| |354|年の日数|
|month|number| |1|x月|
| |leaped| |false|閏月（true）/平月（false）|
| |days_name| |大|月の大小（30日/29日）|
| |first_day|number|1|x日（1日固定）|
| | |zodiac_name|庚午|日の干支|
| | |remainder|6-1282|大余小余|
| | |western_date|0862-02-03|西暦日|
| |odd_solar_terms|index|5|節気（番号）　※冬至=0|
| | |remainder|34-5368|大余小余|
| |even_solar_terms|index|4|中気（番号）　※冬至=0|
| | |remainder|19-3532|大余小余|
|day|number| |1|x日|
| |zodiac_name| |庚午|日の干支|
| |remainder| |6-1282|大余小余|
| |western_date| |0862-02-03|西暦日|

# 暦算

[宣明暦](./lib/zakuro/version/senmyou/README.md) のみ記載しております。

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/pldb/zakuro.


## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
