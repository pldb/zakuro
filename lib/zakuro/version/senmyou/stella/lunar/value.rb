# frozen_string_literal: true

require_relative '../../cycle/remainder'

require_relative './adjustment'

# :nodoc:
module Zakuro
  # :nodoc:
  module Senmyou
    # :nodoc:
    module Lunar
      #
      # Value 月補正値
      #
      module Value
        #
        # 月の運行による補正値を算出する
        #
        # @param [Cycle::LunarRemainder] remainder 月の大余小余
        # @param [True, False] forward 進（遠地点より数える）/退（近地点より数える）
        #
        # @return [Integer] 補正値
        #
        def self.get(remainder:, forward:)
          valid?(remainder: remainder)

          day, minute = calculable_remainder_value(remainder: remainder)

          # 引き当て
          adjustment, diff, minute = Adjustment.specify(
            forward: forward, day: day, minute: minute
          )
          day = cumulative_value_for_days(per: adjustment.per,
                                          denominator: diff, minute: minute)

          adjustment.stack + day
        end

        #
        # 大余小余を検証する
        #
        # @param [Cycle::LunarRemainder] remainder 大余小余
        #
        # @return [True] 正しい（月の位相計算に使う大余小余）
        # @return [True] 正しくない
        #
        def self.valid?(remainder:)
          return if remainder.is_a?(Cycle::LunarRemainder)

          raise ArgumentError, "unmatch parameter type: #{remainder.class}"
        end
        private_class_method :valid?

        #
        # 大余小余を計算可能な値にする
        # @note 大余の秒（second）は使わない
        #
        # @param [Cycle::LunarRemainder] remainder 大余小余
        #
        # @return [Integer] 大余
        # @return [Integer] 小余
        #
        def self.calculable_remainder_value(remainder:)
          day = remainder.day
          minute = remainder.minute + (remainder.second / 100)
          minute = minute.floor

          [day, minute]
        end
        private_class_method :calculable_remainder_value

        # :reek:TooManyStatements { max_statements: 9 }

        #
        # 累計値（大余）を作成する
        #
        # @param [Integer] per 入暦（1-14）
        # @param [Integer] denominator 小余の分母
        # @param [Integer] minute 小余
        #
        # @return [Integer] 累計値（大余）
        #
        def self.cumulative_value_for_days(per:, denominator:, minute:)
          remainder_minute = (per * minute).to_f
          day = remainder_minute / denominator
          # 切り捨て（プラスマイナスに関わらず小数点以下切り捨て）
          day = day.negative? ? day.ceil : day.floor
          sign = remainder_minute.negative? ? -1 : 1
          remainder_day = (sign * remainder_minute) % denominator
          # 四捨五入（8400ならその半分の4200以上を繰り上げる）
          day += sign if remainder_day >= (denominator / 2)

          day
        end
        private_class_method :cumulative_value_for_days
      end
    end
  end
end
