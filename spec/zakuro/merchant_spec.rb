# frozen_string_literal: true

require File.expand_path('../testtool/const', __dir__)

require File.expand_path('../testtool/stringifier', __dir__)

require 'date'
require File.expand_path('../../lib/zakuro/merchant',
                         __dir__)

# rubocop:disable Metrics/BlockLength
describe 'Zakuro' do
  describe 'Merchant' do
    describe 'commit' do
      context '"862-2-3" as 貞観4年1月1日' do
        context 'single' do
          example 'japan' do
            date = '貞観4年1月1日'
            actual = Zakuro::Merchant.new(condition: { date: date }).commit

            TestTool::Stringifier.eql?(
              expected: Const::SENMYOU_FIRST_DAY, actual: actual, class_prefix: 'Zakuro::Result'
            )
          end
          example 'western' do
            date = Date.new(862, 2, 3)
            actual = Zakuro::Merchant.new(condition: { date: date }).commit

            TestTool::Stringifier.eql?(
              expected: Const::SENMYOU_FIRST_DAY, actual: actual, class_prefix: 'Zakuro::Result'
            )
          end
        end
        context 'range' do
          example 'western' do
            date = Date.new(862, 2, 3)
            actual = Zakuro::Merchant.new(
              condition: { range: { start: date, last: date } }
            ).commit

            TestTool::Stringifier.eql?(
              expected: Const::SENMYOU_RANGE, actual: actual, class_prefix: 'Zakuro::Result'
            )
          end
        end
      end
    end
  end
end
# rubocop:enable Metrics/BlockLength
