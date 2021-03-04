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
        context 'xxxx' do
          it 'should xxxx' do
            # TODO: test case

            # - id: 266-1-1
            # relation_id: "-"
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
            #   even_term:
            #     to: '1202-12-16'
            #     day: '1'
            #   day: "-"
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
                western_date: Zakuro::Western::Calendar.new(year: 1202, month: 11, day: 17)
              ),
              solar_terms: [Zakuro::Senmyou::SolarTerm.new(
                index: 23,
                remainder: Zakuro::Senmyou::Remainder.new(day: 51, minute: 6309, second: 0)
              )]
            )

            # TODO: 中気の移動
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
