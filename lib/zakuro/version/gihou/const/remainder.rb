# frozen_string_literal: true

require_relative '../cycle/remainder'

# :nodoc:
module Zakuro
  # :nodoc:
  module Gihou
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
          SOLAR_TERM_AVERAGE = Cycle::Remainder.new(day: 15, minute: 292, second: 5)
          #
          # @note 常朔実 39571 = 29-711
          #   * 39571 / 4 = 9892.75 / 1340 = 7 余り 512.75
          #   * 0.75 * 6（1分=6秒） = 4.5
          #
          # @return [Cycle::Remainder] 弦（1分=6秒）
          QUARTER = Cycle::Remainder.new(day: 7, minute: 512, second: 4.5)
        end

        #
        # Lunar 月
        #
        module Lunar
          # @return [Cycle::LunarRemainder] 変日（1近点月）
          ANOMALISTIC_MONTH = \
            Cycle::LunarRemainder.new(day: 27, minute: 743, second: 1)
          #
          # @note 常朔実 39571 = 29-711
          #   * 39571 / 4 = 9892.75 / 1340 = 7 余り 512.75
          #   * 0.75 * 12（1分=12秒） = 9
          #
          # @return [Cycle::LunarRemainder] 弦（1分=12秒）
          # TODO: 9秒だと通らない。 0.00378 〜 0.0208 の範囲内で通る
          # QUARTER = Cycle::LunarRemainder.new(day: 7, minute: 512, second: 9.0208)
          QUARTER = Cycle::LunarRemainder.new(day: 7, minute: 512, second: 9.00378)
        end
      end
    end
  end
end
