# frozen_string_literal: true

require File.expand_path('../../../../../../' \
                         'lib/zakuro/version/genka/cycle/remainder',
                         __dir__)

require File.expand_path('../../../../../../' \
                         'lib/zakuro/version/genka/stella/origin/january',
                         __dir__)
# rubocop:disable Metrics/BlockLength
describe 'Zakuro' do
  describe 'Version' do
    describe 'Genka' do
      describe 'Origin' do
        describe 'January' do
          describe '.get' do
            context 'valid western year as a parameter' do
              it 'should be changed a genka remainder class' do
                actual = Zakuro::Version::Genka::Origin::January.get(
                  western_year: 529
                )

                expect(actual.class).to eq Zakuro::Version::Genka::Cycle::Remainder
              end
            end
            context 'specified western year' do
              it 'should be returned a remainder value' do
                actual = Zakuro::Version::Genka::Origin::January.get(
                  western_year: 529
                )

                expect(actual.format).to eq '49.8936'
              end
            end
          end
        end
      end
    end
  end
end
# rubocop:enable Metrics/BlockLength
