# 例外処理

## Zakuro::Exception::ZakuroError

例外は `ZakuroError` に集約されます。

```
merchant = Zakuro::Merchant.new(condition: {})
merchant.commit
Traceback (most recent call last):
        4: from ./bin/console:14:in `<main>'
        3: from (irb):5
        2: from /Users/ty/ruby/zakuro/lib/zakuro/merchant.rb:81:in `commit'
        1: from /Users/ty/ruby/zakuro/lib/zakuro/merchant.rb:132:in `make_uncommitable_error'
Zakuro::Exception::ZakuroError (an error has occurred:[{"code":"ERROR_0203","message":"検索不可能な日付指定です。"}])
```

例外に対応したコードとメッセージを取得できます。
```
merchant = Zakuro::Merchant.new(condition: {})
begin
  merchant.commit
rescue Zakuro::Exception::ZakuroError => e
  p e.causes[0].code
  p e.causes[0].message
end
=> "ERROR_0203"
=> "検索不可能な日付指定です。"
```

## エラー種別

`Zakuro::Exception::Case::Pattern` の通りです。

|コード|メッセージ|引数長|
|:----|:----|:----|
|ERROR_0001|内部エラーです。|0|
|ERROR_0101|日付の型は文字列/日付です。指定型:%s|1|
|ERROR_0102|範囲の型はhashです。指定型:%s|1|
|ERROR_0103|オプションの型はhashです。指定型:%s|1|
|ERROR_0104|列の型は配列です。指定型:%s|1|
|ERROR_0105|条件の型は配列です。指定型:%s|1|
|ERROR_0201|一日検索の日付指定が誤っています。|0|
|ERROR_0202|範囲検索の日付指定が誤っています。|0|
|ERROR_0203|検索不可能な日付指定です。|0|
