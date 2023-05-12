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
          let!(:last_year) do
            450
          end
          let!(:range) do
            Zakuro::Calculation::Version.get(start_year: start_year, last_year: last_year)
          end
          it 'should be a element' do
            expect(range.size).to eq 1
          end
          it 'should be same start_year as a parameter' do
            expect(range[0].start_year).to eq start_year
          end
          it 'should be same last_year as a parameter' do
            expect(range[0].last_year).to eq last_year
          end
        end
        context 'year term include multiple versions' do
          let!(:start_year) do
            696
          end
          let!(:last_year) do
            700
          end
          let!(:range) do
            Zakuro::Calculation::Version.get(start_year: start_year, last_year: last_year)
          end
          it 'should be two elements' do
            expect(range.size).to eq 2
          end
          it 'should be same start_year as a parameter' do
            expect(range[0].start_year).to eq start_year
          end
          it 'should be same last_year as a version' do
            expect(range[0].last_year).to eq Zakuro::Japan::Version::Resource::LIST[0].last_year
          end
          it 'should be same start_year as a version' do
            start_year = Zakuro::Japan::Version::Resource::LIST[1].start_year.western
            expect(range[1].start_year).to eq start_year
          end
          it 'should be same last_year as a parameter' do
            expect(range[1].last_year).to eq last_year
          end
        end
      end
    end
  end
end

# rubocop:enable Metrics/BlockLength
