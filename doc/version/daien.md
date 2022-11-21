# 大衍暦

天平宝字8年1月1日（764/02/07）- 貞観3年12月30日（862/02/02）

# 著者

[pldb](https://github.com/pldb)

# 前提

大衍暦は太陰太陽暦である

詳細は [太陰太陽暦](./section/lunisolar_calendar.md) に記載してある

# 計算

計算にあたって、暦共通の計算と、大衍暦固有の計算がある

暦共通の計算は前処理/後処理として説明する

その間に大衍暦固有の計算を説明することとする

## 共通前処理

詳細は [共通前処理](./section/common_pre_process.md) に記載してある

## 大衍暦固有の計算

計算手順を以下に示す

1. 11月定朔（補正後の月初日）を求める
    1. 対象の西暦年から前年冬至を求める
    2. 対象の西暦年から冬至の月齢を求める
    3. 前年冬至から11月経朔（補正前の月初日）を求める
    4. 二十四節気から太陽の運動の補正値を求める
    5. 月の進退から月の運動の補正値を求める
    6. 太陽・月の運動の補正値から11月定朔（補正後の月初日）を求める
2. 12月定朔（補正後の月初日）を求める
    1. 11月経朔を進めて12月経朔を求める
    2. 11月の二十四節気を進めて12月の二十四節気を求める
    3. 12月の二十四節気から太陽の運動の補正値を求める
    4. 11月の月の進退を進めて12月の月の進退を求める
    5. 12月の月の進退から月の運動の補正値を求める
    6. 太陽・月の運動の補正値から12月定朔（補正後の月初日）を求める

1の計算方法は『日本暦日原典』p.516-521に依拠する

基本的に [宣明暦](./senmyou.md) と手順は変わらない

使用する定数の差分は [定数](./section/const.md) に記載してある

上記のうち、宣明暦との差分のみ記載する

### 二十四節気から太陽の運動の補正値を求める

「24気損益眺朒数」は次の通りである

|-|a（眺朒数の初日の値）|b（損益率初日の値）|c（一日ごとの差）|
|:----|:----|:----|:----|
|冬至（とうじ）|0.0|+13.4524|-0.1886|
|小寒（しょうかん）|+176.0|+10.5564|-0.1634|
|大寒（だいかん）|+314.0|+8.0408|-0.1446|
|立春（りっしゅん）|+418.0|+5.8160|-0.1318|
|雨水（うすい）|+491.0|+3.7987|-0.1240|
|啓蟄（けいちつ）|+535.0|+1.9265|-0.1240|
|春分（しゅんぶん）|+551.0|-0.2048|-0.1178|
|清明（せいめい）|+535.0|-1.9968|-0.1190|
|穀雨（こくう）|+491.0|-3.7956|-0.1240|
|立夏（りっか）|+418.0|-5.6626|-0.1324|
|小満（しょうまん）|+314.0|-7.6555|-0.1436|
|芒種（ぼうしゅ）|+176.0|-9.9405|-0.1436|
|夏至（げし）|0.0|-12.0819|+0.1436|
|小暑（しょうしょ）|-176.0|-9.7018|+0.1324|
|大暑（たいしょ）|-314.0|-7.5450|+0.1240|
|立秋（りっしゅう）|-418.0|-5.5634|+0.1190|
|処暑（しょしょ）|-491.0|-3.7038|+0.1178|
|白露（はくろ）|-535.0|-1.8954|+0.1178|
|秋分（しゅうぶん）|-551.0|+0.1783|+0.1240|
|寒露（かんろ）|-535.0|+2.0042|+0.1318|
|霜降（そうこう）|-491.0|+3.8950|+0.1446|
|立冬（りっとう）|-418.0|+5.9214|+0.1634|
|小雪（しょうせつ）|-314.0|+8.1610|+0.1886|
|大雪（たいせつ）|-176.0|+10.9010|+0.1886|

#### 月の進退から月の運動の補正値を求める

宣明暦とは異なり、次の表を用いる

|入暦|小余（下限）|小余（上限）|増減率|遅速積|備考|
|:----|:----|:----|:----|:----|:----|
|01日|0|3040|+297|0|-|
|02日|0|3040|+259|+297|-|
|03日|0|3040|+220|+556|-|
|04日|0|3040|+180|+776|-|
|05日|0|3040|+139|+956|-|
|06日|0|3040|+97|+1095|-|
|07日|0|2701|+48|+1192|-|
|07日|2701|3040|-6|+1240|+1192 + 48|
|08日|0|3040|-64|+1234|-|
|09日|0|3040|-106|+1170|-|
|10日|0|3040|-148|+1064|-|
|11日|0|3040|-189|+916|-|
|12日|0|3040|-229|+727|-|
|13日|0|3040|-267|+498|-|
|14日|0|2363|-231|+231|-|
|14日|2363|3040|-66|0|+232 - 231|
|15日|0|3040|-289|-66|-|
|16日|0|3040|-250|-355|-|
|17日|0|3040|-211|-605|-|
|18日|0|3040|-171|-816|-|
|19日|0|3040|-130|-987|-|
|20日|0|3040|-87|-1117|-|
|21日|0|2024|-36|-1204|-|
|21日|2024|3040|+18|-1240|-1204 - 36|
|22日|0|3040|+73|-1222|-|
|23日|0|3040|+116|-1149|-|
|24日|0|3040|+157|-1033|-|
|25日|0|3040|+198|-876|-|
|26日|0|3040|+237|-678|-|
|27日|0|3040|+276|-441|-|
|28日|0|1686|+165|-165|-|

『歴代天文律暦等志彙編　七』中華書房 p.2228-2230 により作成した

宣明暦とは異なり進退の列がないが、それは無視して入暦だけを求めればよい

これは『日本暦日原典』の中で計算方法Aとされている

他の計算方法B,Cも掲載されているが、ここでは一旦割愛する

#### 11月の二十四節気を進めて12月の二十四節気を求める

「入気定日加減数」は次の通りである

|二十四節気|経過|
|:----|:----|
| 冬至（とうじ）・大雪（たいせつ）|14 日 1351 分 7 秒|
| 小寒（しょうかん）・小雪（しょうせつ）|14 日 1859 分 7 秒
| 大寒（だいかん）・立冬（りっとう）|14 日 2314 分 7 秒|
| 立春（りっしゅん）・霜降（そうこう）|14 日 2728 分 7 秒|
| 雨水（うすい）・寒露（かんろ）|15 日 76 分 7 秒|
| 啓蟄（けいちつ）・秋分（しゅうぶん）|15 日 450 分 7 秒|
| 春分（しゅんぶん）・白露（はくろ）|15 日 878 分 7 秒|
| 清明（せいめい）・処暑（しょしょ）|15 日 1252 分 7 秒|
| 穀雨（こくう）・立秋（りっしゅう）|15 日 1640 分 7 秒|
| 立夏（りっか）・大暑（たいしょ）|15 日 2054 分 7 秒|
| 小満（しょうまん）・小暑（しょうしょ）|15 日 2509 分 7 秒|
| 芒種（ぼうしゅ）・夏至（げし）|15 日 3017 分 7 秒|

気策の 15-664.7 に対して、『歴代天文律暦等志彙編　七』中華書房 p.2224 盈縮分の行で加減している

## 共通後処理

詳細は [共通後処理](./section/common_post_process.md) に記載してある

# 結語

暦共通・大衍暦の暦算は以上である

# 参考文献

* 内田　正男『日本暦日原典』雄山閣出版 1975(1975)
* 『歴代天文律暦等志彙編　七』中華書房