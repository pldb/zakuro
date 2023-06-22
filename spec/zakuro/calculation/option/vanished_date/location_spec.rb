# frozen_string_literal: true

require File.expand_path('../../../../../lib/zakuro/calculation/option/vanished_date/location',
                         __dir__)

require File.expand_path('../../../../../lib/zakuro/context/context',
                         __dir__)

require File.expand_path('../../../../../lib/zakuro/version/senmyou/cycle/remainder',
                         __dir__)

# rubocop:disable Metrics/BlockLength
describe 'Zakuro' do
  describe 'Calculation' do
    describe 'Option' do
      describe 'VanishedDate' do
        describe 'Location' do
          let!(:context) do
            Zakuro::Context::Context.new(version: 'Senmyou')
          end
          describe '#existed?' do
            context 'averate remainder has vanished date' do
              it 'should be true' do
                vanished_date = Zakuro::Calculation::Option::VanishedDate::Location.new(
                  context: context,
                  average_remainder: Zakuro::Version::Senmyou::Cycle::Remainder.new(
                    day: 25, minute: 0, second: 0
                  )
                )
                expect(vanished_date.exist?).to be_truthy
              end
            end
            context 'a minimum remainder value has not vanished date' do
              it 'should be true' do
                vanished_date = Zakuro::Calculation::Option::VanishedDate::Location.new(
                  context: context,
                  average_remainder: Zakuro::Version::Senmyou::Cycle::Remainder.new(
                    day: 25, minute: 3943, second: 0
                  )
                )
                expect(vanished_date.exist?).to be_falsey
              end
            end
            context 'a maximum remainder value has vanished date' do
              it 'should be false' do
                vanished_date = Zakuro::Calculation::Option::VanishedDate::Location.new(
                  context: context,
                  average_remainder: Zakuro::Version::Senmyou::Cycle::Remainder.new(
                    day: 25, minute: 3942, second: 0
                  )
                )
                expect(vanished_date.exist?).to be_truthy
              end
            end
          end
          describe '#get' do
            context ' same paramters "長慶宣明暦算法"' do
              it 'should be same result' do
                vanished_date = Zakuro::Calculation::Option::VanishedDate::Location.new(
                  context: context,
                  average_remainder: Zakuro::Version::Senmyou::Cycle::Remainder.new(
                    day: 22, minute: 320, second: 0
                  )
                )
                expect(vanished_date.get.format).to eq '24-1714'
              end
            end
          end
        end
      end
    end
  end
end
# rubocop:enable Metrics/BlockLength
