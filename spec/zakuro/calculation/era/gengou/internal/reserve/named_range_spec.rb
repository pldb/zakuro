# frozen_string_literal: true

require File.expand_path('../../../../../../../' \
                         'lib/zakuro/calculation/era/gengou/internal/reserve/named_range',
                         __dir__)

require File.expand_path('../../../../../../../lib/zakuro/era/western/calendar',
                         __dir__)

describe 'Zakuro' do
  describe 'Calculation' do
    describe 'Gengou' do
      describe 'Reserve' do
        describe 'NamedRange' do
          describe '#start_western_year' do
            context 'japan gengou name has a gengou' do
              it 'should be start year from target gengou' do
                range = Zakuro::Calculation::Gengou::Reserve::NamedRange.new(
                  start_name: '清寧天皇',
                  last_name: '清寧天皇'
                )
                actual = range.western_start_year
                expect(actual).to eq 454
              end
            end
          end
        end
      end
    end
  end
end
