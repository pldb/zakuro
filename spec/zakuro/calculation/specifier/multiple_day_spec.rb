# frozen_string_literal: true

require File.expand_path('../../../testtools/stringifier',
                         __dir__)

require File.expand_path('../../../../' \
  'lib/zakuro/calculation/range/full_range',
                         __dir__)

require File.expand_path('../../../../' \
  'lib/zakuro/version/context',
                         __dir__)

require File.expand_path('../../../../' \
  'lib/zakuro/calculation/specifier/multiple_day',
                         __dir__)

# rubocop:disable Metrics/BlockLength
describe 'Zakuro' do
  describe 'Calculation' do
    describe 'Specifier' do
      describe 'MultipleDay' do
        describe '.get' do
          context 'ancient month from western date 862-2-3' do
            let!(:day) do
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
            context 'as 貞観4年1月' do
              example '1日' do
                date = Zakuro::Western::Calendar.new(year: 862, month: 2, day: 3)

                full_range = Zakuro::Calculation::Range::FullRange.new(
                  context: Zakuro::Context.new(version_name: 'Senmyou'),
                  start_date: date,
                  last_date: date
                )

                actual = Zakuro::Calculation::Specifier::MultipleDay.get(
                  years: full_range.get, start_date: date, last_date: date
                )

                TestTools::Stringifier.eql?(
                  expected: [day],
                  actual: actual,
                  class_prefix: 'Zakuro::Result'
                )
              end
            end
          end
        end
      end
    end
  end
end

# rubocop:enable Metrics/BlockLength
