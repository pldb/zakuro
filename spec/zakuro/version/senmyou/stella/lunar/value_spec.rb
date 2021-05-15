# frozen_string_literal: true

require File.expand_path('../../../../../../' \
                         'lib/zakuro/version/senmyou/cycle/remainder',
                         __dir__)
require File.expand_path('../../../../../../' \
                         'lib/zakuro/version/senmyou/stella/lunar/value',
                         __dir__)

# データ元: 長慶宣明暦算法
# https://kotenseki.nijl.ac.jp/biblio/100257607/viewer/135
#
# 内容を理解する上では「安藤有益著『再考長慶宣明暦算法』 について」が分かりやすい
# http://www.kurims.kyoto-u.ac.jp/~kyodo/kokyuroku/contents/pdf/1444-9.pdf
# p.101
#
# rubocop:disable Layout/LineLength
moon_orbit_values = [
  # 各頁を文字起こししている。4行目/5行目がテストデータに対応している
  #
  # 十一月大
  # https://kotenseki.nijl.ac.jp/biblio/100257607/viewer/135
  # 左頁
  #
  # |余四千二百六十三 朔五十二 秒| 余二千六百零四 小雪一十 秒二| 余五百六十七 朓| 余二千四百四十六 退二 秒六十六半| 余一千零四十一 朓| 余二千六百五十五 五十二 丙辰|
  { remainder: Zakuro::Senmyou::Cycle::LunarRemainder.new(day: 2, minute: 2446, second: 66.5),  forward: false, value: -1041 },
  # |余七千四百七十七 上五十九 秒二| 余五百八十二 大雪三 秒七| 余三百六十 朓| 余五千六百六十 同九　秒九十一半| 余二千九百五十四 朓| 余四千二百六十三 五十九 癸亥|
  { remainder: Zakuro::Senmyou::Cycle::LunarRemainder.new(day: 9, minute: 5660, second: 91.5),  forward: false, value: -2954 },
  # |余二千二百九十一 望七 秒四| 余三千七百九十七 同一十 秒一| 余一百三十三 朓| 余二千三百四十六 進三 秒七| 余一千七百二十五 朒| 余三千八百八十三 七 辛未|
  { remainder: Zakuro::Senmyou::Cycle::LunarRemainder.new(day: 3, minute: 2346, second: 7),     forward: true,  value: +1725 },
  # |余五千五百零五 下一十四 秒六| 余二千七百七十五 冬至三 秒六| 余一百一十 朒| 余五千五百六十 同一十 秒三十二| 余二千六百七十 朒| 余八千二百八十五 一十四 戊寅|
  { remainder: Zakuro::Senmyou::Cycle::LunarRemainder.new(day: 10, minute: 5560, second: 32),   forward: true,  value: +2670 },
  #
  # 十二月小
  # https://kotenseki.nijl.ac.jp/biblio/100257607/viewer/136
  # 右頁
  #
  # |余三百二十 朔二十二 秒| 余五千九百九十 同一十 秒| 余三百三十八 朒| 余二千二百四十五 退四 秒四十七半| 余二千二百七十八 朓| 余六千七百八十 二十一 丙戌|
  { remainder: Zakuro::Senmyou::Cycle::LunarRemainder.new(day: 4, minute: 2245, second: 47.5),  forward: false,  value: -2278 },
  # |余三千五百三十四 上二十九 秒二| 余四千九百六十八 小寒三 秒五| 余五百四十七 朒| 余五千四百五十九 同一十一 秒七十二半| 余二千一百八十九 朓| 余一千八百九十二 二十九 壬辰|
  { remainder: Zakuro::Senmyou::Cycle::LunarRemainder.new(day: 11, minute: 5459, second: 72.5), forward: false,  value: -2189 },
  # |余六千七百四十八 望三十六 秒四| 余八千一百八十二 同一十 秒七| 余七百三十六 朒| 余二千一百四十四 進五 秒八十八| 余二千七百一十九 朒| 余一千八百零三 三十七 庚子|
  { remainder: Zakuro::Senmyou::Cycle::LunarRemainder.new(day: 5, minute: 2144, second: 88),    forward: true, value: +2719 },
  # |余一千五百六十二 下四十四 秒六| 余六千一百六十一 大寒三 秒四| 余九百零五 朒| 余五千三百五十九 同一十二 秒一十三| 余一千六百二十七 朒| 余四千零九十四 四十四 戌甲|
  { remainder: Zakuro::Senmyou::Cycle::LunarRemainder.new(day: 12, minute: 5359, second: 13),   forward: true, value: +1627 },
  #
  # 正月大
  # https://kotenseki.nijl.ac.jp/biblio/100257607/viewer/136
  # 左頁
  #
  # |余四千七百七十七 朔五十一 秒| 余九百七十五 同一十一 秒六| 余一千零五十五 朒| 余二千零四十四 退六 秒二十八半| 余二千九百九十四 朓| 余二千八百二十八 五十一 乙卯|
  { remainder: Zakuro::Senmyou::Cycle::LunarRemainder.new(day: 6, minute: 2044, second: 28.5),  forward: false,  value: -2994 },
  # |余七千九百九十一 上五十八 秒二| 余六千三百五十四 立春三 秒三| 余一千一百八十六 朒| 余五千二百五十八 同一十三 秒五十三半| 余九百二十三 朓| 余八千二百五十四 五十八 壬戌|
  { remainder: Zakuro::Senmyou::Cycle::LunarRemainder.new(day: 13, minute: 5258, second: 53.5), forward: false,  value: -923 },
  # |余二千八百零五 望六　秒四| 余一千一百六十八 同一十一 秒五| 余一千二百九十八 朒| 余一千九百四十三 進七 秒六十九| 余三千一百八十六 朒| 余七千二百八十九 六 庚午|
  { remainder: Zakuro::Senmyou::Cycle::LunarRemainder.new(day: 7, minute: 1943, second: 69),    forward: true, value: +3186 },
  # |余六千零一十九 下一十三 秒六| 余五千五百四十七 雨水三 秒二| 余一千三百八十七 朒| 余五千一百五十七 同一十四 秒九十四| 余一百三十六　朒| 余七千五百四十二 一十三 丁丑|
  { remainder: Zakuro::Senmyou::Cycle::LunarRemainder.new(day: 14, minute: 5157, second: 94),   forward: true, value: +136 }
]
# rubocop:enable Layout/LineLength

# rubocop:disable Metrics/BlockLength
describe 'Zakuro' do
  describe 'Senmyou' do
    describe 'Lunar' do
      describe 'Value' do
        # http://www.kurims.kyoto-u.ac.jp/~kyodo/kokyuroku/contents/pdf/1444-9.pdf
        describe '.get' do
          context 'moon_orbit_value' do
            it 'should be expected values' do
              fails = []
              moon_orbit_values.each do |moon_orbit_value|
                actual = Zakuro::Senmyou::Lunar::Value.get(
                  remainder: moon_orbit_value[:remainder],
                  forward: moon_orbit_value[:forward]
                )
                if actual != moon_orbit_value[:value]
                  fails.push(parameter: moon_orbit_value, actual: actual)
                end
              end
              message = ''
              fails.each do |f|
                message += "[parameter: #{f[:parameter]}, \nactual: #{f[:actual]}]\n"
              end
              expect(fails).to be_empty, message
            end
          end
        end
      end
    end
  end
end
# rubocop:enable Metrics/BlockLength
