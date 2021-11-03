# frozen_string_literal: true

require File.expand_path('../../../../../lib/zakuro/calculation/gengou/reserve/list',
                         __dir__)

require File.expand_path('../../../../../lib/zakuro/era/western/calendar',
                         __dir__)

describe 'Zakuro' do
  describe 'Calculation' do
    describe 'Gengou' do
      describe 'Reserve' do
        describe 'List' do
          context 'western date has a gengou' do
            it 'should be a element in result array' do
              list = Zakuro::Calculation::Gengou::Reserve::List.new(
                method_name: :first_line,
                start_date: Zakuro::Western::Calendar.new(year: 450, month: 1, day: 2),
                end_date: Zakuro::Western::Calendar.new(year: 450, month: 1, day: 2)
              )
              actual = list.get
              expect(actual.size).to eq 1
            end
          end
          # TODO: more tests
        end
      end
    end
  end
end