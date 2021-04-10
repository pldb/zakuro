# frozen_string_literal: true

require File.expand_path('../../../testtools/stringifier', __dir__)

require File.expand_path('../../../testtools/const', __dir__)

require File.expand_path('../../../../' \
                         'lib/zakuro/version/senmyou/senmyou',
                         __dir__)

require 'date'

describe 'Zakuro' do
  describe 'Senmyou' do
    describe 'Gateway' do
      describe '.to_japan_date' do
        context '862-2-3' do
          example '貞観4年1月1日' do
            date = Date.new(862, 2, 3)
            actual = Zakuro::Senmyou::Gateway.to_japan_date(western_date: date)

            TestTools::Stringifier.eql?(
              expected: Const::SENMYOU_FIRST_DAY, actual: actual, class_prefix: 'Zakuro::Result'
            )
          end
        end
      end
    end
  end
end
