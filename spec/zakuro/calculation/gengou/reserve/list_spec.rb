# frozen_string_literal: true

require File.expand_path('../../../../../lib/zakuro/calculation/gengou/reserve/list',
                         __dir__)

require File.expand_path('../../../../../lib/zakuro/era/western/calendar',
                         __dir__)

# rubocop:disable Metrics/BlockLength
describe 'Zakuro' do
  describe 'Calculation' do
    describe 'Gengou' do
      describe 'Reserve' do
        describe 'List' do
          context 'first line' do
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
              it 'should be target gengou' do
                list = Zakuro::Calculation::Gengou::Reserve::List.new(
                  method_name: :first_line,
                  start_date: Zakuro::Western::Calendar.new(year: 450, month: 1, day: 2),
                  end_date: Zakuro::Western::Calendar.new(year: 450, month: 1, day: 2)
                )
                actual = list.get
                expect(actual[0].name).to eq '允恭天皇'
              end
            end
            context 'western date has two gengou' do
              let(:list) do
                Zakuro::Calculation::Gengou::Reserve::List.new(
                  method_name: :first_line,
                  start_date: Zakuro::Western::Calendar.new(year: 454, month: 2, day: 13),
                  end_date: Zakuro::Western::Calendar.new(year: 454, month: 2, day: 14)
                )
              end
              it 'should be two elements in result array' do
                actual = list.get
                expect(actual.size).to eq 2
              end
              it 'should be a gengou to include start date' do
                actual = list.get
                expect(actual[0].name).to eq '允恭天皇'
              end
              it 'should be a gengou to include end date' do
                actual = list.get
                expect(actual[1].name).to eq '安康天皇'
              end
            end
            context 'western date has a gengou and previous gengou' do
              let(:list) do
                Zakuro::Calculation::Gengou::Reserve::List.new(
                  method_name: :first_line,
                  start_date: Zakuro::Western::Calendar.new(year: 454, month: 3, day: 13),
                  end_date: Zakuro::Western::Calendar.new(year: 454, month: 3, day: 13)
                )
              end
              it 'should be two elements in result array' do
                actual = list.get
                expect(actual.size).to eq 2
              end
              it 'should be a previous gengou' do
                actual = list.get
                expect(actual[0].name).to eq '允恭天皇'
              end
              it 'should be a gengou between start date and end date' do
                actual = list.get
                expect(actual[1].name).to eq '安康天皇'
              end
            end
            context 'western date has a gengou and next gengou' do
              let(:list) do
                Zakuro::Calculation::Gengou::Reserve::List.new(
                  method_name: :first_line,
                  start_date: Zakuro::Western::Calendar.new(year: 454, month: 1, day: 14),
                  end_date: Zakuro::Western::Calendar.new(year: 454, month: 1, day: 14)
                )
              end
              it 'should be two elements in result array' do
                actual = list.get
                expect(actual.size).to eq 2
              end
              it 'should be a gengou between start date and end date' do
                actual = list.get
                expect(actual[0].name).to eq '允恭天皇'
              end
              it 'should be a next gengou' do
                actual = list.get
                expect(actual[1].name).to eq '安康天皇'
              end
            end
          end
          context 'second line' do
            # TODO: more tests
          end
        end
      end
    end
  end
end
# rubocop:enable Metrics/BlockLength
