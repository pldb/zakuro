# frozen_string_literal: true

require File.expand_path('../../../../../../lib/zakuro/calculation/era/gengou/internal/reserve',
                         __dir__)

require File.expand_path('../../../../../../lib/zakuro/era/western/calendar',
                         __dir__)

# rubocop:disable Metrics/BlockLength
describe 'Zakuro' do
  describe 'Calculation' do
    describe 'Gengou' do
      describe 'Reserve' do
        describe '.get' do
          context 'western date has a gengou' do
            let!(:start_date) do
              Zakuro::Western::Calendar.new(year: 450, month: 1, day: 2)
            end
            let!(:last_date) do
              Zakuro::Western::Calendar.new(year: 450, month: 1, day: 2)
            end
            let!(:range) do
              Zakuro::Calculation::Gengou::Reserve.get(
                start_date: start_date, last_date: last_date
              )
            end
            it 'should be start year from target gengou' do
              actual = range.western_start_year
              expect(actual).to eq 445
            end
            it 'should be included target gengou' do
              actual = range.collect_first(
                start_date: start_date, last_date: last_date
              )
              expect(actual[0].name).to eq '允恭天皇'
            end
          end
          context 'western date has two gengou' do
            let!(:start_date) do
              Zakuro::Western::Calendar.new(year: 454, month: 2, day: 13)
            end
            let!(:last_date) do
              Zakuro::Western::Calendar.new(year: 454, month: 2, day: 14)
            end
            let!(:range) do
              Zakuro::Calculation::Gengou::Reserve.get(
                start_date: start_date, last_date: last_date
              )
            end
            it 'should be start year from target gengou' do
              actual = range.western_start_year
              expect(actual).to eq 445
            end
            it 'should be target gengou on first element' do
              actual = range.collect_first(
                start_date: start_date, last_date: last_date
              )
              expect(actual[0].name).to eq '允恭天皇'
            end
            it 'should be target gengou on second element' do
              actual = range.collect_first(
                start_date: start_date, last_date: last_date
              )
              expect(actual[1].name).to eq '安康天皇'
            end
          end
        end
      end
    end
  end
end
# rubocop:enable Metrics/BlockLength
