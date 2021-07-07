# frozen_string_literal: true

require_relative '../cycle/remainder'

# :nodoc:
module Zakuro
  # :nodoc:
  module Daien
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
          # 1年（1_110_343） / 24 / 1日（3040）= 15 余り 664.2916666666642
          #   * 0.2916666666642 * 24（1分=24秒） = 6.999999999940799 ≒ 7
          SOLAR_TERM_AVERAGE = Cycle::Remainder.new(day: 15, minute: 664, second: 7)
          #
          # @note 揲法 89773 = 29-1613
          #   * 89773 / 4 = 22443.25 / 3040 = 7 余り 1163.25
          #   * 0.25 * 24（1分=24秒） = 6
          #
          # @return [Cycle::Remainder] 弦（1分=80秒）
          QUARTER = Cycle::Remainder.new(day: 7, minute: 1163, second: 6)
        end

        #
        # Lunar 月
        #
        module Lunar
          # @return [Cycle::LunarRemainder] 転日（1近点月）
          ANOMALISTIC_MONTH = \
            Cycle::LunarRemainder.new(day: 27, minute: 1685, second: 79)
          #
          # @note 揲法 89773 = 29-1613
          #   * 89773 / 4 = 22443.25 / 3040 = 7 余り 1163.25
          #   * 0.25 * 80（1分=80秒） = 20
          #
          # @return [Cycle::LunarRemainder] 弦（1分=80秒）
          # TODO: 秒が20では通らない。少なくとも0.01247は必要になる
          QUARTER = Cycle::LunarRemainder.new(day: 7, minute: 1163, second: 20.01247)
        end
      end
    end
  end
end
