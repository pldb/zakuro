# frozen_string_literal: true

require File.expand_path('./testtool/const', __dir__)

require File.expand_path('../lib/zakuro', __dir__)

require 'date'

# rubocop:disable Metrics/BlockLength
describe 'Zakuro' do
  describe 'Merchant' do
    describe '#new' do
      context 'invalid parameter' do
        example 'date' do
          hash = { date: 1 }
          expect do
            Zakuro::Merchant.new(condition: hash)
          end.to raise_error(Zakuro::Exception::ZakuroError)
        end
      end
    end
    describe '#commit' do
      context 'default' do
        context '862-2-3' do
          example '貞観4年1月1日' do
            date = Date.new(862, 2, 3)
            actual = Zakuro::Merchant.new(condition: { date: date }).commit
            expect(actual.to_pretty_json).to eql(
              Zakuro::TestTool::Const::SENMYOU_FIRST_DAY.to_pretty_json
            )
          end
        end
      end
      context 'dropped date' do
        context '862-3-28' do
          example '貞観4年2月24日' do
            date = Date.new(862, 3, 28)
            actual = Zakuro::Merchant.new(
              condition: { date: date, options: { 'dropped_date' => true } }
            ).commit
            expect(actual.to_pretty_json).to eql(
              Zakuro::TestTool::Const::DAY_WITH_DROPPED_DATE.to_pretty_json
            )
          end
        end
      end
      context 'vanished date' do
        context '862-5-1' do
          example '貞観4年3月29日' do
            date = Date.new(862, 5, 1)
            actual = Zakuro::Merchant.new(
              condition: { date: date, options: { 'vanished_date' => true } }
            ).commit
            expect(actual.to_pretty_json).to eql(
              Zakuro::TestTool::Const::DAY_WITH_VANISHED_DATE.to_pretty_json
            )
          end
        end
        context '貞観4年3月29日' do
          example '貞観4年3月29日' do
            date = '貞観4年3月29日'
            actual = Zakuro::Merchant.new(
              condition: { date: date, options: { 'vanished_date' => true } }
            ).commit
            expect(actual.to_pretty_json).to eql(
              Zakuro::TestTool::Const::DAY_WITH_VANISHED_DATE.to_pretty_json
            )
          end
        end
      end
    end
  end
end
# rubocop:enable Metrics/BlockLength
