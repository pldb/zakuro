# frozen_string_literal: true

require File.expand_path('../../../../lib/zakuro/calculation/option/dropped_date',
                         __dir__)

require File.expand_path('../../../../lib/zakuro/version/senmyou/const/remainder',
                         __dir__)

require File.expand_path('../../../../lib/zakuro/version/senmyou/const/number',
                         __dir__)

require File.expand_path('../../../../lib/zakuro/version/senmyou/cycle/solar_term',
                         __dir__)

# rubocop:disable Metrics/BlockLength
describe 'Zakuro' do
  describe 'Calculation' do
    describe 'Option' do
      describe 'DroppedDate' do
        def init(solar_term)
          limit = Zakuro::Senmyou::Const::Remainder::Solar::DROPPED_DATE_LIMIT
          year = Zakuro::Senmyou::Const::Number::Cycle::YEAR
          remainder_class = Zakuro::Senmyou::Cycle::DroppedRemainder

          Zakuro::Calculation::Option::DroppedDate.new(
            limit: limit, year: year, solar_term: solar_term, remainder_class: remainder_class
          )
        end
        describe '#existed?' do
          context 'solar term has dropped date' do
            it 'should be true' do
              dropped_date = init(
                Zakuro::Senmyou::Cycle::SolarTerm.new(
                  index: 3,
                  remainder: Zakuro::Senmyou::Cycle::Remainder.new(day: 56, minute: 8236, second: 0)
                )
              )
              expect(dropped_date.exist?).to be_truthy
            end
          end
          context 'a minimum remainder value on solar term has dropped date' do
            it 'should be true' do
              dropped_date = init(
                Zakuro::Senmyou::Cycle::SolarTerm.new(
                  index: 3,
                  remainder: Zakuro::Senmyou::Cycle::Remainder.new(day: 56, minute: 6564, second: 3)
                )
              )
              expect(dropped_date.exist?).to be_truthy
            end
          end
          context 'a maximum remainder value on solar term has not dropped date' do
            it 'should be false' do
              dropped_date = init(
                Zakuro::Senmyou::Cycle::SolarTerm.new(
                  index: 3,
                  remainder: Zakuro::Senmyou::Cycle::Remainder.new(day: 56, minute: 6564, second: 2)
                )
              )
              expect(dropped_date.exist?).to be_falsey
            end
          end
        end
        describe '#get' do
          context ' same paramters "長慶宣明暦算法"' do
            it 'should be same result' do
              dropped_date = init(
                Zakuro::Senmyou::Cycle::SolarTerm.new(
                  index: 3,
                  remainder: Zakuro::Senmyou::Cycle::Remainder.new(day: 56, minute: 8236, second: 7)
                )
              )
              expect(dropped_date.get.format).to eq '58-14670'
            end
          end
        end
      end
    end
  end
end
# rubocop:enable Metrics/BlockLength
