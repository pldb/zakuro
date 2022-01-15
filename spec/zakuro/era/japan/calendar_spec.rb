# frozen_string_literal: true

require 'date'
require File.expand_path('../../../../../zakuro/lib/zakuro/era/japan/calendar',
                         __dir__)

# rubocop:disable Metrics/BlockLength
describe 'Zakuro' do
  describe 'Japan' do
    describe 'Calendar' do
      describe '.parse' do
        context 'japan date text' do
          let!(:leaped) do
            '元中04年閏05月01日'
          end
          it 'is parsed gengou' do
            expect(
              Zakuro::Japan::Calendar.parse(text: leaped).gengou
            ).to eq '元中'
          end
          it 'is parsed year' do
            expect(
              Zakuro::Japan::Calendar.parse(text: leaped).year
            ).to eq 4
          end
          it 'is parsed month leap' do
            expect(
              Zakuro::Japan::Calendar.parse(text: leaped).leaped
            ).to eq true
          end
          it 'is parsed month' do
            expect(
              Zakuro::Japan::Calendar.parse(text: leaped).month
            ).to eq 5
          end
          it 'is parsed day' do
            expect(
              Zakuro::Japan::Calendar.parse(text: leaped).day
            ).to eq 1
          end
        end
        context 'japan date text without leap' do
          let!(:not_leaped) do
            '元中04年06月01日'
          end
          it 'is parsed month leap' do
            expect(
              Zakuro::Japan::Calendar.parse(text: not_leaped).leaped
            ).to eq false
          end
        end
      end
      describe '#format' do
        let!(:leaped) do
          '元中04年閏05月01日'
        end
        context 'japan date text' do
          it 'should be formatted' do
            expect(
              Zakuro::Japan::Calendar.parse(text: leaped).format
            ).to eq leaped
          end
        end
      end
    end
  end
end
# rubocop:enable Metrics/BlockLength
