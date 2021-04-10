# frozen_string_literal: true

require File.expand_path('../testtools/const', __dir__)

require File.expand_path('../testtools/stringifier', __dir__)

require 'date'
require File.expand_path('../../lib/zakuro/merchant',
                         __dir__)

describe 'Zakuro' do
  describe 'Merchant' do
    describe 'commit' do
      context '862-2-3' do
        example '貞観4年1月1日' do
          date = Date.new(862, 2, 3)
          actual = Zakuro::Merchant.new(condition: { date: date }).commit

          TestTools::Stringifier.eql?(
            expected: Const::SENMYOU_FIRST_DAY, actual: actual, class_prefix: 'Zakuro::Result'
          )
        end
      end
    end
  end
end
