# frozen_string_literal: true

require File.expand_path('../../../../../testtools/stringifier',
                         __dir__)

require File.expand_path('../../../../../../' \
                         'lib/zakuro/calculation/range/dated_full_range',
                         __dir__)

require File.expand_path('../../../../../../' \
                         'lib/zakuro/context/context',
                         __dir__)

require File.expand_path('../../../../../../' \
                         'lib/zakuro/calculation/summary/western/specifier/multiple_day',
                         __dir__)

# rubocop:disable Metrics/BlockLength
describe 'Zakuro' do
  describe 'Calculation' do
    describe 'Summary' do
      describe 'Western' do
        describe 'Specifier' do
          describe 'MultipleDay' do
            describe '.get' do
              def pre(start_date:, last_date:)
                context = Zakuro::Context::Context.new(version: '')
                full_range = Zakuro::Calculation::Range::DatedFullRange.new(
                  context: context,
                  start_date: start_date,
                  last_date: last_date
                )

                Zakuro::Calculation::Summary::Western::Specifier::MultipleDay.get(
                  context: context, years: full_range.get, start_date: start_date, last_date: last_date
                )
              end
              context 'ancient month from western date 862-2-3' do
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
                context 'as 貞観4年1月' do
                  example '1日' do
                    date = Zakuro::Western::Calendar.new(year: 862, month: 2, day: 3)
                    actual = pre(start_date: date, last_date: date)

                    TestTools::Stringifier.eql?(
                      expected: [first_day],
                      actual: actual,
                      class_prefix: 'Zakuro::Result'
                    )
                  end

                  example '2日' do
                    date = Zakuro::Western::Calendar.new(year: 862, month: 2, day: 4)

                    second_day = first_day
                    second_day.instance_variable_set(
                      :@day,
                      Zakuro::Result::Data::Day.new(number: 2, zodiac_name: '辛未',
                                                    remainder: '7-1282', western_date: date.format)
                    )

                    actual = pre(start_date: date, last_date: date)

                    TestTools::Stringifier.eql?(
                      expected: [second_day],
                      actual: actual,
                      class_prefix: 'Zakuro::Result'
                    )
                  end
                end
              end
              context 'parameters to get several days' do
                context 'days of the month' do
                  context 'all days in a month' do
                    it 'should be same elements size' do
                      start_date = Zakuro::Western::Calendar.new(year: 445, month: 1, day: 24)
                      last_date = Zakuro::Western::Calendar.new(year: 445, month: 2, day: 22)

                      actual = pre(start_date: start_date, last_date: last_date)

                      expect(actual.size).to eq 30
                    end
                  end
                  context 'beyond next month' do
                    it 'should be same elements size' do
                      start_date = Zakuro::Western::Calendar.new(year: 445, month: 1, day: 25)
                      last_date = Zakuro::Western::Calendar.new(year: 445, month: 2, day: 23)

                      actual = pre(start_date: start_date, last_date: last_date)

                      expect(actual.size).to eq 30
                    end
                  end
                  context 'beyond next year' do
                    it 'should be same elements size' do
                      start_date = Zakuro::Western::Calendar.new(year: 446, month: 1, day: 14)
                      last_date = Zakuro::Western::Calendar.new(year: 446, month: 2, day: 12)

                      actual = pre(start_date: start_date, last_date: last_date)

                      expect(actual.size).to eq 30
                    end
                  end
                end
                context 'days of the year' do
                  context 'all days in a year' do
                    it 'should be same elements size' do
                      start_date = Zakuro::Western::Calendar.new(year: 445, month: 1, day: 24)
                      last_date = Zakuro::Western::Calendar.new(year: 446, month: 2, day: 11)

                      actual = pre(start_date: start_date, last_date: last_date)

                      expect(actual.size).to eq 384
                    end
                  end
                  context 'beyond next year' do
                    it 'should be same elements size' do
                      start_date = Zakuro::Western::Calendar.new(year: 445, month: 1, day: 25)
                      last_date = Zakuro::Western::Calendar.new(year: 446, month: 2, day: 12)

                      actual = pre(start_date: start_date, last_date: last_date)

                      expect(actual.size).to eq 384
                    end
                  end
                end
              end
            end
          end
        end
      end
    end
  end
end

# rubocop:enable Metrics/BlockLength
