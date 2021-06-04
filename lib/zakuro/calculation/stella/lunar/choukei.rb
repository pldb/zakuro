# frozen_string_literal: true

require_relative '../../type/old_float'

# :nodoc:
module Zakuro
  # :nodoc:
  module Calculation
    # :nodoc:
    module Lunar
      #
      # Choukei 再考長慶宣明暦算法
      #
      module Choukei
        #
        # 四捨五入した大余を返す
        #
        # @param [Integer] per 増減率
        # @param [Integer] denominator 小余の分母
        # @param [Integer] minute 小余
        #
        # @return [Integer] 累計値（大余）
        #
        def self.rounded_day(per:, denominator:, minute:)
          remainder_minute = Type::OldFloat.new((per * minute).to_f)
          day = day_only(remainder_minute: remainder_minute.get, denominator: denominator)
          # 繰り上げ結果を足す
          day += carried_minute(remainder_minute: remainder_minute, denominator: denominator)

          day
        end

        def self.day_only(remainder_minute:, denominator:)
          float_day = Type::OldFloat.new(remainder_minute / denominator)
          # 切り捨て（プラスマイナスに関わらず小数点以下切り捨て）
          float_day.floor!
          float_day.get
        end
        private_class_method :day_only

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
