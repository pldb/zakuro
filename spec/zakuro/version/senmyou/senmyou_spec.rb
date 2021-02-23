# frozen_string_literal: true

require File.expand_path('../../../testtools/stringifier', __dir__)

require File.expand_path('../../../../' \
                         'lib/zakuro/version/senmyou/senmyou',
                         __dir__)

require 'date'

# rubocop:disable Metrics/BlockLength
describe 'Zakuro' do
  describe 'Senmyou' do
    describe 'Gateway' do
      describe '.to_japan_date' do
        context '862-2-3' do
          let!(:first_day) do
            Zakuro::Result::Data::SingleDay.new(
              year: Zakuro::Result::Data::Year.new(
                first_gengou: Zakuro::Result::Data::Gengou.new(name: '貞観', number: 4),
                second_gengou: Zakuro::Result::Data::Gengou.new(name: '', number: -1),
                zodiac_name: '壬午',
                total_days: 354
              ),
              month: Zakuro::Result::Data::Month.new(
                number: 1,
                leaped: false,
                days_name: '大',
                first_day: Zakuro::Result::Data::Day.new(
                  number: 1, zodiac_name: '庚午', remainder: '6-1282',
                  western_date: '0862-02-03'
                ),
                odd_solar_terms: [
                  Zakuro::Result::Data::SolarTerm.new(
                    index: 5, remainder: '34-5368'
                  )
                ],
                even_solar_terms: [
                  Zakuro::Result::Data::SolarTerm.new(
                    index: 4, remainder: '19-3532'
                  )
                ]
              ),
              day: Zakuro::Result::Data::Day.new(
                number: 1, zodiac_name: '庚午', remainder: '6-1282',
                western_date: '0862-02-03'
              )
            )
          end
          example '貞観4年1月1日' do
            date = Date.new(862, 2, 3)
            actual = Zakuro::Senmyou::Gateway.to_japan_date(western_date: date)

            TestTools::Stringifier.eql?(
              expected: first_day, actual: actual, class_prefix: 'Zakuro::Result'
            )
          end
        end
      end
    end
  end
end
# rubocop:enable Metrics/BlockLength
