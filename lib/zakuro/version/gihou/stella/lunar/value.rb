# frozen_string_literal: true

require_relative '../../../../calculation/type/old_float'

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

          # LOGGER.debug("value.per: #{value.per}")
          # LOGGER.debug("denominator: #{denominator}")
          # LOGGER.debug("value.stack: #{value.stack}")

          minus_minute = Adjustment.minus_minute(day: day, minute: minute)

          day = calc_day(per: value.per, denominator: denominator,
                         minute: minus_minute)

          # LOGGER.debug("day: #{day}")

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

        # :reek:TooManyStatements { max_statements: 6 }

        #
        # 累計値（大余）を作成する
        #
        # @param [Integer] per 増減率
        # @param [Integer] denominator 小余の分母
        # @param [Integer] minute 小余
        #
        # @return [Integer] 累計値（大余）
        #
        def self.calc_day(per:, denominator:, minute:)
          remainder_minute = Calculation::Type::OldFloat.new((per * minute).to_f)
          float_day = Calculation::Type::OldFloat.new(remainder_minute.get / denominator)
          # 切り捨て（プラスマイナスに関わらず小数点以下切り捨て）
          float_day.floor!
          day = float_day.get
          # 繰り上げ結果を足す
          day += carried_minute(remainder_minute: remainder_minute, denominator: denominator)

          day
        end
        private_class_method :calc_day

        def self.carried_minute(remainder_minute:, denominator:)
          remainder_day = remainder_minute.abs % denominator
          # 四捨五入（1/2日 以上なら繰り上げる）
          return remainder_minute.sign if remainder_day >= (denominator / 2)

          0
        end
        private_class_method :carried_minute
      end
    end
  end
end
