# frozen_string_literal: true

require_relative '../../../../calculation/stella/lunar/choukei_value'

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
        # :reek:TooManyStatements { max_statements: 9 }

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

          day, minute = Calculation::Lunar::ChoukeiValue.remainder_without_second(
            remainder: remainder
          )

          # 引き当て
          row = Adjustment.specify(forward: forward, day: day, minute: minute)

          value = row.value

          minus_minute = Adjustment.minus_minute(day: day, minute: minute)

          day = Calculation::Lunar::ChoukeiValue.rounded_day(
            per: value.per, denominator: row.denominator, minute: minus_minute
          )

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
      end
    end
  end
end
