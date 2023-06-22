# frozen_string_literal: true

require File.expand_path('../../../testtool/stringifier', __dir__)

require File.expand_path('../../../../' \
                        'lib/zakuro/era/western/calendar',
                         __dir__)

require File.expand_path('../../../../' \
                         'lib/zakuro/context/context',
                         __dir__)

require File.expand_path('../../../../' \
                        'lib/zakuro/calculation/monthly/month',
                         __dir__)

require File.expand_path('../../../../' \
                         'lib/zakuro/calculation/range/dated_operation_range',
                         __dir__)

require File.expand_path('../../../../' \
                        'lib/zakuro/calculation/range/dated_full_range',
                         __dir__)

# rubocop:disable Metrics/BlockLength

describe 'Zakuro' do
  describe 'Calculation' do
    describe 'Range' do
      describe 'OperatedSolarTerm' do
        describe '.get' do
          # :reek:UtilityFunction
          def create_operated_solar_term(western_date: Zakuro::Western::Calendar.new)
            full_range = Zakuro::Calculation::Range::DatedFullRange.new(
              context: Zakuro::Context::Context.new(version: 'Senmyou'),
              start_date: western_date
            )
            operated_solar_term = Zakuro::Calculation::Range::OperatedSolarTerm.new(
              context: Zakuro::Context::Context.new(version: 'Senmyou'),
              years: full_range.get
            )
            operated_solar_term.create

            operated_solar_term
          end

          context 'specified solar term' do
            it 'should invalid at 1002-01-16' do
              western_date = Zakuro::Western::Calendar.new(year: 1002, month: 1, day: 16)

              operated_solar_term = create_operated_solar_term(western_date: western_date)

              matched, solar_term = operated_solar_term.get(western_date: western_date)

              expect(matched).to eq true

              Zakuro::TestTool::Stringifier.eql?(
                expected: Zakuro::Version::Senmyou::Cycle::SolarTerm.new(index: 2),
                actual: solar_term,
                class_prefix: 'Zakuro::Version::Senmyou'
              )
            end

            it 'should valid at 1001-12-18' do
              western_date = Zakuro::Western::Calendar.new(year: 1001, month: 12, day: 18)

              operated_solar_term = create_operated_solar_term(western_date: western_date)

              matched, solar_term = operated_solar_term.get(western_date: western_date)

              expect(matched).to eq true

              Zakuro::TestTool::Stringifier.eql?(
                expected: Zakuro::Version::Senmyou::Cycle::SolarTerm.new(
                  index: 2,
                  remainder: Zakuro::Version::Senmyou::Cycle::Remainder.new(
                    day: 3, minute: 1961, second: 0
                  )
                ),
                actual: solar_term,
                class_prefix: 'Zakuro::Version::Senmyou'
              )
            end

            # 閏10月 -> 11月（中気の冬至移動）
            it 'should valid at 1050-12-16' do
              western_date = Zakuro::Western::Calendar.new(year: 1050, month: 12, day: 17)

              operated_solar_term = create_operated_solar_term(western_date: western_date)

              matched, solar_term = operated_solar_term.get(western_date: western_date)

              expect(matched).to eq true

              Zakuro::TestTool::Stringifier.eql?(
                expected: Zakuro::Version::Senmyou::Cycle::SolarTerm.new(
                  index: 0,
                  remainder: Zakuro::Version::Senmyou::Cycle::Remainder.new(
                    day: 49, minute: 6585, second: 0
                  )
                ),
                actual: solar_term,
                class_prefix: 'Zakuro::Version::Senmyou'
              )
            end
          end
        end
      end
    end
  end
end
# rubocop:enable Metrics/BlockLength
