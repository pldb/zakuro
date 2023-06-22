# frozen_string_literal: true

require File.expand_path('../../../../../testtool/stringifier',
                         __dir__)

require File.expand_path('../../../../../../' \
                         'lib/zakuro/calculation/range/named_full_range',
                         __dir__)

require File.expand_path('../../../../../../' \
                         'lib/zakuro/context/context',
                         __dir__)

require File.expand_path('../../../../../../' \
                         'lib/zakuro/calculation/summary/japan/specifier/single_day',
                         __dir__)

# rubocop:disable Metrics/BlockLength
describe 'Zakuro' do
  describe 'Calculation' do
    describe 'Summary' do
      describe 'Japan' do
        describe 'Specifier' do
          describe 'SingleDay' do
            # :reek:UnityFunction
            def eql?(date:, result:)
              context = Zakuro::Context::Context.new(version: 'Senmyou')
              full_range = Zakuro::Calculation::Range::NamedFullRange.new(
                context: context, start_name: date.gengou
              )
              expected = Zakuro::Calculation::Summary::Japan::Specifier::SingleDay.get(
                years: full_range.get, date: date
              )

              Zakuro::TestTool::Stringifier.eql?(
                expected: result,
                actual: expected,
                class_prefix: 'Zakuro::Result'
              )
            end

            describe '.get' do
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
                    date = Zakuro::Japan::Calendar.parse(text: '貞観4年1月1日')

                    eql?(date: date, result: first_day)
                  end
                  example '2日' do
                    date = Zakuro::Japan::Calendar.parse(text: '貞観4年1月2日')

                    second_day = first_day
                    second_day.instance_variable_set(
                      :@day,
                      Zakuro::Result::Data::Day.new(
                        number: 2, zodiac_name: '辛未', remainder: '7-1282',
                        western_date: '0862-02-04'
                      )
                    )

                    eql?(date: date, result: second_day)
                  end
                end
              end
              context 'ancient month from western date 878-2-6' do
                let!(:first_day) do
                  Zakuro::Result::Data::SingleDay.new(
                    year: Zakuro::Result::Data::Year.new(
                      first_gengou: Zakuro::Result::Data::Gengou.new(name: '元慶', number: 2),
                      second_gengou: Zakuro::Result::Data::Gengou.new(name: '', number: -1),
                      zodiac_name: '戊戌',
                      total_days: 354
                    ),
                    month: Zakuro::Result::Data::Month.new(
                      number: 1,
                      leaped: false,
                      days_name: '大',
                      first_day: Zakuro::Result::Data::Day.new(
                        number: 1, zodiac_name: '丁酉', remainder: '33-4182',
                        western_date: '0878-02-06'
                      ),
                      odd_solar_terms: [
                        Zakuro::Result::Data::SolarTerm.new(
                          index: 5, remainder: '58-4648'
                        )
                      ],
                      even_solar_terms: [
                        Zakuro::Result::Data::SolarTerm.new(
                          index: 4, remainder: '43-2812'
                        )
                      ]
                    ),
                    day: Zakuro::Result::Data::Day.new(
                      number: 1, zodiac_name: '丁酉', remainder: '33-4182',
                      western_date: '0878-02-06'
                    )
                  )
                end
                context 'as 元慶2年1月' do
                  example '1日' do
                    date = Zakuro::Japan::Calendar.parse(text: '元慶2年1月1日')

                    eql?(date: date, result: first_day)
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
