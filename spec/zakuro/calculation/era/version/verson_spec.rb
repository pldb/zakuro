# frozen_string_literal: true

require File.expand_path('../../../../../' \
                         'lib/zakuro/era/japan/version',
                         __dir__)

require File.expand_path('../../../../../' \
                         'lib/zakuro/calculation/era/version/version',
                         __dir__)

# rubocop:disable Metrics/BlockLength

describe 'Zakuro' do
  describe 'Calculation' do
    describe 'Version' do
      describe '.get' do
        context 'year term include single version' do
          let!(:start_year) do
            446
          end
          let!(:end_year) do
            450
          end
          let!(:range) do
            Zakuro::Calculation::Version.get(start_year: start_year, end_year: end_year)
          end
          it 'should be a element' do
            expect(range.size).to eq 1
          end
          it 'should be same start_year as a parameter' do
            expect(range[0].start_year).to eq start_year
          end
          it 'should be same end_year as a parameter' do
            expect(range[0].end_year).to eq end_year
          end
        end
        context 'year term include multiple versions' do
          let!(:start_year) do
            696
          end
          let!(:end_year) do
            700
          end
          let!(:range) do
            Zakuro::Calculation::Version.get(start_year: start_year, end_year: end_year)
          end
          it 'should be two elements' do
            expect(range.size).to eq 2
          end
          it 'should be same start_year as a parameter' do
            expect(range[0].start_year).to eq start_year
          end
          it 'should be same end_year as a version' do
            expect(range[0].end_year).to eq Zakuro::Japan::Version::LIST[0].end_year
          end
          it 'should be same start_year as a version' do
            expect(range[1].start_year).to eq Zakuro::Japan::Version::LIST[1].start_year
          end
          it 'should be same end_year as a parameter' do
            expect(range[1].end_year).to eq end_year
          end
        end
      end
    end
  end
end

# rubocop:enable Metrics/BlockLength
