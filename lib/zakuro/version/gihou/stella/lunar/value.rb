# frozen_string_literal: true

require_relative '../../cycle/remainder'

require_relative './adjustment'

# :nodoc:
module Zakuro
  # :nodoc:
  module Gihou
    # :nodoc:
    module Lunar
      #
      # Value 月補正値
      #
      module Value
        # TODO: 儀鳳暦にする

        # :reek:TooManyStatements { max_statements: 9 }

        #
        # 月の運行による補正値を算出する
        #
        # @param [Cycle::LunarRemainder] remainder 月の大余小余
        #
        # @return [Integer] 補正値
        #
        def self.get(remainder:)
          valid?(remainder: remainder)

          day = remainder.day
          minute = remainder.floor_minute

          # 引き当て
          row = Adjustment.specify(day: day, minute: minute)

          value = row.value
          denominator = row.denominator

          minus_minute = Adjustment.minus_minute(day: day, minute: minute)

          day = calc_day(per: value.per, denominator: denominator,
                         minute: minus_minute)

          value.stack + day
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
        def self.calc_day(per:, denominator:, minute:)
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
        private_class_method :calc_day
      end
    end
  end
end
