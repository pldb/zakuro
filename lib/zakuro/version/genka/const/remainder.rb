# frozen_string_literal: true

require_relative '../cycle/remainder'

# :nodoc:
module Zakuro
  # :nodoc:
  module Version
    # :nodoc:
    module Genka
      #
      # Const 定数
      #
      module Const
        #
        # Remainder 大余小余
        #
        module Remainder
          #
          # @note 『歴代天文律暦等志彙編　六』中華書房 p.1727
          # 「推弦望法..加朔大餘七，小餘二百八十七，小分三，小分満四從小餘」
          #
          # @return [Cycle::Remainder] 弦（1分=4秒）
          QUARTER = Cycle::Remainder.new(day: 7, minute: 287, second: 3)

          #
          # @note 『歴代天文律暦等志彙編　六』中華書房 p.1727
          # 「推二十四氣術」「求次氣，加朔大餘十五，小餘六十六，小分十一，小分満氣法從小餘，小餘満度法從大餘」
          #
          # @return [Cycle::Remainder] 気策（24分の1年）
          SOLAR_TERM_AVERAGE = Cycle::TermRemainder.new(day: 15, minute: 66 + 11.0 / 24, second: 0)
        end
      end
    end
  end
end
