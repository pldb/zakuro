# frozen_string_literal: true

require_relative '../../type/old_float'

# :nodoc:
module Zakuro
  # :nodoc:
  module Calculation
    # :nodoc:
    module Lunar
      #
      # ChoukeiValue 再考長慶宣明暦算法
      #
      module ChoukeiValue
        class << self
          # @return [Output::Logger] ロガー
          LOGGER = Output::Logger.new(location: 'choukei_value')

          #
          # 四捨五入した大余を返す
          #
          # @param [Integer] per 増減率
          # @param [Integer] denominator 小余の分母
          # @param [Integer] minute 小余
          #
          # @return [Integer] 累計値（大余）
          #
          def rounded_day(per:, denominator:, minute:)
            # LOGGER.debug("minute: #{minute}")

            remainder_minute = Type::OldFloat.new((per * minute).to_f)

            # LOGGER.debug("remainder_minute.get: #{remainder_minute.get}")

            day = day_only(remainder_minute: remainder_minute.get, denominator: denominator)
            # 繰り上げ結果を足す
            day += carried_minute(remainder_minute: remainder_minute, denominator: denominator)

            day
          end

          #
          # 秒がない大余小余にする
          #
          # @param [Cycle::LunarRemainder] remainder 大余小余
          #
          # @note 815年で大余繰り上げあり
          #
          # @return [Integer] 大余
          # @return [Float] 小余
          #
          def remainder_without_second(remainder:)
            # LOGGER.debug("minute.to_f: #{remainder.minute.to_f}")
            # LOGGER.debug("second.to_f: #{remainder.second.to_f}")
            # LOGGER.debug("base_minute: #{remainder.base_minute}")
            # LOGGER.debug(
            #   "second.to_f / base_minute: #{remainder.second.to_f / remainder.base_minute}"
            # )
            adjusted = remainder.class.new(
              day: remainder.day, minute: remainder.floor_minute, second: 0
            )
            adjusted.carry!

            [adjusted.day, adjusted.minute]
          end

          private

          def day_only(remainder_minute:, denominator:)
            float_day = Type::OldFloat.new(remainder_minute / denominator)
            # 切り捨て（プラスマイナスに関わらず小数点以下切り捨て）
            float_day.floor!
            float_day.get
          end

          def carried_minute(remainder_minute:, denominator:)
            remainder_day = remainder_minute.abs % denominator
            # 四捨五入（1/2日 以上なら繰り上げる）
            return remainder_minute.sign if remainder_day >= (denominator / 2)

            0
          end
        end
      end
    end
  end
end
