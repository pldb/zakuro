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
          # @return [Remainder] 気策（24分の1年）
          SOLAR_TERM_AVERAGE = Remainder.new(day: 15, minute: 292, second: 5)
          # TODO: 宣明暦のまま
          # @return [Cycle::Remainder] 弦（1分=8秒）
          QUARTER = Cycle::Remainder.new(day: 7, minute: 3214, second: 2)
        end

        #
        # Lunar 月
        #
        module Lunar
          # TODO: 宣明暦のまま
          # @return [Cycle::LunarRemainder] 暦中日
          # @note ANOMALISTIC_MONTH の半分に相当する
          HALF_ANOMALISTIC_MONTH = \
            Cycle::LunarRemainder.new(day: 13, minute: 6529, second: 9.5)
          # @return [Cycle::LunarRemainder] 入暦上限
          LIMIT = Cycle::LunarRemainder.new(day: 14, minute: 6529, second: 0)
          # @return [Cycle::LunarRemainder] 弦（1分=100秒）
          QUARTER = Cycle::LunarRemainder.new(day: 7, minute: 3214, second: 25)
        end
      end
    end
  end
end
