# frozen_string_literal: true

require_relative '../../cycle/solar_term'

require_relative '../../const/number'

# :nodoc:
module Zakuro
  # :nodoc:
  module Daien
    # :nodoc:
    module Solar
      #
      # Adjustment 24気損益眺朒（ちょうじく）数
      #
      module Adjustment
        #
        # Row 行データ
        #
        class Row
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

        # @return [Array<Row>] 24気損益眺朒（ちょうじく）数
        MAP = {
          touji: Row.new(stack: 0.0, per_term: +13.4524, per_day: -0.1886),        # 冬至（とうじ）
          shoukan: Row.new(stack: +176.0, per_term: +10.5564, per_day: -0.1634),   # 小寒（しょうかん）
          daikan: Row.new(stack: +314.0, per_term: +8.0408, per_day: -0.1446),     # 大寒（だいかん）
          risshun: Row.new(stack: +418.0, per_term: +5.8160, per_day: -0.1318),    # 立春（りっしゅん）
          usui: Row.new(stack: +491.0, per_term: +3.7987, per_day: -0.1240),       # 雨水（うすい）
          keichitsu: Row.new(stack: +535.0, per_term: +1.9265, per_day: -0.1240),  # 啓蟄（けいちつ）
          shunbun: Row.new(stack: +551.0, per_term: -0.2048, per_day: -0.1178),    # 春分（しゅんぶん）
          seimei: Row.new(stack: +535.0, per_term: -1.9968, per_day: -0.1190),     # 清明（せいめい）
          kokuu: Row.new(stack: +491.0, per_term: -3.7956, per_day: -0.1240),      # 穀雨（こくう）
          rikka: Row.new(stack: +418.0, per_term: -5.6626, per_day: -0.1324),      # 立夏（りっか）
          shouman: Row.new(stack: +314.0, per_term: -7.6555, per_day: -0.1436),    # 小満（しょうまん）
          boushu: Row.new(stack: +176.0, per_term: -9.9405, per_day: -0.1436),     # 芒種（ぼうしゅ）
          geshi: Row.new(stack: 0.0, per_term: -12.0819, per_day: +0.1436),        # 夏至（げし）
          shousho: Row.new(stack: -176.0, per_term: -9.7018, per_day: +0.1324),    # 小暑（しょうしょ）
          taisho: Row.new(stack: -314.0, per_term: -7.5450, per_day: +0.1240),     # 大暑（たいしょ）
          risshuu: Row.new(stack: -418.0, per_term: -5.5634, per_day: +0.1190),    # 立秋（りっしゅう）
          shosho: Row.new(stack: -491.0, per_term: -3.7038, per_day: +0.1178),     # 処暑（しょしょ）
          hakuro: Row.new(stack: -535.0, per_term: -1.8954, per_day: +0.1178),     # 白露（はくろ）
          shuubun: Row.new(stack: -551.0, per_term: +0.1783, per_day: +0.1240),    # 秋分（しゅうぶん）
          kanro: Row.new(stack: -535.0, per_term: +2.0042, per_day: +0.1318),      # 寒露（かんろ）
          soukou: Row.new(stack: -491.0, per_term: +3.8950, per_day: +0.1446),     # 霜降（そうこう）
          rittou: Row.new(stack: -418.0, per_term: +5.9214, per_day: +0.1634),     # 立冬（りっとう）
          shousetsu: Row.new(stack: -314.0, per_term: +8.1610, per_day: +0.1886),  # 小雪（しょうせつ）
          taisetsu: Row.new(stack: -176.0, per_term: +10.9010, per_day: +0.1886)   # 大雪（たいせつ）
        }.freeze

        class << self
          #
          # 24気損益眺朒（ちょうじく）数の行データを特定する
          #
          # @param [Integer] index 連番（二十四節気）
          #
          # @return [Row] 行データ
          #
          def specify(index:)
            key = Cycle::SolarTerm::ORDER[index]
            Adjustment::MAP[key].clone
          end
        end
      end
    end
  end
end
