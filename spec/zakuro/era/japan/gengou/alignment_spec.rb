# frozen_string_literal: true

require File.expand_path('../../../../../lib/zakuro/era/japan/gengou/alignment/linear_gengou',
                         __dir__)

require File.expand_path('../../../../../lib/zakuro/era/japan/gengou/alignment',
                         __dir__)

require File.expand_path('../../../../../lib/zakuro/era/western/calendar',
                         __dir__)

# rubocop:disable Metrics/BlockLength
describe 'Zakuro' do
  describe 'Japan' do
    describe 'Gengou' do
      describe 'Alignment' do
        describe '#get' do
          context 'only first gengou' do
            context 'parameters included a gengou' do
              let!(:start_date) do
                Zakuro::Western::Calendar.new(year: 445, month: 1, day: 24)
              end
              let!(:last_date) do
                Zakuro::Western::Calendar.new(year: 454, month: 2, day: 13)
              end

              let!(:actual) do
                Zakuro::Japan::Gengou::Alignment.get(
                  line: Zakuro::Japan::Gengou::Alignment::FIRST_LINE,
                  start_date: start_date, last_date: last_date
                )
              end

              it 'should be a element' do
                expect(actual.size).to eq 1
              end
              it 'should be valid gengou' do
                expect(actual[0].name).to eq '允恭天皇'
              end
            end
            context 'parameters included two gengou' do
              let!(:start_date) do
                Zakuro::Western::Calendar.new(year: 445, month: 1, day: 24)
              end
              let!(:last_date) do
                Zakuro::Western::Calendar.new(year: 454, month: 2, day: 14)
              end

              let!(:actual) do
                Zakuro::Japan::Gengou::Alignment.get(
                  line: Zakuro::Japan::Gengou::Alignment::FIRST_LINE,
                  start_date: start_date, last_date: last_date
                )
              end

              it 'should be two elements' do
                expect(actual.size).to eq 2
              end
              it 'should be valid gengou on first element' do
                expect(actual[0].name).to eq '允恭天皇'
              end
              it 'should be valid gengou on second element' do
                expect(actual[1].name).to eq '安康天皇'
              end
            end
          end
          context 'first gengou and second gengou' do
            context 'parameters included second gengou end' do
              let!(:start_date) do
                Zakuro::Western::Calendar.new(year: 1392, month: 11, day: 18)
              end
              let!(:last_date) do
                Zakuro::Western::Calendar.new(year: 1392, month: 11, day: 19)
              end

              let!(:actual) do
                Zakuro::Japan::Gengou::Alignment.get(
                  line: Zakuro::Japan::Gengou::Alignment::FIRST_LINE,
                  start_date: start_date, last_date: last_date
                )
              end

              it 'should be two elements' do
                expect(actual.size).to eq 2
              end
              it 'should be valid first element' do
                expect(actual[0].name).to eq '元中'
              end
              it 'should be valid second element' do
                expect(actual[1].name).to eq '明徳'
              end
            end
          end
        end
      end
    end
  end
end
# rubocop:enable Metrics/BlockLength
