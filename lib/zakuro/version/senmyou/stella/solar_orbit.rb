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
      # Interval 入気定日加減数（二十四節気の間隔）
      #
      module Interval
        # @return [Hash<Symbol, Remainder>] 一覧
        LIST = {
          # 冬至（とうじ）・大雪（たいせつ）
          touji: Remainder.new(day: 14, minute: 4235, second: 5),
          taisetsu: Remainder.new(day: 14, minute: 4235, second: 5),
          # 小寒（しょうかん）・小雪（しょうせつ）
          shoukan: Remainder.new(day: 14, minute: 5235, second: 5),
          shousetsu: Remainder.new(day: 14, minute: 5235, second: 5),
          # 大寒（だいかん）・立冬（りっとう）
          daikan: Remainder.new(day: 14, minute: 6235, second: 5),
          rittou: Remainder.new(day: 14, minute: 6235, second: 5),
          # 立春（りっしゅん）・霜降（そうこう）
          risshun: Remainder.new(day: 14, minute: 7235, second: 5),
          soukou: Remainder.new(day: 14, minute: 7235, second: 5),
          # 雨水（うすい）・寒露（かんろ）
          usui: Remainder.new(day: 15, minute: 35, second: 5),
          kanro: Remainder.new(day: 15, minute: 35, second: 5),
          # 啓蟄（けいちつ）・秋分（しゅうぶん）
          keichitsu: Remainder.new(day: 15, minute: 1235, second: 5),
          shuubun: Remainder.new(day: 15, minute: 1235, second: 5),
          # 春分（しゅんぶん）・白露（はくろ）
          shunbun: Remainder.new(day: 15, minute: 2435, second: 5),
          hakuro: Remainder.new(day: 15, minute: 2435, second: 5),
          # 清明（せいめい）・処暑（しょしょ）
          seimei: Remainder.new(day: 15, minute: 3635, second: 5),
          shosho: Remainder.new(day: 15, minute: 3635, second: 5),
          # 穀雨（こくう）・立秋（りっしゅう）
          kokuu: Remainder.new(day: 15, minute: 4835, second: 5),
          risshuu: Remainder.new(day: 15, minute: 4835, second: 5),
          # 立夏（りっか）・大暑（たいしょ）
          rikka: Remainder.new(day: 15, minute: 5835, second: 5),
          taisho: Remainder.new(day: 15, minute: 5835, second: 5),
          # 小満（しょうまん）・小暑（しょうしょ）
          shouman: Remainder.new(day: 15, minute: 6835, second: 5),
          shousho: Remainder.new(day: 15, minute: 6835, second: 5),
          # 芒種（ぼうしゅ）・夏至（げし）
          boushu: Remainder.new(day: 15, minute: 7835, second: 5),
          geshi: Remainder.new(day: 15, minute: 7835, second: 5)
        }.freeze

        # @return [Array<Remainder>] 索引
        INDEXES = [
          LIST[:touji],      #  0
          LIST[:shoukan],    #  1
          LIST[:daikan],     #  2
          LIST[:risshun],    #  3
          LIST[:usui],       #  4
          LIST[:keichitsu],  #  5
          LIST[:shunbun],    #  6
          LIST[:seimei],     #  7
          LIST[:kokuu],      #  8
          LIST[:rikka],      #  9
          LIST[:shouman],    # 10
          LIST[:boushu],     # 11
          LIST[:geshi],      # 12
          LIST[:shousho],    # 13
          LIST[:taisho],     # 14
          LIST[:risshuu],    # 15
          LIST[:shosho],     # 16
          LIST[:hakuro],     # 17
          LIST[:shuubun],    # 18
          LIST[:kanro],      # 19
          LIST[:soukou],     # 20
          LIST[:rittou],     # 21
          LIST[:shousetsu],  # 22
          LIST[:taisetsu]    # 23
        ].freeze
      end

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
      # 二十四節気 と 補正値 を計算する
      #
      # @param [SolarTerm] solar_term 二十四節気
      #
      # @return [SolarTerm] 二十四節気
      # @return [Integer] 補正値
      #
      def self.calc_term_and_orbit_value(solar_term:)
        remainder = calc_solar_term_by_remainder(
          solar_term: solar_term
        )
        value = calc_sun_orbit_value(
          solar_term: remainder
        )
        [remainder, value]
      end

      # :reek:ControlParameter and :reek:BooleanParameter

      #
      # 二十四節気を計算する
      #
      # @param [SolarTerm] solar_term 二十四節気
      #
      # @return [SolarTerm] 二十四節気
      #
      def self.calc_solar_term_by_remainder(solar_term:)
        if solar_term.index.negative?
          return calc_first_solar_term(
            winter_solstice_age: solar_term.remainder
          )
        end

        calc_next_solar_term_recursively(
          solar_term: solar_term
        )
      end

      # :reek:TooManyStatements { max_statements: 8 }

      #
      # 入定気（定気の開始点からの日時）と属する定気を計算する
      #
      # @param [Remainder] winter_solstice_age 天正冬至
      #
      # @return [SolarTerm] 二十四節気
      #   SolarTerm.remainder : 入定気（定気の開始点からの日時）
      #   SolarTerm.index : 定気
      #
      def self.calc_first_solar_term(winter_solstice_age:)
        # 入定気の起算方法
        # 概要:
        #  * 太陽の運行による補正値は、二十四節気の気ごとに定められる
        #  * 11月経朔の前にある気を求め、それから11月経朔との間隔を求める
        #  * 気ごとの補正値と、気から11月経朔までにかかる補正値を求める
        # 前提:
        #  * 11月経朔に関わる二十四節気は、時系列から順に、小雪・大雪・冬至である
        #  * 小雪〜大雪の間隔は小雪定数で、大雪〜冬至の間隔は大雪定数で決められている（24気損益眺朒（ちょうじく）数のこと）
        #  * 11月経朔は、この小雪〜冬至の間のいずれかにある
        # 計算:
        # 2パターンある
        #  (a) 大雪〜冬至にある場合
        #   *「大雪定数 >= 天正閏余」の場合を指す
        #   * * NOTE 資料では「より大きい（>）」とされるが、大雪そのものの場合は大雪から起算すべき
        #   * この場合は、大雪〜経朔の間隔を求める
        #  (b) 小雪〜大雪にある場合
        #   *「大雪定数 < 天正閏余」の場合を指す
        #   * この場合は、小雪〜経朔の間隔を求める
        taisetsu = 23
        taisetsu_interval = Interval::INDEXES[taisetsu]

        if winter_solstice_age > taisetsu_interval
          # (b)
          shousetsu = 22
          diff = winter_solstice_age.sub(taisetsu_interval)

          return SolarTerm.new(remainder: Interval::INDEXES[shousetsu].sub(diff),
                               index: shousetsu)
        end
        # (a)
        SolarTerm.new(remainder: taisetsu_interval.sub(winter_solstice_age),
                      index: taisetsu)
      end

      # :reek:TooManyStatements { max_statements: 8 }

      #
      # 次の二十四節気を計算する
      #
      # @param [SolarTerm] solar_term 今回の二十四節気
      #
      # @return [SolarTerm] 次回の二十四節気
      #
      def self.calc_next_solar_term_recursively(solar_term:)
        remainder = solar_term.remainder
        index = solar_term.index
        interval = Interval::INDEXES[index]
        return solar_term if remainder < interval

        remainder.sub!(interval)
        index += 1
        index = 0 if index >= Interval::INDEXES.size
        calc_next_solar_term_recursively(
          solar_term: SolarTerm.new(remainder: remainder, index: index)
        )
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

        day_stack = calc_day_stack_from_ratio(sign: sign, ratio: ratio,
                                              minute: remainder.minute)

        day_stack
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
        month_stack = month_stack.negative? ? month_stack.ceil : month_stack.floor

        month_stack
      end
      private_class_method :calc_month_stack
    end
  end
end
