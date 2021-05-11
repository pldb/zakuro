# frozen_string_literal: true

require_relative '../cycle/solar_term'

# :nodoc:
module Zakuro
  # :nodoc:
  module Senmyou
    #
    # SolarOrbit 太陽軌道
    #
    module SolarOrbit
      # @return [Integer] 総法（1日=1340分）
      DAY = 1340

      #
      # 24気損益眺朒（ちょうじく）数
      #
      module Adjustment
        #
        # Item 24気損益眺朒（ちょうじく）数
        #
        class Item
          # @return [Integer] 眺朒（ちょうじく）積
          attr_reader :stack
          # @return [Integer] 眺朒（ちょうじく）数
          attr_reader :per_term
          # @return [Integer] 毎日差
          attr_reader :per_day

          #
          # 初期化
          #
          # @param [Integer] stack 眺朒（ちょうじく）積
          # @param [Integer] per_term 眺朒（ちょうじく）数
          # @param [Integer] per_day 毎日差
          #
          def initialize(stack:, per_term:, per_day:)
            @stack = stack
            @per_term = per_term
            @per_day = per_day
          end

          #
          # 文字化
          #
          # @return [String] 文字
          #
          def to_s
            "stack:#{@stack}, per_term:#{@per_term}, per_day:#{@per_day}"
          end
        end

        # @return [Array<Item>] 24気損益眺朒（ちょうじく）数
        LIST = {
          touji: Item.new(stack: 0.0, per_term: +3.9546, per_day: -0.0372),         # 冬至（とうじ）
          shoukan: Item.new(stack: +54.0, per_term: +3.4091, per_day: -0.0372),     # 小寒（しょうかん）
          daikan: Item.new(stack: +100.0, per_term: +2.8636, per_day: -0.0372),     # 大寒（だいかん）
          risshun: Item.new(stack: +138.0, per_term: +2.3181, per_day: +0.0372),    # 立春（りっしゅん）
          usui: Item.new(stack: +176.0, per_term: +2.8636, per_day: +0.0372),       # 雨水（うすい）
          keichitsu: Item.new(stack: +222.0, per_term: +3.4091, per_day: +0.0372),  # 啓蟄（けいちつ）
          shunbun: Item.new(stack: +276.0, per_term: -3.7220, per_day: +0.0329),    # 春分（しゅんぶん）
          seimei: Item.new(stack: +222.0, per_term: -3.2086, per_day: +0.0329),     # 清明（せいめい）
          kokuu: Item.new(stack: +176.0, per_term: -2.6952, per_day: +0.0329),      # 穀雨（こくう）
          rikka: Item.new(stack: +138.0, per_term: -2.1818, per_day: -0.0329),      # 立夏（りっか）
          shouman: Item.new(stack: +100.0, per_term: -2.6952, per_day: -0.0329),    # 小満（しょうまん）
          boushu: Item.new(stack: +54.0, per_term: -3.2086, per_day: -0.0329),      # 芒種（ぼうしゅ）
          geshi: Item.new(stack: 0.0, per_term: -3.7220, per_day: +0.0329),         # 夏至（げし）
          shousho: Item.new(stack: -54.0, per_term: -3.2086, per_day: +0.0329),     # 小暑（しょうしょ）
          taisho: Item.new(stack: -100.0, per_term: -2.6952, per_day: +0.0329),     # 大暑（たいしょ）
          risshuu: Item.new(stack: -138.0, per_term: -2.1818, per_day: -0.0329),    # 立秋（りっしゅう）
          shosho: Item.new(stack: -176.0, per_term: -2.6952, per_day: -0.0329),     # 処暑（しょしょ）
          hakuro: Item.new(stack: -222.0, per_term: -3.2086, per_day: -0.0329),     # 白露（はくろ）
          shuubun: Item.new(stack: -276.0, per_term: +3.9546, per_day: -0.0372),    # 秋分（しゅうぶん）
          kanro: Item.new(stack: -222.0, per_term: +3.4091, per_day: -0.0372),      # 寒露（かんろ）
          soukou: Item.new(stack: -176.0, per_term: +2.8636, per_day: -0.0372),     # 霜降（そうこう）
          rittou: Item.new(stack: -138.0, per_term: +2.3181, per_day: +0.0372),     # 立冬（りっとう）
          shousetsu: Item.new(stack: -100.0, per_term: +2.8636, per_day: +0.0372),  # 小雪（しょうせつ）
          taisetsu: Item.new(stack: -54.0, per_term: +3.4091, per_day: +0.0372)     # 大雪（たいせつ）
        }.freeze
      end

      #
      # 太陽の運行による補正値を算出する
      #
      # @param [SolarTerm] solar_term 入定気
      #
      # @return [Integer] 補正値
      #
      def self.calc_sun_orbit_value(solar_term:)
        remainder = solar_term.remainder

        adjustment = specify_solar_term_adjustment(index: solar_term.index)
        # 損益率/眺朒（ちょうじく）数
        # パラメータ:
        #  a: 眺朒（ちょうじく）数の初日の値
        #  b: 損益率初日の値
        #  c: 損益率の毎日の差
        #  n: 定気の日から数えた日数

        day_stack = calc_day_stack(remainder: remainder, adjustment: adjustment)

        month_stack = calc_month_stack(stack: adjustment.stack, day: remainder.day,
                                       per_term: adjustment.per_term, per_day:
                                       adjustment.per_day)

        # 冬至であれば眺朒数がプラスになり続けて損益率が「益」で、小雪であればマイナスの眺朒数がプラスされ続けて「損」
        month_stack + day_stack
      end

      #
      # 損益率を求める
      #
      # @param [Remainder] remainder 入定気
      # @param [Adjustment::Item] adjustment 24気損益眺朒（ちょうじく）数
      #
      # @return [Integer] 損益率
      #
      def self.calc_day_stack(remainder:, adjustment:)
        per_term = adjustment.per_term
        per_day = adjustment.per_day
        sign, ratio = calc_ratio(day: remainder.day, per_term: per_term, per_day: per_day)

        calc_day_stack_from_ratio(sign: sign, ratio: ratio,
                                  minute: remainder.minute)
      end
      private_class_method :calc_day_stack

      #
      # 24気損益眺朒（ちょうじく）数を特定する
      #
      # @param [Integer] index 連番（二十四節気）
      #
      # @return [Adjustment::Item] 24気損益眺朒（ちょうじく）数
      #
      def self.specify_solar_term_adjustment(index:)
        key = Cycle::SolarTerm::ORDER[index]
        Adjustment::LIST[key].clone
      end
      private_class_method :specify_solar_term_adjustment

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
      def self.calc_day_stack_from_ratio(sign:, ratio:, minute:)
        minute_stack = ratio * minute
        day_stack = (minute_stack / DAY).floor
        # 四捨五入
        # NOTE 資料では「この余りが4200をこえていれば切り上げる」とあり「>=」とした
        # 1612年の7月（慶長17年7月）が境界値4200だが、繰り上げを行なっていたため
        day_stack += 1 if minute_stack % DAY >= (DAY / 2)
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