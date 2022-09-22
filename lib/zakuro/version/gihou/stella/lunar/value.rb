# frozen_string_literal: true

require_relative '../../../../calculation/stella/lunar/choukei_value'

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
        # @return [Output::Logger] ロガー
        LOGGER = Output::Logger.new(location: 'lunar_value')

        # :reek:TooManyStatements { max_statements: 9 }

        class << self
          #
          # 月の運行による補正値を算出する
          #
          # @param [Cycle::LunarRemainder] remainder 月の大余小余
          #
          # @return [Integer] 補正値
          #
          def get(remainder:)
            valid?(remainder: remainder)

            day, minute = Calculation::Lunar::ChoukeiValue.remainder_without_second(
              remainder: remainder
            )

            # 引き当て
            row = Adjustment.specify(day: day, minute: minute)

            value = row.value

            # LOGGER.debug("value.per: #{value.per}")
            # LOGGER.debug("row.denominator: #{row.denominator}")
            # LOGGER.debug("value.stack: #{value.stack}")

            minus_minute = Adjustment.minus_minute(day: day, minute: minute)

            day = Calculation::Lunar::ChoukeiValue.rounded_day(
              per: value.per, denominator: row.denominator, minute: minus_minute
            )

            # LOGGER.debug("day: #{day}")

            value.stack + day
          end

          private

          #
          # 大余小余を検証する
          #
          # @param [Cycle::LunarRemainder] remainder 大余小余
          #
          # @return [True] 正しい（月の位相計算に使う大余小余）
          # @return [True] 正しくない
          #
          # @raise [ArgumentError] 引数エラー
          #
          def valid?(remainder:)
            return if remainder.is_a?(Cycle::LunarRemainder)

            raise ArgumentError, "unmatch parameter type: #{remainder.class}"
          end
        end
      end
    end
  end
end
