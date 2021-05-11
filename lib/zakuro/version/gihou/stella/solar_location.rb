# frozen_string_literal: true

require_relative '../cycle/remainder'
require_relative '../cycle/solar_term'

# :nodoc:
module Zakuro
  # :nodoc:
  module Gihou
    #
    # SolarLocation 入定気演算
    #
    # 入定気とは、太陽がどの二十四節気に属するか、またその二十四節気の開始点からどれだけ離れているかを示す
    #
    module SolarLocation
      #
      # Interval 入気定日加減数（二十四節気の間隔）
      #
      module Interval
        # TODO: 『日本暦日原典』は正しい？雨水と啓蟄の順序が逆に見える

        # 気策： 15-292.5
        #
        # @return [Hash<Symbol, Remainder>] 一覧
        LIST = {
          # 冬至（とうじ）・大雪（たいせつ）
          touji: Cycle::Remainder.new(day: 15, minute: 1014, second: 5), # +722
          taisetsu: Cycle::Remainder.new(day: 15, minute: 1014, second: 5),
          # 小寒（しょうかん）・小雪（しょうせつ）
          shoukan: Cycle::Remainder.new(day: 15, minute: 910, second: 5), # +618
          shousetsu: Cycle::Remainder.new(day: 15, minute: 910, second: 5),
          # 大寒（だいかん）・立冬（りっとう）
          daikan: Cycle::Remainder.new(day: 15, minute: 806, second: 5), # +514
          rittou: Cycle::Remainder.new(day: 15, minute: 806, second: 5),
          # 立春（りっしゅん）・霜降（そうこう）
          risshun: Cycle::Remainder.new(day: 15, minute: 806, second: 5), # +514
          soukou: Cycle::Remainder.new(day: 15, minute: 806, second: 5),
          # 雨水（うすい）・寒露（かんろ）
          usui: Cycle::Remainder.new(day: 15, minute: 1014, second: 5), # +722
          kanro: Cycle::Remainder.new(day: 15, minute: 1014, second: 5),
          # 啓蟄（けいちつ）・秋分（しゅうぶん）
          keichitsu: Cycle::Remainder.new(day: 15, minute: 910, second: 5), # +618
          shuubun: Cycle::Remainder.new(day: 15, minute: 910, second: 5),
          # 春分（しゅんぶん）・白露（はくろ）
          shunbun: Cycle::Remainder.new(day: 14, minute: 910, second: 5), # -722
          hakuro: Cycle::Remainder.new(day: 14, minute: 910, second: 5),
          # 清明（せいめい）・処暑（しょしょ）
          seimei: Cycle::Remainder.new(day: 14, minute: 1014, second: 5), # -618
          shosho: Cycle::Remainder.new(day: 14, minute: 1014, second: 5),
          # 穀雨（こくう）・立秋（りっしゅう）
          kokuu: Cycle::Remainder.new(day: 14, minute: 1118, second: 5), # -514
          risshuu: Cycle::Remainder.new(day: 14, minute: 1118, second: 5),
          # 立夏（りっか）・大暑（たいしょ）
          rikka: Cycle::Remainder.new(day: 14, minute: 1118, second: 5), # -514
          taisho: Cycle::Remainder.new(day: 14, minute: 1118, second: 5),
          # 小満（しょうまん）・小暑（しょうしょ）
          shouman: Cycle::Remainder.new(day: 14, minute: 910, second: 5), # -722
          shousho: Cycle::Remainder.new(day: 14, minute: 910, second: 5),
          # 芒種（ぼうしゅ）・夏至（げし）
          boushu: Cycle::Remainder.new(day: 14, minute: 1014, second: 5), # -618
          geshi: Cycle::Remainder.new(day: 14, minute: 1014, second: 5)
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
      # 入定気を計算する
      #
      # * 定気（index）の指定がない場合は、11月の入定気を求める
      # * 定気（index）の指定がある場合は、大余小余から適切な入定気を再計算する
      #
      # @param [SolarTerm] solar_term 入定気
      #
      # @return [SolarTerm] 入定気
      #
      def self.get(solar_term:)
        if solar_term.invalid?
          return calc_first_solar_term(
            winter_solstice_age: solar_term.remainder
          )
        end

        calc_next_solar_term_recursively(
          solar_term: solar_term
        )
      end

      # :reek:TooManyStatements { max_statements: 7 }

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

        # NOTE: 上記パターンとは別に、稀だが立冬のパターンも存在する
        # この場合は比較方法はそのままに立冬〜経朔の間隔を求める

        rest = winter_solstice_age.clone
        # 大雪（23）/小雪（22）/立冬（21）
        [23, 22, 21].each do |index|
          solar_term = prev_solar_term(winter_solstice_age: rest, index: index)

          if solar_term.invalid?
            rest = solar_term.remainder
            next
          end

          return solar_term
        end

        # 立冬（21）を超える天正閏余は成立し得ない（1朔望月をはるかに超えることになる）
        raise ArgumentError.new, 'invalid winster solstice age'
      end
      private_class_method :calc_first_solar_term

      #
      # 入気定日加減数で入定気を遡る
      #
      # @param [Remainder] winter_solstice_age 天正冬至
      # @param [Integer] index 二十四節気の連番
      #
      # @return [SolarTerm] 二十四節気
      #   SolarTerm.remainder : 入定気（定気の開始点からの日時）
      #   SolarTerm.index : 定気（範囲外であれば-1とする）
      #
      def self.prev_solar_term(winter_solstice_age:, index:)
        interval = Interval::INDEXES[index]
        if winter_solstice_age > interval
          # 入定気が確定しない（さらに前の定気まで遡れる）
          return Cycle::SolarTerm.new(
            remainder: winter_solstice_age.sub(interval),
            index: -1
          )
        end

        # 入定気が確定する
        Cycle::SolarTerm.new(
          remainder: interval.sub(winter_solstice_age),
          index: index
        )
      end
      private_class_method :prev_solar_term

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
          solar_term: Cycle::SolarTerm.new(remainder: remainder, index: index)
        )
      end
      private_class_method :calc_next_solar_term_recursively
    end
  end
end