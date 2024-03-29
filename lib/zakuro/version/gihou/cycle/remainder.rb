# frozen_string_literal: true

require_relative '../../../calculation/cycle/abstract_remainder'

require_relative '../const/number'

# :nodoc:
module Zakuro
  # :nodoc:
  module Version
    # :nodoc:
    module Gihou
      # :nodoc:
      module Cycle
        #
        # Remainder 時刻情報（大余小余）
        #
        class Remainder < Calculation::Cycle::AbstractRemainder
          # @return [Integer] 分（1分=6秒）
          MINUTE = 6

          #
          # 初期化
          #
          # @param [Integer] day 大余（"日"に相当）
          # @param [Integer] minute 小余（"分"に相当）
          # @param [Integer] second 秒
          # @param [Integer] total 繰り上げなしの小余
          #
          def initialize(day: -1, minute: -1, second: -1, total: -1)
            super(base_day: Const::Number::Cycle::DAY, base_minute: MINUTE,
                  day: day, minute: minute, second: second, total: total)
          end
        end

        #
        # LunarRemainder 月の位相計算向け時刻情報（大余小余）
        #
        class LunarRemainder < Calculation::Cycle::AbstractRemainder
          # @return [Integer] 分（1分=12秒）
          MINUTE = 12

          #
          # 初期化
          #
          # @param [Integer] day 大余（"日"に相当）
          # @param [Integer] minute 小余（"分"に相当）
          # @param [Integer] second 秒
          # @param [Integer] total 繰り上げなしの小余
          #
          def initialize(day: -1, minute: -1, second: -1, total: -1)
            super(base_day: Const::Number::Cycle::DAY, base_minute: MINUTE,
                  day: day, minute: minute, second: second, total: total)
          end
        end
      end
    end
  end
end
