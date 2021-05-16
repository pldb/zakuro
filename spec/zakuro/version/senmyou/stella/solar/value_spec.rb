# frozen_string_literal: true

require File.expand_path('../../../../../../' \
                         'lib/zakuro/version/senmyou/cycle/remainder',
                         __dir__)
require File.expand_path('../../../../../../' \
                         'lib/zakuro/version/senmyou/cycle/solar_term',
                         __dir__)
require File.expand_path('../../../../../../' \
                         'lib/zakuro/version/senmyou/stella/origin/lunar_age',
                         __dir__)
require File.expand_path('../../../../../../' \
                         'lib/zakuro/version/senmyou/monthly/lunar_phase',
                         __dir__)
require File.expand_path('../../../../../../' \
                         'lib/zakuro/version/senmyou/stella/solar/interval',
                         __dir__)
require File.expand_path('../../../../../../' \
                        'lib/zakuro/version/senmyou/stella/solar/value',
                         __dir__)

require 'json'

# データ元: 長慶宣明暦算法
# https://kotenseki.nijl.ac.jp/biblio/100257607/viewer/135
#
# 内容を理解する上では「安藤有益著『再考長慶宣明暦算法』 について」が分かりやすい
# http://www.kurims.kyoto-u.ac.jp/~kyodo/kokyuroku/contents/pdf/1444-9.pdf
# p.101
#
# ただしデータに一部誤りがある。11月大の望月の補正値が「朒133」（+133）となっているが、これでは冬至を越える前に値が+に転じえないため-133である
# 実際に長慶宣明暦算法では -133 であることを確認した
#
# rubocop:disable Layout/LineLength
SOLAR_TEST_CASES = [
  # 各頁を文字起こししている。2行目/3行目がテストデータに対応している
  #
  # 十一月大
  # https://kotenseki.nijl.ac.jp/biblio/100257607/viewer/135
  # 左頁
  #
  # |余四千二百六十三 朔五十二 秒| 余二千六百零四 小雪一十 秒二| 余五百六十七 朓| 余二千四百四十六 退二 秒六十六半| 余一千零四十一 朓| 余二千六百五十五 五十二 丙辰|
  { solar_term_index: 22, remainder: Zakuro::Senmyou::Cycle::Remainder.new(day: 10, minute: 2604, second: 2), value: -567 },
  # |余七千四百七十七 上五十九 秒二| 余五百八十二 大雪三 秒七| 余三百六十 朓| 余五千六百六十 同九　秒九十一半| 余二千九百五十四 朓| 余四千二百六十三 五十九 癸亥|
  { solar_term_index: 23, remainder: Zakuro::Senmyou::Cycle::Remainder.new(day: 3, minute: 582, second: 7),   value: -360 },
  # |余二千二百九十一 望七 秒四| 余三千七百九十七 同一十 秒一| 余一百三十三 朓| 余二千三百四十六 進三 秒七| 余一千七百二十五 朒| 余三千八百八十三 七 辛未|
  { solar_term_index: 23, remainder: Zakuro::Senmyou::Cycle::Remainder.new(day: 10, minute: 3797, second: 1), value: -133 },
  # |余五千五百零五 下一十四 秒六| 余二千七百七十五 冬至三 秒六| 余一百一十 朒| 余五千五百六十 同一十 秒三十二| 余二千六百七十 朒| 余八千二百八十五 一十四 戊寅|
  { solar_term_index: 0,  remainder: Zakuro::Senmyou::Cycle::Remainder.new(day: 3, minute: 2775, second: 6),  value: +110 },
  #
  # 十二月小
  # https://kotenseki.nijl.ac.jp/biblio/100257607/viewer/136
  # 右頁
  #
  # |余三百二十 朔二十二 秒| 余五千九百九十 同一十 秒| 余三百三十八 朒| 余二千二百四十五 退四 秒四十七半| 余二千二百七十八 朓| 余六千七百八十 二十一 丙戌|
  { solar_term_index: 0,  remainder: Zakuro::Senmyou::Cycle::Remainder.new(day: 10, minute: 5990, second: 0), value: +338 },
  # |余三千五百三十四 上二十九 秒二| 余四千九百六十八 小寒三 秒五| 余五百四十七 朒| 余五千四百五十九 同一十一 秒七十二半| 余二千一百八十九 朓| 余一千八百九十二 二十九 壬辰|
  { solar_term_index: 1,  remainder: Zakuro::Senmyou::Cycle::Remainder.new(day: 3, minute: 4968, second: 5),  value: +547 },
  # |余六千七百四十八 望三十六 秒四| 余八千一百八十二 同一十 秒七| 余七百三十六 朒| 余二千一百四十四 進五 秒八十八| 余二千七百一十九 朒| 余一千八百零三 三十七 庚子|
  { solar_term_index: 1,  remainder: Zakuro::Senmyou::Cycle::Remainder.new(day: 10, minute: 8182, second: 7), value: +736 },
  # |余一千五百六十二 下四十四 秒六| 余六千一百六十一 大寒三 秒四| 余九百零五 朒| 余五千三百五十九 同一十二 秒一十三| 余一千六百二十七 朒| 余四千零九十四 四十四 戌甲|
  { solar_term_index: 2,  remainder: Zakuro::Senmyou::Cycle::Remainder.new(day: 3, minute: 6161, second: 4),  value: +905 },
  #
  # 正月大
  # https://kotenseki.nijl.ac.jp/biblio/100257607/viewer/136
  # 左頁
  #
  # |余四千七百七十七 朔五十一 秒| 余九百七十五 同一十一 秒六| 余一千零五十五 朒| 余二千零四十四 退六 秒二十八半| 余二千九百九十四 朓| 余二千八百二十八 五十一 乙卯|
  { solar_term_index: 2,  remainder: Zakuro::Senmyou::Cycle::Remainder.new(day: 11, minute: 975, second: 6),  value: +1055 },
  # |余七千九百九十一 上五十八 秒二| 余六千三百五十四 立春三 秒三| 余一千一百八十六 朒| 余五千二百五十八 同一十三 秒五十三半| 余九百二十三 朓| 余八千二百五十四 五十八 壬戌|
  { solar_term_index: 3,  remainder: Zakuro::Senmyou::Cycle::Remainder.new(day: 3, minute: 6354, second: 3),  value: +1186 },
  # |余二千八百零五 望六　秒四| 余一千一百六十八 同一十一 秒五| 余一千二百九十八 朒| 余一千九百四十三 進七 秒六十九| 余三千一百八十六 朒| 余七千二百八十九 六 庚午|
  { solar_term_index: 3,  remainder: Zakuro::Senmyou::Cycle::Remainder.new(day: 11, minute: 1168, second: 5), value: +1298 },
  # |余六千零一十九 下一十三 秒六| 余五千五百四十七 雨水三 秒二| 余一千三百八十七 朒| 余五千一百五十七 同一十四 秒九十四| 余一百三十六　朒| 余七千五百四十二 一十三 丁丑|
  { solar_term_index: 4,  remainder: Zakuro::Senmyou::Cycle::Remainder.new(day: 3, minute: 5547, second: 2),  value: +1387 }
].freeze
# rubocop:enable Layout/LineLength

# rubocop:disable Metrics/BlockLength
describe 'Zakuro' do
  describe 'Senmyou' do
    describe 'Solar' do
      describe 'Value' do
        describe '.get' do
          context 'western year 1650' do
            let(:year) { 1650 }

            # :reek:UtilityFunction
            def error_message(fails:)
              message = ''
              fails.each do |fail|
                message += "#{JSON.generate(fail)}\n"
              end
              message
            end
            it 'should be expected value' do
              lunar_age = Zakuro::Senmyou::Origin::LunarAge.get(western_year: year)
              solar_location = Zakuro::Senmyou::Solar::Location.new(
                lunar_age: lunar_age
              )

              solar_location.run

              fails = []
              SOLAR_TEST_CASES.each_with_index do |sun_orbit_value, index|
                solar_location.run
                value = Zakuro::Senmyou::Solar::Value.get(solar_location: solar_location)

                # judgement
                actual = { solar_term_index: solar_location.index,
                           remainder: solar_location.remainder.clone, value: value }

                # next
                solar_location.add_quarter

                next if actual == sun_orbit_value

                fails.push(
                  {
                    index: index,
                    actual: actual,
                    expect: sun_orbit_value
                  }
                )
              end

              expect(fails).to be_empty, error_message(fails: fails)
            end
          end
        end
      end
    end
  end
end
# rubocop:enable Metrics/BlockLength
