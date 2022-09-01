# frozen_string_literal: true

require_relative '../cycle/remainder'

# :nodoc:
module Zakuro
  # :nodoc:
  module Senmyou
    #
    # Const 定数
    #
    module Const
      #
      # Remainder 大余小余
      #
      module Remainder
        #
        # Solar 太陽
        #
        module Solar
          # @return [Cycle::Remainder] 気策（24分の1年）
          SOLAR_TERM_AVERAGE = Cycle::Remainder.new(day: 15, minute: 1835, second: 5)
          #
          # @note 章月 248057 = 29-4457
          #
          # @return [Cycle::Remainder] 弦（1分=8秒）
          QUARTER = Cycle::Remainder.new(day: 7, minute: 3214, second: 2)

          # @return [Cycle::Remainder] 有没判定
          # * 中盈（小余3671秒2）/ 2 = 小余1835秒5
          # * 日（小余8400） - 小余1835秒5 = 小余6564秒3
          DROPPED_DATE_LIMIT = Cycle::Remainder.new(day: 0, minute: 6564, second: 3)
        end

        #
        # Lunar 月
        #
        module Lunar
          # @return [Cycle::LunarRemainder] 暦中日
          # @note ANOMALISTIC_MONTH （1近点月）の半分に相当する
          HALF_ANOMALISTIC_MONTH = \
            Cycle::LunarRemainder.new(day: 13, minute: 6529, second: 9.5)
          #
          # @note 章月 248057 = 29-4457
          #
          # @return [Cycle::LunarRemainder] 弦（1分=100秒）
          # TODO: 秒が25では通らない。少なくとも0.00546は必要になる（最大 0.01863）
          QUARTER = Cycle::LunarRemainder.new(day: 7, minute: 3214, second: 25.00546)
        end
      end
    end
  end
end
