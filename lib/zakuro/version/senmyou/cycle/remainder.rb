# frozen_string_literal: true

require_relative '../../../calculation/cycle/abstract_remainder'

require_relative '../const/number'

# :nodoc:
module Zakuro
  # :nodoc:
  module Version
    # :nodoc:
    module Senmyou
      # :nodoc:
      module Cycle
        #
        # Remainder 時刻情報（大余小余）
        #
        class Remainder < Calculation::Cycle::AbstractRemainder
          # @return [Integer] 分（1分=8秒）
          MINUTE = 8

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
          # @return [Integer] 分（1分=100秒）
          MINUTE = 100

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
        # DroppedRemainder 没日の計算向け時刻情報（没余）
        #
        class DroppedRemainder < Calculation::Cycle::AbstractRemainder
          # @return [Integer] 分（1分=8秒）
          MINUTE = 8

          #
          # 初期化
          #
          # @param [Integer] day 大余（"日"に相当）
          # @param [Integer] minute 小余（"分"に相当）
          # @param [Integer] second 秒
          # @param [Integer] total 繰り上げなしの小余
          #
          def initialize(day: -1, minute: -1, second: -1, total: -1)
            # 小余 = 通余
            super(base_day: Const::Number::Derivation::REMAINDER_ALL_YEAR, base_minute: MINUTE,
                  day: day, minute: minute, second: second, total: total)
          end
        end

        #
        # VanishedRemainder 滅日の計算向け時刻情報（滅余）
        #
        class VanishedRemainder < Calculation::Cycle::AbstractRemainder
          # @return [Integer] 分（1分=8秒）
          MINUTE = 8

          #
          # 初期化
          #
          # @param [Integer] day 大余（"日"に相当）
          # @param [Integer] minute 小余（"分"に相当）
          # @param [Integer] second 秒
          # @param [Integer] total 繰り上げなしの小余
          #
          def initialize(day: -1, minute: -1, second: -1, total: -1)
            # 小余 = 朔虚分
            super(base_day: Const::Number::Derivation::REMAINDER_IDEAL_MONTH, base_minute: MINUTE,
                  day: day, minute: minute, second: second, total: total)
          end
        end
      end
    end
  end
end
