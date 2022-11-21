# 元嘉暦

允恭天皇34年1月1日（445/01/24）-文武天皇1年12月29日（698/02/15）

# 著者

[pldb](https://github.com/pldb)

# 前提

元嘉暦は太陰太陽暦である

詳細は [太陰太陽暦](./section/lunisolar_calendar.md) に記載してある

# 計算

計算にあたって、暦共通の計算と、元嘉暦固有の計算がある

暦共通の計算は前処理/後処理として説明する

その間に元嘉暦固有の計算を説明することとする

## 共通前処理

詳細は [共通前処理](./section/common_pre_process.md) に記載してある

## 元嘉暦固有の計算

計算手順を以下に示す

1. 正月朔を求める
2. 正月中気を求める

1の計算方法は『日本暦日原典』p.522-523に依拠する

2の計算方法は『日本暦日原典』、『歴代天文律暦等志彙編　六』p.1728 に依拠する

### 正月朔を求める

前提として、 `西暦0年の積年` (1612) を使用する

これは次の式により求められる

`積年` (5703) - `元嘉20年` (443) - ( `紀法` (608) * `干支` (60) )

次に、西暦x年の正月朔の大余小余を求める

1. ( `西暦0年の積年` (1612) + x ) * `メトン周期（19年=235朔望月）` ( 235 / 19 ) = A ...余り

2. A * `1年（紀日 / 紀法）` ( 22207 / 752 ) = B ...余りが朔の小余

3. B / `大余上限` (60) = C ...余りが朔の大余

『日本暦日原典』に挙げられている西暦529年の場合は次の通りとなる

1. (1612 + 529) * 235 / 19 = 26480 ...15

2. 26480 * 22207 / 752 = 781969 ...672

3. 781969 / 60 = 13032 ...49

これにより、大余49、小余 672 / `小余上限` (752) = 0.8936 が求められる

### 正月中気を求める

こちらは宋書（『歴代天文律暦等志彙編　六』）を参考にする

西暦x年の正月中気の大余小余を求める

1. ( `西暦0年の積年` (1612) + x) * `餘数 / 度法` (1595 / 304) = A' ...余りが中気の小余

2. A' / 60 = B' ...余りが朔の大余

西暦529年の場合は次の通りとなる

1. (1612 + 529) * 1595 / 304 = 11233 ...63

2. 11233 / 60 = 13033 ...13

これにより、大余13、小余 126 / `度法` (304) = 0.2072 が求められる

#### 計算方法の相違

『日本暦日原典』の場合は次のようになる

1. ( `西暦0年の積年` (1612) + x) * `紀日 / 紀法` (222070 / 608) = A' ...余りが中気の小余

2. A' / 60 = B' ...余りが朔の大余

『日本暦日原典』では分母を `紀法` にしているが、当ライブラリでは宋書にならって `度法` としたため採用しなかった

両者は計算方法は異なるが、結果の大余小余は変わらない

#### 餘数とは

先述の `餘数` (1595) については注釈がないが、次のように求めることができた

`紀日` (222070) = `紀法` (608) * 360 + 3190

この 3190 が余りとなるが、分母が `紀法` (608) ではなく `度法` (304) のため2で割る

これにより 3190 / 2 = 1595 となる

## 共通後処理

詳細は [共通後処理](./section/common_post_process.md) に記載してある

# 結語

暦共通・元嘉暦の暦算は以上である

# 参考文献

* 内田　正男『日本暦日原典』雄山閣出版 1975(1975)
* 『歴代天文律暦等志彙編　六』中華書房
