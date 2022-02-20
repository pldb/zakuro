# frozen_string_literal: true

require File.expand_path('../../../../../../lib/zakuro/era/japan/gengou/alignment/linear_gengou',
                         __dir__)

require File.expand_path('../../../../../../lib/zakuro/era/western/calendar',
                         __dir__)

# rubocop:disable Metrics/BlockLength
describe 'Zakuro' do
  describe 'Japan' do
    describe 'Alignment' do
      describe 'LinearGengou' do
        let!(:gengou) do
          Zakuro::Japan::Alignment::LinearGengou.new(
            start_date: Zakuro::Western::Calendar.new(year: 1000, month: 1, day: 1),
            last_date: Zakuro::Western::Calendar.new(year: 1000, month: 2, day: 3)
          )
        end
        describe '#in?' do
          context 'parameters to be in gengou range' do
            example 'same range' do
              actual = gengou.in?(
                start_date: Zakuro::Western::Calendar.new(year: 1000, month: 1, day: 1),
                last_date: Zakuro::Western::Calendar.new(year: 1000, month: 2, day: 3)
              )
              expect(actual).to be_truthy
            end
            example 'narrow range' do
              actual = gengou.in?(
                start_date: Zakuro::Western::Calendar.new(year: 1000, month: 1, day: 2),
                last_date: Zakuro::Western::Calendar.new(year: 1000, month: 2, day: 2)
              )
              expect(actual).to be_truthy
            end
          end
          context 'parameters to be out of gengou range' do
            example 'wide range' do
              actual = gengou.in?(
                start_date: Zakuro::Western::Calendar.new(year: 999, month: 12, day: 31),
                last_date: Zakuro::Western::Calendar.new(year: 1000, month: 2, day: 4)
              )
              expect(actual).to be_falsey
            end
            example 'wide range on start date' do
              actual = gengou.in?(
                start_date: Zakuro::Western::Calendar.new(year: 999, month: 12, day: 31),
                last_date: Zakuro::Western::Calendar.new(year: 1000, month: 2, day: 2)
              )
              expect(actual).to be_falsey
            end
            example 'wide range on last date' do
              actual = gengou.in?(
                start_date: Zakuro::Western::Calendar.new(year: 1000, month: 1, day: 2),
                last_date: Zakuro::Western::Calendar.new(year: 1000, month: 2, day: 4)
              )
              expect(actual).to be_falsey
            end
          end
        end
        describe '#out?' do
          context 'parameters to be in gengou range' do
            example 'same range' do
              actual = gengou.out?(
                start_date: Zakuro::Western::Calendar.new(year: 1000, month: 1, day: 1),
                last_date: Zakuro::Western::Calendar.new(year: 1000, month: 2, day: 3)
              )
              expect(actual).to be_falsey
            end
            example 'narrow range' do
              actual = gengou.out?(
                start_date: Zakuro::Western::Calendar.new(year: 1000, month: 1, day: 2),
                last_date: Zakuro::Western::Calendar.new(year: 1000, month: 2, day: 2)
              )
              expect(actual).to be_falsey
            end
          end
          context 'parameters to be out of gengou range' do
            example 'overwrapped range' do
              actual = gengou.out?(
                start_date: Zakuro::Western::Calendar.new(year: 999, month: 12, day: 31),
                last_date: Zakuro::Western::Calendar.new(year: 1000, month: 2, day: 4)
              )
              expect(actual).to be_falsey
            end
            example 'overwrapped range on start date' do
              actual = gengou.out?(
                start_date: Zakuro::Western::Calendar.new(year: 999, month: 12, day: 31),
                last_date: Zakuro::Western::Calendar.new(year: 1000, month: 2, day: 2)
              )
              expect(actual).to be_falsey
            end
            example 'overwrapped range on last date' do
              actual = gengou.out?(
                start_date: Zakuro::Western::Calendar.new(year: 1000, month: 1, day: 2),
                last_date: Zakuro::Western::Calendar.new(year: 1000, month: 2, day: 4)
              )
              expect(actual).to be_falsey
            end
            example 'completely out range less than start date' do
              actual = gengou.out?(
                start_date: Zakuro::Western::Calendar.new(year: 999, month: 12, day: 2),
                last_date: Zakuro::Western::Calendar.new(year: 999, month: 12, day: 31)
              )
              expect(actual).to be_truthy
            end
            example 'completely out range more than last date' do
              actual = gengou.out?(
                start_date: Zakuro::Western::Calendar.new(year: 1000, month: 2, day: 4),
                last_date: Zakuro::Western::Calendar.new(year: 1000, month: 3, day: 2)
              )
              expect(actual).to be_truthy
            end
          end
        end
        describe '#covered?' do
          context 'parameters to be in gengou range' do
            example 'same range' do
              actual = gengou.covered?(
                start_date: Zakuro::Western::Calendar.new(year: 1000, month: 1, day: 1),
                last_date: Zakuro::Western::Calendar.new(year: 1000, month: 2, day: 3)
              )
              expect(actual).to be_falsey
            end
            example 'narrow range' do
              actual = gengou.covered?(
                start_date: Zakuro::Western::Calendar.new(year: 1000, month: 1, day: 2),
                last_date: Zakuro::Western::Calendar.new(year: 1000, month: 2, day: 2)
              )
              expect(actual).to be_falsey
            end
          end
          context 'parameters to be out of gengou range' do
            example 'overwrapped range' do
              actual = gengou.covered?(
                start_date: Zakuro::Western::Calendar.new(year: 999, month: 12, day: 31),
                last_date: Zakuro::Western::Calendar.new(year: 1000, month: 2, day: 4)
              )
              expect(actual).to be_truthy
            end
            example 'overwrapped range on start date' do
              actual = gengou.covered?(
                start_date: Zakuro::Western::Calendar.new(year: 999, month: 12, day: 31),
                last_date: Zakuro::Western::Calendar.new(year: 1000, month: 2, day: 2)
              )
              expect(actual).to be_falsey
            end
            example 'overwrapped range on last date' do
              actual = gengou.covered?(
                start_date: Zakuro::Western::Calendar.new(year: 1000, month: 1, day: 2),
                last_date: Zakuro::Western::Calendar.new(year: 1000, month: 2, day: 4)
              )
              expect(actual).to be_falsey
            end
            example 'completely out range less than start date' do
              actual = gengou.covered?(
                start_date: Zakuro::Western::Calendar.new(year: 999, month: 12, day: 2),
                last_date: Zakuro::Western::Calendar.new(year: 999, month: 12, day: 31)
              )
              expect(actual).to be_falsey
            end
            example 'completely out range more than last date' do
              actual = gengou.covered?(
                start_date: Zakuro::Western::Calendar.new(year: 1000, month: 2, day: 4),
                last_date: Zakuro::Western::Calendar.new(year: 1000, month: 3, day: 2)
              )
              expect(actual).to be_falsey
            end
          end
        end
      end
    end
  end
end
# rubocop:enable Metrics/BlockLength
