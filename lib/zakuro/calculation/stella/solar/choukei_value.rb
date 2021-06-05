# frozen_string_literal: true

require_relative '../../type/old_float'

# :nodoc:
module Zakuro
  # :nodoc:
  module Calculation
    # :nodoc:
    module Solar
      #
      # ChoukeiValue 再考長慶宣明暦算法
      #
      module ChoukeiValue
        # @return [Output::Logger] ロガー
        LOGGER = Output::Logger.new(location: 'solar_choukei')

        #
        # 補正値を返す
        #
        # @param [Cycle::AbstractRemainder] remainder 大余小余
        # @param [Adjustment::Row] row 24気損益眺朒（ちょうじく）数
        #
        # @return [Integer] 補正値
        #
        def self.get(remainder:, row:)
          # 損益率/眺朒（ちょうじく）数
          # パラメータ:
          #  a: 眺朒（ちょうじく）数の初日の値
          #  b: 損益率初日の値
          #  c: 損益率の毎日の差
          #  n: 定気の日から数えた日数

          # LOGGER.debug("row.per_day: #{row.per_day}")
          # LOGGER.debug("row.stack: #{row.stack}")

          day_stack = calc_day_stack(remainder: remainder, row: row)

          # LOGGER.debug("day_stack: #{day_stack}")

          month_stack = calc_month_stack(row: row, day: remainder.day)

          # LOGGER.debug("month_stack: #{month_stack}")

          # 冬至であれば眺朒数がプラスになり続けて損益率が「益」で、小雪であればマイナスの眺朒数がプラスされ続けて「損」
          month_stack + day_stack
        end

        #
        # 損益率を求める
        #
        # @param [Remainder] remainder 入定気
        # @param [Adjustment::Row] row 24気損益眺朒（ちょうじく）数
        #
        # @return [Integer] 損益率
        #
        def self.calc_day_stack(remainder:, row:)
          ratio = calc_ratio(day: remainder.day, per_term: row.per_term, per_day: row.per_day)

          # LOGGER.debug("ratio.sign: #{ratio.sign}")
          # LOGGER.debug("ratio.abs: #{ratio.abs}")

          calc_day_stack_from_ratio(
            ratio: ratio, minute: remainder.minute, limit: remainder.base_day
          )
        end
        private_class_method :calc_day_stack

        #
        # 大余に対応する損益率を求める
        #   損益率 = b + n * c
        #
        # @param [Integer] day 大余
        # @param [Integer] per_term 眺朒（ちょうじく）数
        # @param [Integer] per_day 毎日差
        #
        # @return [Type::OldFloat] 大余に対応する損益率
        #
        def self.calc_ratio(day:, per_term:, per_day:)
          ratio = Type::OldFloat.new(per_term + day * per_day)
          # 小数点以下は無視する
          ratio.floor!

          ratio
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
        def self.calc_day_stack_from_ratio(ratio:, minute:, limit:)
          minute_stack = ratio.abs * minute
          day_stack = (minute_stack / limit).floor
          # 四捨五入
          # NOTE 資料では「この余りが4200をこえていれば切り上げる」とあり「>=」とした
          # 1612年の7月（慶長17年7月）が境界値4200だが、繰り上げを行なっていたため
          day_stack += 1 if minute_stack % limit >= (limit / 2)
          day_stack *= ratio.sign

          day_stack
        end
        private_class_method :calc_day_stack_from_ratio

        #
        # 眺朒（ちょうじく）数を求める
        #   眺朒（ちょうじく）数 = a + (n * b) + (1/2)n(n-1)c
        #
        # @param [Adjustment::Row] row 24気損益眺朒（ちょうじく）数
        # @param [Integer] day 大余
        #
        # @return [Integer] 眺朒（ちょうじく）数
        #
        def self.calc_month_stack(row:, day:)
          # row.stack: 眺朒（ちょうじく）積
          # row.per_term: 眺朒（ちょうじく）数
          # row.per_day: 毎日差
          month_stack = Type::OldFloat.new(
            row.stack + day * row.per_term + \
            (1 / 2.0) * (day * (day - 1) * row.per_day)
          )
          # 切り捨て（プラスマイナスに関わらず小数点以下切り捨て）
          month_stack.floor!

          month_stack.get
        end
        private_class_method :calc_month_stack
      end
    end
  end
end
