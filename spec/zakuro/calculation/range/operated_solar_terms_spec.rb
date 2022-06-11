# frozen_string_literal: true

require File.expand_path('../../../testtools/stringifier', __dir__)

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
      describe 'OperatedSolarTerms' do
        describe '.get' do
          # :reek:UtilityFunction
          def create_operated_solar_terms(western_date: Zakuro::Western::Calendar.new)
            full_range = Zakuro::Calculation::Range::DatedFullRange.new(
              context: Zakuro::Context::Context.new(version: 'Senmyou'),
              start_date: western_date
            )
            operated_solar_terms = Zakuro::Calculation::Range::OperatedSolarTerms.new(
              context: Zakuro::Context::Context.new(version: 'Senmyou'),
              years: full_range.get
            )
            operated_solar_terms.create

            operated_solar_terms
          end

          context 'specified solar term' do
            it 'should invalid at 1002-01-16' do
              western_date = Zakuro::Western::Calendar.new(year: 1002, month: 1, day: 16)

              operated_solar_terms = create_operated_solar_terms(western_date: western_date)

              matched, solar_term = operated_solar_terms.get(western_date: western_date)

              expect(matched).to eq true

              TestTools::Stringifier.eql?(
                expected: Zakuro::Senmyou::Cycle::SolarTerm.new(index: 2),
                actual: solar_term,
                class_prefix: 'Zakuro::Senmyou'
              )
            end

            it 'should valid at 1001-12-18' do
              western_date = Zakuro::Western::Calendar.new(year: 1001, month: 12, day: 18)

              operated_solar_terms = create_operated_solar_terms(western_date: western_date)

              matched, solar_term = operated_solar_terms.get(western_date: western_date)

              expect(matched).to eq true

              TestTools::Stringifier.eql?(
                expected: Zakuro::Senmyou::Cycle::SolarTerm.new(
                  index: 2,
                  remainder: Zakuro::Senmyou::Cycle::Remainder.new(day: 3, minute: 1961, second: 0)
                ),
                actual: solar_term,
                class_prefix: 'Zakuro::Senmyou'
              )
            end
          end
        end
      end
    end
  end
end
# rubocop:enable Metrics/BlockLength
