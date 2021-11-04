# frozen_string_literal: true

require File.expand_path('../../../../../lib/zakuro/calculation/gengou/reserve/interval',
                         __dir__)

require File.expand_path('../../../../../lib/zakuro/era/western/calendar',
                         __dir__)

describe 'Zakuro' do
  describe 'Calculation' do
    describe 'Gengou' do
      describe 'Reserve' do
        describe 'Interval' do
          describe '#start_western_year' do
            context 'empty initialized parameters' do
              it 'should be invalid year' do
                interval = Zakuro::Calculation::Gengou::Reserve::Interval.new(
                  first_gengou_list: [],
                  second_gengou_list: []
                )
                actual = interval.start_western_year
                expect(actual).to eq(-1)
              end
            end
            # TODO: more tests
          end
        end
      end
    end
  end
end
