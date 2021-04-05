# frozen_string_literal: true

require File.expand_path('../../../../testtools/stringifier', __dir__)

require File.expand_path('../../../../../' \
                        'lib/zakuro/version/senmyou/monthly/month',
                         __dir__)

require File.expand_path('../../../../../' \
                        'lib/zakuro/version/senmyou/range/full_range',
                         __dir__)

require File.expand_path('../../../../../' \
                         'lib/zakuro/version/senmyou/range/operated_range',
                         __dir__)

require File.expand_path('../../../../../' \
                         'lib/zakuro/tools/stringifier',
                         __dir__)

# rubocop:disable Metrics/BlockLength

describe 'Zakuro' do
  describe 'Senmyou' do
    describe 'OperatedRange' do
      describe '.get' do
        context 'the month with changed first day' do
          it 'should be in one days at 873-2-1' do
            # - id: 156-1-1
            # relation_id: "-"
            # parent_id: "-"
            # page: '156'
            # number: '1'
            # japan_date: 貞観15年 1  小 丁卯 2-5359
            # western_date: 873-2-1
            # description: 計算では2丙寅である, 三代実録に正月丁卯朔とある。従って正月朔のユリウス暦日は2月2日。
            # note: "-"
            # modified: 'true'
            # diffs:
            #   month:
            #     number:
            #       calc: "-"
            #       actual: "-"
            #     leaped:
            #       calc: "-"
            #       actual: "-"
            #     days:
            #       calc: 大
            #       actual: 小
            #   solar_term:
            #     calc:
            #       index: "-"
            #       to: "-"
            #       zodiac_name: "-"
            #     actual:
            #       index: "-"
            #       from: "-"
            #       zodiac_name: "-"
            #     days: "-"
            #   days: '1'
            date = Zakuro::Western::Calendar.new(year: 873, month: 2, day: 1)

            range = Zakuro::Senmyou::OperatedRange.new(
              full_range: Zakuro::Senmyou::FullRange.new(start_date: date).get
            ).get

            actual = range[14].months[0]
            # 貞観 15年 1 小 丁卯 2-5359 873 2  1 (4)17-937
            expected = Zakuro::Senmyou::Month.new(
              month_label: Zakuro::Senmyou::MonthLabel.new(
                number: 1, is_many_days: false, leaped: false
              ),
              first_day: Zakuro::Senmyou::FirstDay.new(
                # 2-5359 -> 3-5359
                remainder: Zakuro::Senmyou::Remainder.new(
                  day: 3, minute: 5359, second: 0
                ),
                # 873-2-1 -> 873-2-2
                western_date: Zakuro::Western::Calendar.new(year: 873, month: 2, day: 2)
              ),
              solar_terms: [Zakuro::Senmyou::SolarTerm.new(
                index: 4,
                remainder: Zakuro::Senmyou::Remainder.new(day: 17, minute: 937, second: 0)
              )]
            )

            TestTools::Stringifier.eql?(
              expected: expected, actual: actual, class_prefix: 'Zakuro::Senmyou'
            )
          end
        end

        context 'the month with moved solar term' do
          it 'should be removed at 1202-11-17' do
            # - id: 266-1-1
            # relation_id: "-"
            # parent_id: "-"
            # page: '266'
            # number: '1'
            # japan_date: 建仁 2年 閏10 小 壬寅 38-7186
            # western_date: '1202-11-17'
            # description: 計算では冬至が11月晦日であるが, これを朔旦冬至にするため計算の11月を閏10月に, 閏11月を11月にしたもの, 普通は干支を変更するが建仁2年の場合は冬至を6庚午から辛未に移した。（猪隈関白記・吾妻鏡）
            # note: "-"
            # modified: 'true'
            # diffs:
            #   month:
            #     number:
            #       calc: '11'
            #       actual: '10'
            #     leaped:
            #       calc: 'false'
            #       actual: 'true'
            #     days:
            #       calc: 小
            #       actual: 小
            #   solar_term:
            #     calc:
            #       index: '0'
            #       to: '1202-12-16'
            #       zodiac_name: 庚午
            #     actual:
            #       index: "-"
            #       from: "-"
            #       zodiac_name: "-"
            #     days: '1'
            #   days: "-"
            date = Zakuro::Western::Calendar.new(year: 1202, month: 11, day: 17)

            range = Zakuro::Senmyou::OperatedRange.new(
              full_range: Zakuro::Senmyou::FullRange.new(start_date: date).get
            ).get

            actual = range[1].months[10]
            expected = Zakuro::Senmyou::Month.new(
              month_label: Zakuro::Senmyou::MonthLabel.new(
                number: 10, is_many_days: false, leaped: true
              ),
              first_day: Zakuro::Senmyou::FirstDay.new(
                remainder: Zakuro::Senmyou::Remainder.new(
                  day: 38, minute: 7186, second: 0
                ),
                western_date: date
              ),
              # 計算上は冬至(0)がある
              solar_terms: [Zakuro::Senmyou::SolarTerm.new(
                index: 23,
                remainder: Zakuro::Senmyou::Remainder.new(day: 51, minute: 6309, second: 0)
              )]
            )

            TestTools::Stringifier.eql?(
              expected: expected, actual: actual, class_prefix: 'Zakuro::Senmyou'
            )
          end

          it 'should be add at 1202-12-16' do
            #           - id: 266-1-0
            # relation_id: 266-1-1
            # parent_id: "-"
            # page: '266'
            # number: "-"
            # japan_date: 建仁 2年 11 大 辛未  7-5375
            # western_date: '1202-12-16'
            # description: "-"
            # note: "-"
            # modified: 'true'
            # diffs:
            #   month:
            #     number:
            #       calc: '11'
            #       actual: '11'
            #     leaped:
            #       calc: 'true'
            #       actual: 'false'
            #     days:
            #       calc: 大
            #       actual: 大
            #   solar_term:
            #     calc:
            #       index: "-"
            #       to: "-"
            #       zodiac_name: "-"
            #     actual:
            #       index: '0'
            #       from: '1202-11-17'
            #       zodiac_name: 辛未
            #     days: "-"
            #   days: "-"
            date = Zakuro::Western::Calendar.new(year: 1202, month: 12, day: 16)

            range = Zakuro::Senmyou::OperatedRange.new(
              full_range: Zakuro::Senmyou::FullRange.new(start_date: date).get
            ).get

            actual = range[1].months[11]
            expected = Zakuro::Senmyou::Month.new(
              month_label: Zakuro::Senmyou::MonthLabel.new(
                number: 11, is_many_days: true, leaped: false
              ),
              first_day: Zakuro::Senmyou::FirstDay.new(
                remainder: Zakuro::Senmyou::Remainder.new(
                  day: 7, minute: 5375, second: 0
                ),
                western_date: date
              ),
              # 計算上は冬至(0)がない。冬至が1202-11-17から移動している
              # 移動した冬至は大余を1増やす（=冬至を1日分、後日にする）
              solar_terms: [
                Zakuro::Senmyou::SolarTerm.new(
                  index: 1,
                  remainder: Zakuro::Senmyou::Remainder.new(day: 22, minute: 1580, second: 0)
                ),
                # 6-8145 -> 7-8145
                Zakuro::Senmyou::SolarTerm.new(
                  index: 0,
                  remainder: Zakuro::Senmyou::Remainder.new(day: 7, minute: 8145, second: 0)
                )
              ]
            )

            TestTools::Stringifier.eql?(
              expected: expected, actual: actual, class_prefix: 'Zakuro::Senmyou'
            )
          end
        end
      end
    end
  end
end
# rubocop:enable Metrics/BlockLength
