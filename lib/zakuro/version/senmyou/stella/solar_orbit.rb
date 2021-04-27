# frozen_string_literal: true

require_relative '../base/solar_term'

# :nodoc:
module Zakuro
  # :nodoc:
  module Senmyou
    #
    # SolarOrbit 太陽軌道
    #
    module SolarOrbit
      # @return [Integer] 統法（1日=8400分）
      DAY = 8400

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
          touji: Item.new(stack: 0.0, per_term: +33.4511, per_day: -0.3695),        # 冬至（とうじ）
          shoukan: Item.new(stack: +449.0, per_term: +28.0389, per_day: -0.3606),   # 小寒（しょうかん）
          daikan: Item.new(stack: +823.0, per_term: +22.6998, per_day: -0.3519),    # 大寒（だいかん）
          risshun: Item.new(stack: +1122.0, per_term: +17.8923, per_day: -0.4068),  # 立春（りっしゅん）
          usui: Item.new(stack: +1346.0, per_term: +11.7966, per_day: -0.3998),     # 雨水（うすい）
          keichitsu: Item.new(stack: +1481.0, per_term: +5.7986, per_day: -0.3998), # 啓蟄（けいちつ）
          shunbun: Item.new(stack: +1526.0, per_term: -0.2433, per_day: -0.3779),   # 春分（しゅんぶん）
          seimei: Item.new(stack: +1481.0, per_term: -6.1254, per_day: -0.3634),    # 清明（せいめい）
          kokuu: Item.new(stack: +1346.0, per_term: -12.2048, per_day: -0.2987),    # 穀雨（こくう）
          rikka: Item.new(stack: +1122.0, per_term: -16.9060, per_day: -0.2919),    # 立夏（りっか）
          shouman: Item.new(stack: +823.0, per_term: -21.5362, per_day: -0.2854),   # 小満（しょうまん）
          boushu: Item.new(stack: +449.0, per_term: -26.0498, per_day: -0.2854),    # 芒種（ぼうしゅ）
          geshi: Item.new(stack: 0.0, per_term: -30.3119, per_day: +0.2854),        # 夏至（げし）
          shousho: Item.new(stack: -449.0, per_term: -25.8126, per_day: +0.2919),   # 小暑（しょうしょ）
          taisho: Item.new(stack: -823.0, per_term: -21.2454, per_day: +0.2987),    # 大暑（たいしょ）
          risshuu: Item.new(stack: -1122.0, per_term: -17.0296, per_day: +0.3634),  # 立秋（りっしゅう）
          shosho: Item.new(stack: -1346.0, per_term: -11.4744, per_day: +0.3779),   # 処暑（しょしょ）
          hakuro: Item.new(stack: -1481.0, per_term: -5.6429, per_day: +0.3779),    # 白露（はくろ）
          shuubun: Item.new(stack: -1526.0, per_term: +0.1432, per_day: +0.3998),   # 秋分（しゅうぶん）
          kanro: Item.new(stack: -1481.0, per_term: +6.1488, per_day: +0.4068),     # 寒露（かんろ）
          soukou: Item.new(stack: -1346.0, per_term: +12.6336, per_day: +0.3519),   # 霜降（そうこう）
          rittou: Item.new(stack: -1122.0, per_term: +17.8043, per_day: +0.3606),   # 立冬（りっとう）
          shousetsu: Item.new(stack: -823.0, per_term: +23.0590, per_day: +0.3695), # 小雪（しょうせつ）
          taisetsu: Item.new(stack: -449.0, per_term: +28.4618, per_day: +0.3695)   # 大雪（たいせつ）
        }.freeze
      end

      #
      # 太陽の運行による補正値を算出する
      #
      # @param [SolarTerm] solar_term 二十四節気
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
        key = SolarTerm::ORDER[index]
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
