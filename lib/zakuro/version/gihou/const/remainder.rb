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
          # TODO: 仮置きする
          #   3214.25 / 8400 * 1340 = 512.7494047...
          # @return [Cycle::Remainder] 弦（1分=6秒）
          QUARTER = Cycle::Remainder.new(day: 7, minute: 512, second: 5)
        end

        #
        # Lunar 月
        #
        module Lunar
          # TODO: Lunar::Adjustment のコメント参照。誤っていた場合は訂正すること
          # @return [Cycle::LunarRemainder] 入暦上限
          LIMIT = Cycle::LunarRemainder.new(day: 28, minute: 743, second: 0)
          # TODO: 仮置きする
          # @return [Cycle::LunarRemainder] 弦（1分=12秒）
          QUARTER = Cycle::LunarRemainder.new(day: 7, minute: 512, second: 10)
        end
      end
    end
  end
end
