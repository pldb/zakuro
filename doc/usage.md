# 使用方法

使用例は後述しております。

## 手順

### 条件設定

期待する結果を得るためには、適切な条件を渡す必要があります。

条件はHash型で渡します。

```
require 'zakuro'

# 初期化時の設定
merchant = Zakuro::Merchant.new(condition: { date: Date.new(862, 2, 3) })
```

詳細は、 [条件](./condition.md) を参照してください。

### 条件再設定

一度設定した条件を書き換えることが可能です。

```
# 再設定
merchant.offer(condition: { date: western_date })

# 条件を指定しない初期化
merchant = Zakuro::Merchant.new

# 後付けで条件を設定する
merchant.offer(condition: { date: western_date })
```

### 結果取得

#### JSON（整形なし）
```
puts merchant.commit.to_json
# => {"data":{"year":{"first_gengou":{"name":"貞観","number":4},"second_gengou":{"name":"","number":-1},"zodiac_name":"壬午","total_days":354},"month":{"number":1,"leaped":false,"days_name":"大","first_day":{"number":1,"zodiac_name":"庚午","remainder":"6-1282","western_date":"0862-02-03"},"odd_solar_terms":[{"index":5,"remainder":"34-5368"}],"even_solar_terms":[{"index":4,"remainder":"19-3532"}]},"day":{"number":1,"zodiac_name":"庚午","remainder":"6-1282","western_date":"0862-02-03"},"options":{}},"operation":{"operated":false,"month":{"current":{"id":"","western_date":"","page":-1,"number":-1,"annotations":[]},"parent":{"id":"","western_date":"","page":-1,"number":-1,"annotations":[]}},"original":{"year":{"first_gengou":{"name":"貞観","number":4},"second_gengou":{"name":"","number":-1},"zodiac_name":"壬午","total_days":354},"month":{"number":1,"leaped":false,"days_name":"大","first_day":{"number":1,"zodiac_name":"庚午","remainder":"6-1282","western_date":"0862-02-03"},"odd_solar_terms":[{"index":5,"remainder":"34-5368"}],"even_solar_terms":[{"index":4,"remainder":"19-3532"}]},"day":{"number":1,"zodiac_name":"庚午","remainder":"6-1282","western_date":"0862-02-03"},"options":{}}}}
```

#### JSON（整形あり）

行数が多いため結果は省略します。
```
puts merchant.commit.to_pretty_json
# => {
  "data": {
    "year": {
      "first_gengou": {
        "name": "貞観",
        "number": 4
      },
      "second_gengou": {
        "name": "",
        "number": -1
      },
      "zodiac_name": "壬午",
      "total_days": 354
    },
# 中略
  }
}
```

## 使用例

### 一日検索（西暦 -> 和暦）

```
require 'zakuro'

# 条件となる西暦日を準備する
western_date = Date.new(862, 2, 3)

# ざくろ商人（Zakuro::Merchant）に西暦日を渡す
merchant = Zakuro::Merchant.new(condition: { date: western_date })

# 結果の和暦日を取得する
puts merchant.commit.to_json
# => {"data":{"year":{"first_gengou":{"name":"貞観","number":4},"second_gengou":{"name":"","number":-1},"zodiac_name":"壬午","total_days":354},"month":{"number":1,"leaped":false,"days_name":"大","first_day":{"number":1,"zodiac_name":"庚午","remainder":"6-1282","western_date":"0862-02-03"},"odd_solar_terms":[{"index":5,"remainder":"34-5368"}],"even_solar_terms":[{"index":4,"remainder":"19-3532"}]},"day":{"number":1,"zodiac_name":"庚午","remainder":"6-1282","western_date":"0862-02-03"},"options":{}},"operation":{"operated":false,"month":{"current":{"id":"","western_date":"","page":-1,"number":-1,"annotations":[]},"parent":{"id":"","western_date":"","page":-1,"number":-1,"annotations":[]}},"original":{"year":{"first_gengou":{"name":"貞観","number":4},"second_gengou":{"name":"","number":-1},"zodiac_name":"壬午","total_days":354},"month":{"number":1,"leaped":false,"days_name":"大","first_day":{"number":1,"zodiac_name":"庚午","remainder":"6-1282","western_date":"0862-02-03"},"odd_solar_terms":[{"index":5,"remainder":"34-5368"}],"even_solar_terms":[{"index":4,"remainder":"19-3532"}]},"day":{"number":1,"zodiac_name":"庚午","remainder":"6-1282","western_date":"0862-02-03"},"options":{}}}}

```

### 一日検索（和暦 -> 和暦）

```
require 'zakuro'

# 条件となる和暦日を準備する
japan_date = '貞観4年1月1日'

# ざくろ商人（Zakuro::Merchant）に和暦日を渡す
merchant = Zakuro::Merchant.new(condition: { date: japan_date })

# 結果の和暦日を取得する
puts merchant.commit.to_json
# => {"data":{"year":{"first_gengou":{"name":"貞観","number":4},"second_gengou":{"name":"","number":-1},"zodiac_name":"壬午","total_days":354},"month":{"number":1,"leaped":false,"days_name":"大","first_day":{"number":1,"zodiac_name":"庚午","remainder":"6-1282","western_date":"0862-02-03"},"odd_solar_terms":[{"index":5,"remainder":"34-5368"}],"even_solar_terms":[{"index":4,"remainder":"19-3532"}]},"day":{"number":1,"zodiac_name":"庚午","remainder":"6-1282","western_date":"0862-02-03"},"options":{}},"operation":{"operated":false,"month":{"current":{"id":"","western_date":"","page":-1,"number":-1,"annotations":[]},"parent":{"id":"","western_date":"","page":-1,"number":-1,"annotations":[]}},"original":{"year":{"first_gengou":{"name":"貞観","number":4},"second_gengou":{"name":"","number":-1},"zodiac_name":"壬午","total_days":354},"month":{"number":1,"leaped":false,"days_name":"大","first_day":{"number":1,"zodiac_name":"庚午","remainder":"6-1282","western_date":"0862-02-03"},"odd_solar_terms":[{"index":5,"remainder":"34-5368"}],"even_solar_terms":[{"index":4,"remainder":"19-3532"}]},"day":{"number":1,"zodiac_name":"庚午","remainder":"6-1282","western_date":"0862-02-03"},"options":{}}}}
```

### 範囲検索（西暦 -> 和暦）

TODO: make

### 範囲検索（和暦 -> 和暦）

TODO: make
