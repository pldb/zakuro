# frozen_string_literal: true

# :nodoc:
module Zakuro
  # :nodoc:
  module Senmyou
    # :nodoc:
    module Solar
      #
      # Localization 入定気特定
      #
      # 入定気とは、太陽がどの二十四節気に属するか、またその二十四節気の開始点からどれだけ離れているかを示す
      #
      module Localization
        #
        # Interval 入気定日加減数（二十四節気の間隔）
        #
        module Interval
          # @return [Hash<Symbol, Cycle::Remainder>] 一覧
          MAP = {
            # 冬至（とうじ）・大雪（たいせつ）
            touji: Cycle::Remainder.new(day: 14, minute: 4235, second: 5),
            taisetsu: Cycle::Remainder.new(day: 14, minute: 4235, second: 5),
            # 小寒（しょうかん）・小雪（しょうせつ）
            shoukan: Cycle::Remainder.new(day: 14, minute: 5235, second: 5),
            shousetsu: Cycle::Remainder.new(day: 14, minute: 5235, second: 5),
            # 大寒（だいかん）・立冬（りっとう）
            daikan: Cycle::Remainder.new(day: 14, minute: 6235, second: 5),
            rittou: Cycle::Remainder.new(day: 14, minute: 6235, second: 5),
            # 立春（りっしゅん）・霜降（そうこう）
            risshun: Cycle::Remainder.new(day: 14, minute: 7235, second: 5),
            soukou: Cycle::Remainder.new(day: 14, minute: 7235, second: 5),
            # 雨水（うすい）・寒露（かんろ）
            usui: Cycle::Remainder.new(day: 15, minute: 35, second: 5),
            kanro: Cycle::Remainder.new(day: 15, minute: 35, second: 5),
            # 啓蟄（けいちつ）・秋分（しゅうぶん）
            keichitsu: Cycle::Remainder.new(day: 15, minute: 1235, second: 5),
            shuubun: Cycle::Remainder.new(day: 15, minute: 1235, second: 5),
            # 春分（しゅんぶん）・白露（はくろ）
            shunbun: Cycle::Remainder.new(day: 15, minute: 2435, second: 5),
            hakuro: Cycle::Remainder.new(day: 15, minute: 2435, second: 5),
            # 清明（せいめい）・処暑（しょしょ）
            seimei: Cycle::Remainder.new(day: 15, minute: 3635, second: 5),
            shosho: Cycle::Remainder.new(day: 15, minute: 3635, second: 5),
            # 穀雨（こくう）・立秋（りっしゅう）
            kokuu: Cycle::Remainder.new(day: 15, minute: 4835, second: 5),
            risshuu: Cycle::Remainder.new(day: 15, minute: 4835, second: 5),
            # 立夏（りっか）・大暑（たいしょ）
            rikka: Cycle::Remainder.new(day: 15, minute: 5835, second: 5),
            taisho: Cycle::Remainder.new(day: 15, minute: 5835, second: 5),
            # 小満（しょうまん）・小暑（しょうしょ）
            shouman: Cycle::Remainder.new(day: 15, minute: 6835, second: 5),
            shousho: Cycle::Remainder.new(day: 15, minute: 6835, second: 5),
            # 芒種（ぼうしゅ）・夏至（げし）
            boushu: Cycle::Remainder.new(day: 15, minute: 7835, second: 5),
            geshi: Cycle::Remainder.new(day: 15, minute: 7835, second: 5)
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

          def self.index_of(index)
            LIST[index]
          end

          def self.size
            LIST.size
          end
        end

        def self.index_of(index)
          Interval::LIST[index]
        end

        def self.size
          Interval::LIST.size
        end
      end
    end
  end
end
