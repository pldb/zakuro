# frozen_string_literal: true

require File.expand_path('../../../../../../' \
                         'lib/zakuro/version/daien/cycle/remainder',
                         __dir__)

require File.expand_path('../../../../../../' \
                         'lib/zakuro/version/daien/stella/origin/average_november',
                         __dir__)
describe 'Zakuro' do
  describe 'Version' do
    describe 'Daien' do
      describe 'Origin' do
        describe 'AverageNovember' do
          describe '.calc_averaged_last_november_1st' do
            context 'valid western year as a parameter' do
              it 'should be changed a gihou remainder class' do
                actual = Zakuro::Version::Daien::Origin::AverageNovember.get(
                  western_year: 765
                )

                expect(actual.class).to eq Zakuro::Version::Daien::Cycle::Remainder
              end
            end
          end
        end
      end
    end
  end
end
