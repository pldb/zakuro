# frozen_string_literal: true

require_relative '../../cycle/solar_term'

require_relative '../../const/number'

# :nodoc:
module Zakuro
  # :nodoc:
  module Gihou
    # :nodoc:
    module Solar
      #
      # Adjustment 24気損益眺朒（ちょうじく）数
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
        MAP = {
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

        #
        # 24気損益眺朒（ちょうじく）数を特定する
        #
        # @param [Integer] index 連番（二十四節気）
        #
        # @return [Adjustment::Item] 24気損益眺朒（ちょうじく）数
        #
        def self.specify(index:)
          key = Cycle::SolarTerm::ORDER[index]
          Adjustment::MAP[key].clone
        end
      end
    end
  end
end
