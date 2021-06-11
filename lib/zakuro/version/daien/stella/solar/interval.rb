# frozen_string_literal: true

# :nodoc:
module Zakuro
  # :nodoc:
  module Daien
    # :nodoc:
    module Solar
      #
      # Interval 入気定日加減数（二十四節気の間隔）
      #
      module Interval
        #
        # 気策の 15-292.5 を加減する
        #
        # @note 『日本暦日原典』は雨水と啓蟄が逆になっていたのでこれを改めた
        #
        # @return [Hash<Symbol, Cycle::Remainder>] 一覧
        MAP = {
          # 冬至（とうじ）・大雪（たいせつ）
          touji: Cycle::Remainder.new(day: 14, minute: 910, second: 5), # -722
          taisetsu: Cycle::Remainder.new(day: 14, minute: 910, second: 5),
          # 小寒（しょうかん）・小雪（しょうせつ）
          shoukan: Cycle::Remainder.new(day: 14, minute: 1014, second: 5), # -618
          shousetsu: Cycle::Remainder.new(day: 14, minute: 1014, second: 5),
          # 大寒（だいかん）・立冬（りっとう）
          daikan: Cycle::Remainder.new(day: 14, minute: 1118, second: 5), # -514
          rittou: Cycle::Remainder.new(day: 14, minute: 1118, second: 5),
          # 立春（りっしゅん）・霜降（そうこう）
          risshun: Cycle::Remainder.new(day: 14, minute: 1118, second: 5), # -514
          soukou: Cycle::Remainder.new(day: 14, minute: 1118, second: 5),
          # 雨水（うすい）・寒露（かんろ）
          usui: Cycle::Remainder.new(day: 14, minute: 1014, second: 5), # -618
          kanro: Cycle::Remainder.new(day: 14, minute: 1014, second: 5),
          # 啓蟄（けいちつ）・秋分（しゅうぶん）
          keichitsu: Cycle::Remainder.new(day: 14, minute: 910, second: 5), # -722
          shuubun: Cycle::Remainder.new(day: 14, minute: 910, second: 5),
          # 春分（しゅんぶん）・白露（はくろ）
          shunbun: Cycle::Remainder.new(day: 15, minute: 1014, second: 5), # +722
          hakuro: Cycle::Remainder.new(day: 15, minute: 1014, second: 5),
          # 清明（せいめい）・処暑（しょしょ）
          seimei: Cycle::Remainder.new(day: 15, minute: 910, second: 5), # +618
          shosho: Cycle::Remainder.new(day: 15, minute: 910, second: 5),
          # 穀雨（こくう）・立秋（りっしゅう）
          kokuu: Cycle::Remainder.new(day: 15, minute: 806, second: 5), # +514
          risshuu: Cycle::Remainder.new(day: 15, minute: 806, second: 5),
          # 立夏（りっか）・大暑（たいしょ）
          rikka: Cycle::Remainder.new(day: 15, minute: 806, second: 5), # +514
          taisho: Cycle::Remainder.new(day: 15, minute: 806, second: 5),
          # 小満（しょうまん）・小暑（しょうしょ）
          shouman: Cycle::Remainder.new(day: 15, minute: 910, second: 5), # +618
          shousho: Cycle::Remainder.new(day: 15, minute: 910, second: 5),
          # 芒種（ぼうしゅ）・夏至（げし）
          boushu: Cycle::Remainder.new(day: 15, minute: 1014, second: 5), # +722
          geshi: Cycle::Remainder.new(day: 15, minute: 1014, second: 5)
        }.freeze

        # @return [Array<Remainder>] 索引
        LIST = [
          MAP[:touji],      #  0
          MAP[:shoukan],    #  1
          MAP[:daikan],     #  2
          MAP[:risshun],    #  3
          MAP[:usui],       #  4
          MAP[:keichitsu],  #  5
          MAP[:shunbun],    #  6
          MAP[:seimei],     #  7
          MAP[:kokuu],      #  8
          MAP[:rikka],      #  9
          MAP[:shouman],    # 10
          MAP[:boushu],     # 11
          MAP[:geshi],      # 12
          MAP[:shousho],    # 13
          MAP[:taisho],     # 14
          MAP[:risshuu],    # 15
          MAP[:shosho],     # 16
          MAP[:hakuro],     # 17
          MAP[:shuubun],    # 18
          MAP[:kanro],      # 19
          MAP[:soukou],     # 20
          MAP[:rittou],     # 21
          MAP[:shousetsu],  # 22
          MAP[:taisetsu]    # 23
        ].freeze

        #
        # 入気定日加減数を引き当てる
        #
        # @param [Integer] index 二十四節気番号
        #
        # @return [Cycle::Remainder] 入気定日加減数
        #
        def self.index_of(index)
          LIST[index]
        end

        #
        # 入気定日加減数の総数を返す
        #
        # @return [Integer] 入気定日加減数の総数
        #
        def self.size
          LIST.size
        end
      end
    end
  end
end
