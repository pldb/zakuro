# frozen_string_literal: true

# :nodoc:
module Zakuro
  # :nodoc:
  module Version
    # :nodoc:
    module Daien
      # :nodoc:
      module Solar
        #
        # Interval 入気定日加減数（二十四節気の間隔）
        #
        module Interval
          #
          # 気策の 15-664.7 を加減する
          #
          # @note 『歴代天文律暦等志彙編　七』中華書房 p.2224 盈縮分の行で加減した
          #
          # @return [Hash<Symbol, Cycle::Remainder>] 一覧
          MAP = {
            # 冬至（とうじ）・大雪（たいせつ）
            touji: Cycle::Remainder.new(day: 14, minute: 1351, second: 7), # -2353
            taisetsu: Cycle::Remainder.new(day: 14, minute: 1351, second: 7),
            # 小寒（しょうかん）・小雪（しょうせつ）
            shoukan: Cycle::Remainder.new(day: 14, minute: 1859, second: 7), # -1845
            shousetsu: Cycle::Remainder.new(day: 14, minute: 1859, second: 7),
            # 大寒（だいかん）・立冬（りっとう）
            daikan: Cycle::Remainder.new(day: 14, minute: 2314, second: 7), # -1390
            rittou: Cycle::Remainder.new(day: 14, minute: 2314, second: 7),
            # 立春（りっしゅん）・霜降（そうこう）
            risshun: Cycle::Remainder.new(day: 14, minute: 2728, second: 7), # -976
            soukou: Cycle::Remainder.new(day: 14, minute: 2728, second: 7),
            # 雨水（うすい）・寒露（かんろ）
            usui: Cycle::Remainder.new(day: 15, minute: 76, second: 7), # -588
            kanro: Cycle::Remainder.new(day: 15, minute: 76, second: 7),
            # 啓蟄（けいちつ）・秋分（しゅうぶん）
            keichitsu: Cycle::Remainder.new(day: 15, minute: 450, second: 7), # -214
            shuubun: Cycle::Remainder.new(day: 15, minute: 450, second: 7),
            # 春分（しゅんぶん）・白露（はくろ）
            shunbun: Cycle::Remainder.new(day: 15, minute: 878, second: 7), # +214
            hakuro: Cycle::Remainder.new(day: 15, minute: 878, second: 7),
            # 清明（せいめい）・処暑（しょしょ）
            seimei: Cycle::Remainder.new(day: 15, minute: 1252, second: 7), # +588
            shosho: Cycle::Remainder.new(day: 15, minute: 1252, second: 7),
            # 穀雨（こくう）・立秋（りっしゅう）
            kokuu: Cycle::Remainder.new(day: 15, minute: 1640, second: 7), # +976
            risshuu: Cycle::Remainder.new(day: 15, minute: 1640, second: 7),
            # 立夏（りっか）・大暑（たいしょ）
            rikka: Cycle::Remainder.new(day: 15, minute: 2054, second: 7), # +1390
            taisho: Cycle::Remainder.new(day: 15, minute: 2054, second: 7),
            # 小満（しょうまん）・小暑（しょうしょ）
            shouman: Cycle::Remainder.new(day: 15, minute: 2509, second: 7), # +1845
            shousho: Cycle::Remainder.new(day: 15, minute: 2509, second: 7),
            # 芒種（ぼうしゅ）・夏至（げし）
            boushu: Cycle::Remainder.new(day: 15, minute: 3017, second: 7), # +2353
            geshi: Cycle::Remainder.new(day: 15, minute: 3017, second: 7)
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

          class << self
            #
            # 入気定日加減数を引き当てる
            #
            # @param [Integer] index 二十四節気番号
            #
            # @return [Cycle::Remainder] 入気定日加減数
            #
            def index_of(index)
              LIST[index]
            end

            #
            # 入気定日加減数の総数を返す
            #
            # @return [Integer] 入気定日加減数の総数
            #
            def size
              LIST.size
            end
          end
        end
      end
    end
  end
end
