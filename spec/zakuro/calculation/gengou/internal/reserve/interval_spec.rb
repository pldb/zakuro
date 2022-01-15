# frozen_string_literal: true

require File.expand_path('../../../../../../' \
                         'lib/zakuro/calculation/gengou/internal/reserve/interval',
                         __dir__)

require File.expand_path('../../../../../../lib/zakuro/era/western/calendar',
                         __dir__)

describe 'Zakuro' do
  describe 'Calculation' do
    describe 'Gengou' do
      describe 'Reserve' do
        describe 'Interval' do
          describe '#start_western_year' do
            context 'western date has a gengou' do
              it 'should be start year from target gengou' do
                interval = Zakuro::Calculation::Gengou::Reserve::Interval.new(
                  start_date: Zakuro::Western::Calendar.new(year: 450, month: 1, day: 2),
                  end_date: Zakuro::Western::Calendar.new(year: 450, month: 1, day: 2)
                )
                actual = interval.western_start_year
                expect(actual).to eq 445
              end
            end
          end
        end
      end
    end
  end
end
