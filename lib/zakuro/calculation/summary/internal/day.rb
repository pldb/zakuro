# frozen_string_literal: true

require_relative '../../../calculation/base/day'
require_relative '../../../era/western/calendar'

# :nodoc:
module Zakuro
  # :nodoc:
  module Calculation
    # :nodoc:
    module Summary
      #
      # Day 特定日
      #
      module Day
        #
        # 日を取得する
        #
        # @param [Month] month 月
        # @param [Western::Calendar] date 現在西暦日
        #
        # @return [Calculation::Base::Day] 特定日
        #
        def self.get(month:, date: Western::Calendar.new)
          first_date = month.western_date
          days = date - first_date
          remainder = month.remainder
          remainder = remainder.add(
            # 常に参照元のRemainderクラスで生成する
            remainder.class.new(day: days, minute: 0, second: 0)
          )

          Calculation::Base::Day.new(
            number: days + 1, western_date: date, remainder: remainder
          )
        end
      end
    end
  end
end
