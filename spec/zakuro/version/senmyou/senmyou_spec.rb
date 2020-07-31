# frozen_string_literal: true

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
            Zakuro::Result::SingleDay.new(
              year: Zakuro::Result::Year.new(
                first_gengou: Zakuro::Result::Gengou.new(name: '貞観', number: 4),
                second_gengou: Zakuro::Result::Gengou.new(name: '', number: -1),
                zodiac_name: '壬午',
                total_days: 354
              ),
              month: Zakuro::Result::Month.new(
                number: 1,
                leaped: false,
                days_name: '大',
                first_day: Zakuro::Result::Day.new(
                  number: 1, zodiac_name: '庚午', remainder: '6-1282',
                  western_date: '0862-02-03'
                ),
                odd_solar_terms: [
                  Zakuro::Result::SolarTerm.new(
                    index: 5, remainder: '34-5368'
                  )
                ],
                even_solar_terms: [
                  Zakuro::Result::SolarTerm.new(
                    index: 4, remainder: '19-3532'
                  )
                ]
              ),
              day: Zakuro::Result::Day.new(
                number: 1, zodiac_name: '庚午', remainder: '6-1282',
                western_date: '0862-02-03'
              )
            )
          end
          example '貞観4年1月1日' do
            date = Date.new(862, 2, 3)
            actual = Zakuro::Senmyou::Gateway.to_japan_date(western_date: date)
            expect(actual.to_pretty_json).to eql(first_day.to_pretty_json)
          end
        end
      end
    end
  end
end
# rubocop:enable Metrics/BlockLength
