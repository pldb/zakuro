# frozen_string_literal: true

require File.expand_path('../../../../../zakuro/lib/zakuro/era/japan/version',
                         __dir__)
require 'yaml'

describe 'Zakuro' do
  describe 'Japan' do
    describe 'Version' do
      describe '.ranges_with_year' do
        context 'valid parameter has versions' do
          it 'should not be empty result' do
            start_year = 445
            last_year = 445
            actual = Zakuro::Japan::Version.ranges_with_year(start_year: start_year, last_year: last_year)
            expect(actual.size).to eq 1
          end
        end
      end
    end
  end
end
