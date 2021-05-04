# frozen_string_literal: true

require File.expand_path('../../../../../' \
                         'lib/zakuro/version/gihou/cycle/remainder',
                         __dir__)

require File.expand_path('../../../../../' \
                         'lib/zakuro/version/gihou/stella/winter_solstice',
                         __dir__)
describe 'Zakuro' do
  describe 'Gihou' do
    describe 'WinterSolstice' do
      describe '.calc_averaged_last_november_1st' do
        context 'valid western year as a parameter' do
          it 'should be changed a gihou remainder class' do
            actual = Zakuro::Gihou::WinterSolstice.calc_averaged_last_november_1st(
              western_year: 702
            )

            expect(actual.class).to eq Zakuro::Gihou::Cycle::Remainder
          end
        end
      end
    end
  end
end
