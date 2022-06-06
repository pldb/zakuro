# frozen_string_literal: true

require File.expand_path('../../../../../lib/zakuro/calculation/option/dropped_date/location',
                         __dir__)

require File.expand_path('../../../../../lib/zakuro/context/context',
                         __dir__)

require File.expand_path('../../../../../lib/zakuro/version/senmyou/cycle/solar_term',
                         __dir__)

# rubocop:disable Metrics/BlockLength
describe 'Zakuro' do
  describe 'Calculation' do
    describe 'Option' do
      describe 'DroppedDate' do
        describe 'Location' do
          let!(:context) do
            Zakuro::Context::Context.new(version: 'Senmyou')
          end
          describe '#existed?' do
            context 'solar term has dropped date' do
              it 'should be true' do
                dropped_date = Zakuro::Calculation::Option::DroppedDate::Location.new(
                  context: context,
                  solar_term: Zakuro::Senmyou::Cycle::SolarTerm.new(
                    index: 3,
                    remainder: Zakuro::Senmyou::Cycle::Remainder.new(
                      day: 56, minute: 8236, second: 0
                    )
                  )
                )
                expect(dropped_date.exist?).to be_truthy
              end
            end
            context 'a minimum remainder value on solar term has dropped date' do
              it 'should be true' do
                dropped_date = Zakuro::Calculation::Option::DroppedDate::Location.new(
                  context: context,
                  solar_term: Zakuro::Senmyou::Cycle::SolarTerm.new(
                    index: 3,
                    remainder: Zakuro::Senmyou::Cycle::Remainder.new(
                      day: 56, minute: 6564, second: 3
                    )
                  )
                )
                expect(dropped_date.exist?).to be_truthy
              end
            end
            context 'a maximum remainder value on solar term has not dropped date' do
              it 'should be false' do
                dropped_date = Zakuro::Calculation::Option::DroppedDate::Location.new(
                  context: context,
                  solar_term: Zakuro::Senmyou::Cycle::SolarTerm.new(
                    index: 3,
                    remainder: Zakuro::Senmyou::Cycle::Remainder.new(
                      day: 56, minute: 6564, second: 2
                    )
                  )
                )
                expect(dropped_date.exist?).to be_falsey
              end
            end
          end
          describe '#get' do
            context ' same paramters "長慶宣明暦算法"' do
              it 'should be same result' do
                dropped_date = Zakuro::Calculation::Option::DroppedDate::Location.new(
                  context: context,
                  solar_term: Zakuro::Senmyou::Cycle::SolarTerm.new(
                    index: 3,
                    remainder: Zakuro::Senmyou::Cycle::Remainder.new(
                      day: 56, minute: 8236, second: 7
                    )
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
end
# rubocop:enable Metrics/BlockLength
