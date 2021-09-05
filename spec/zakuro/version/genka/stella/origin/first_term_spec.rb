# frozen_string_literal: true

require File.expand_path('../../../../../../' \
                         'lib/zakuro/version/genka/cycle/remainder',
                         __dir__)

require File.expand_path('../../../../../../' \
                         'lib/zakuro/version/genka/stella/origin/first_term',
                         __dir__)
describe 'Zakuro' do
  describe 'Genka' do
    describe 'Origin' do
      describe 'FirstTerm' do
        describe '.get' do
          context 'valid western year as a parameter' do
            it 'should be changed a genka remainder class' do
              actual = Zakuro::Genka::Origin::FirstTerm.get(
                western_year: 529
              )

              expect(actual.class).to eq Zakuro::Genka::Cycle::TermRemainder
            end
          end
        end
      end
    end
  end
end
