# frozen_string_literal: true

require_relative '../../type/old_float'

# :nodoc:
module Zakuro
  # :nodoc:
  module Calculation
    # :nodoc:
    module Solar
      #
      # Choukei 再考長慶宣明暦算法
      #
      module Choukei
        def self.value(remainder:, row:)
          # 損益率/眺朒（ちょうじく）数
          # パラメータ:
          #  a: 眺朒（ちょうじく）数の初日の値
          #  b: 損益率初日の値
          #  c: 損益率の毎日の差
          #  n: 定気の日から数えた日数

          # LOGGER.debug("adjustment.per_day: #{adjustment.per_day}")
          # LOGGER.debug("adjustment.stack: #{adjustment.stack}")

          day_stack = calc_day_stack(remainder: remainder, adjustment: row)

          # LOGGER.debug("day_stack: #{day_stack}")

          month_stack = calc_month_stack(stack: row.stack, day: remainder.day,
                                         per_term: row.per_term, per_day:
                                         row.per_day)

          # LOGGER.debug("month_stack: #{month_stack}")

          # 冬至であれば眺朒数がプラスになり続けて損益率が「益」で、小雪であればマイナスの眺朒数がプラスされ続けて「損」
          month_stack + day_stack
        end

        #
        # 損益率を求める
        #
        # @param [Remainder] remainder 入定気
        # @param [Adjustment::Row] adjustment 24気損益眺朒（ちょうじく）数
        #
        # @return [Integer] 損益率
        #
        def self.calc_day_stack(remainder:, adjustment:)
          per_term = adjustment.per_term
          per_day = adjustment.per_day
          sign, ratio = calc_ratio(day: remainder.day, per_term: per_term, per_day: per_day)

          # LOGGER.debug("calc_ratio: sign: #{sign}")
          # LOGGER.debug("calc_ratio: ratio: #{ratio}")

          calc_day_stack_from_ratio(sign: sign, ratio: ratio,
                                    minute: remainder.minute, limit: remainder.base_day)
        end
        private_class_method :calc_day_stack

        # :reek:TooManyStatements { max_statements: 6 }

        #
        # 大余に対応する損益率を求める
        #   損益率 = b + n * c
        #
        # @param [Integer] day 大余
        # @param [Integer] per_term 眺朒（ちょうじく）数
        # @param [Integer] per_day 毎日差
        #
        # @return [Integer] 正負
        # @return [Integer] 大余に対応する損益率
        #
        def self.calc_ratio(day:, per_term:, per_day:)
          ratio = per_term + day * per_day
          sign = 1
          if ratio.negative?
            sign = -1
            ratio *= sign
          end
          # 小数点以下は無視する
          ratio = ratio.floor

          [sign, ratio]
        end
        private_class_method :calc_ratio

        #
        # 小余を含めた損益率を求める
        #
        # @param [Integer] sign 正負（大余に対応する損益率）
        # @param [Integer] ratio 大余に対応する損益率
        # @param [Integer] minute 小余
        #
        # @return [Integer] 小余を含めた損益率
        #
        def self.calc_day_stack_from_ratio(sign:, ratio:, minute:, limit:)
          minute_stack = ratio * minute
          day_stack = (minute_stack / limit).floor
          # 四捨五入
          # NOTE 資料では「この余りが4200をこえていれば切り上げる」とあり「>=」とした
          # 1612年の7月（慶長17年7月）が境界値4200だが、繰り上げを行なっていたため
          day_stack += 1 if minute_stack % limit >= (limit / 2)
          day_stack *= sign

          day_stack
        end
        private_class_method :calc_day_stack_from_ratio

        # :reek:LongParameterList { max_params: 4 }

        #
        # 眺朒（ちょうじく）数を求める
        #   眺朒（ちょうじく）数 = a + (n * b) + (1/2)n(n-1)c
        #
        # @param [Integer] stack 眺朒（ちょうじく）積
        # @param [Integer] day 大余
        # @param [Integer] per_term 眺朒（ちょうじく）数
        # @param [Integer] per_day 毎日差f
        #
        # @return [Integer] 眺朒（ちょうじく）数
        #
        def self.calc_month_stack(stack:, day:, per_term:, per_day:)
          month_stack = stack + day * per_term + \
                        (1 / 2.0) * (day * (day - 1) * per_day)
          # 切り捨て（プラスマイナスに関わらず小数点以下切り捨て）
          month_stack.negative? ? month_stack.ceil : month_stack.floor
        end
        private_class_method :calc_month_stack
      end
    end
  end
end
