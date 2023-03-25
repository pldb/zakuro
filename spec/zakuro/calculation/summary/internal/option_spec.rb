# frozen_string_literal: true

require File.expand_path('../../../../../' \
                         'lib/zakuro/context/context',
                         __dir__)

require File.expand_path('../../../../../' \
                         'lib/zakuro/calculation/summary/internal/option',
                         __dir__)

require File.expand_path('../../../../../' \
                         'lib/zakuro/calculation/base/day',
                         __dir__)

require File.expand_path('../../../../../' \
                         'lib/zakuro/calculation/monthly/month',
                         __dir__)

# rubocop:disable Metrics/BlockLength
describe 'Zakuro' do
  describe 'Calculation' do
    describe 'Summary' do
      describe 'Option' do
        describe '.create' do
          context 'no option key' do
            it 'should be empty result' do
              options = {}
              context = Zakuro::Context::Context.new(options: options)

              month = Zakuro::Calculation::Monthly::Month.new(context: context)
              day = Zakuro::Calculation::Base::Day.new
              actual = Zakuro::Calculation::Summary::Option.create(
                month: month, day: day
              )
              expect(actual.size).to eq 0
            end
          end
          context 'dropped_date option key' do
            context 'parameter with empty solar terms' do
              let!(:actual) do
                options = {
                  'dropped_date' => true
                }
                context = Zakuro::Context::Context.new(version: 'Senmyou', options: options)

                month = Zakuro::Calculation::Monthly::Month.new(context: context)
                day = Zakuro::Calculation::Base::Day.new
                Zakuro::Calculation::Summary::Option.create(
                  month: month, day: day
                )
              end
              it 'should be a result' do
                expect(actual.size).to eq 1
              end
              it 'should be unmatched' do
                expect(actual['dropped_date'].matched).to be_falsey
              end
            end
            context 'parameter with valid solar terms' do
              let!(:solar_terms) do
                [
                  Zakuro::Senmyou::Cycle::SolarTerm.new(
                    index: 1,
                    remainder: Zakuro::Senmyou::Cycle::Remainder.new(
                      day: 15, minute: 0, second: 0
                    )
                  ),
                  Zakuro::Senmyou::Cycle::SolarTerm.new(
                    index: 2,
                    remainder: Zakuro::Senmyou::Cycle::Remainder.new(
                      day: 30, minute: 0, second: 0
                    )
                  )
                ]
              end
              let!(:all_solar_terms) do
                [
                  Zakuro::Senmyou::Cycle::SolarTerm.new(
                    index: 0,
                    remainder: Zakuro::Senmyou::Cycle::Remainder.new(
                      day: 0, minute: 8236, second: 7
                    )
                  ),
                  Zakuro::Senmyou::Cycle::SolarTerm.new(
                    index: 1,
                    remainder: Zakuro::Senmyou::Cycle::Remainder.new(
                      day: 15, minute: 0, second: 0
                    )
                  ),
                  Zakuro::Senmyou::Cycle::SolarTerm.new(
                    index: 2,
                    remainder: Zakuro::Senmyou::Cycle::Remainder.new(
                      day: 30, minute: 0, second: 0
                    )
                  )
                ]
              end
              let!(:actual) do
                options = {
                  'dropped_date' => true
                }
                context = Zakuro::Context::Context.new(version: 'Senmyou', options: options)

                month = Zakuro::Calculation::Monthly::Month.new(
                  context: context,
                  month_label: Zakuro::Calculation::Monthly::MonthLabel.new(
                    number: 1, is_many_days: false, leaped: false
                  ),
                  first_day: Zakuro::Calculation::Monthly::FirstDay.new(
                    western_date: Zakuro::Western::Calendar.new(year: 450, month: 1, day: 1),
                    remainder: Zakuro::Senmyou::Cycle::Remainder.new
                  ),
                  solar_terms: solar_terms,
                  meta: Zakuro::Calculation::Monthly::Meta.new(all_solar_terms: all_solar_terms)
                )
                day = Zakuro::Calculation::Base::Day.new(
                  number: 1,
                  western_date: Zakuro::Western::Calendar.new(year: 1000, month: 1, day: 1),
                  remainder: Zakuro::Senmyou::Cycle::Remainder.new(
                    day: 2, minute: 1000, second: 0
                  )
                )
                Zakuro::Calculation::Summary::Option.create(
                  month: month, day: day
                )
              end
              it 'should be a result' do
                expect(actual.size).to eq 1
              end
              it 'should be matched' do
                option = actual['dropped_date']
                expect(option.matched).to be_truthy
              end
              it 'should be calculated dropped date remainder' do
                remainder = actual['dropped_date'].calculation.remainder
                expect(remainder).to eq '2-14670'
              end
              it 'should be a solar term index have dropped date' do
                solar_term = actual['dropped_date'].calculation.solar_term
                expect(solar_term.index).to eq all_solar_terms[0].index
              end
              it 'should be a solar term remainder have dropped date' do
                solar_term = actual['dropped_date'].calculation.solar_term
                expect(solar_term.remainder).to eq all_solar_terms[0].remainder.format
              end
            end
          end

          context 'vanished_date option key' do
            context 'parameter with empty average remainder' do
              let!(:actual) do
                options = {
                  'vanished_date' => true
                }
                context = Zakuro::Context::Context.new(options: options)

                month = Zakuro::Calculation::Monthly::Month.new(context: context)
                day = Zakuro::Calculation::Base::Day.new
                Zakuro::Calculation::Summary::Option.create(
                  month: month, day: day
                )
              end
              it 'should be a result' do
                expect(actual.size).to eq 1
              end
              it 'should be unmatched' do
                expect(actual['vanished_date'].matched).to be_falsey
              end
            end
            context 'parameter with valid average remainder' do
              let!(:actual) do
                options = {
                  'vanished_date' => true
                }
                context = Zakuro::Context::Context.new(version: 'Senmyou', options: options)

                month = Zakuro::Calculation::Monthly::Month.new(
                  context: context,
                  month_label: Zakuro::Calculation::Monthly::MonthLabel.new(
                    number: 1, is_many_days: false, leaped: false
                  ),
                  first_day: Zakuro::Calculation::Monthly::FirstDay.new(
                    western_date: Zakuro::Western::Calendar.new(year: 450, month: 1, day: 1),
                    remainder: Zakuro::Senmyou::Cycle::Remainder.new,
                    average_remainder: Zakuro::Senmyou::Cycle::Remainder.new(
                      day: 22, minute: 320, second: 0
                    )
                  ),
                  solar_terms: []
                )
                day = Zakuro::Calculation::Base::Day.new(
                  number: 1,
                  western_date: Zakuro::Western::Calendar.new(year: 1000, month: 1, day: 1),
                  # 大余は滅余の計算結果（24-1714）の大余と一致させる
                  remainder: Zakuro::Senmyou::Cycle::Remainder.new(
                    day: 24, minute: 1000, second: 0
                  )
                )
                Zakuro::Calculation::Summary::Option.create(
                  month: month, day: day
                )
              end
              it 'should be a result' do
                expect(actual.size).to eq 1
              end
              it 'should be matched' do
                option = actual['vanished_date']
                expect(option.matched).to be_truthy
              end
              it 'should be calculated vanished date remainder' do
                remainder = actual['vanished_date'].calculation.remainder
                expect(remainder).to eq '24-1714'
              end
            end
          end
        end
      end
    end
  end
end
# rubocop:enable Metrics/BlockLength
