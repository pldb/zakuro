# frozen_string_literal: true

require_relative '../../cycle/solar_term'

require_relative '../../const/number'

# :nodoc:
module Zakuro
  # :nodoc:
  module Senmyou
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
          touji: Row.new(stack: 0.0, per_term: +33.4511, per_day: -0.3695),        # 冬至（とうじ）
          shoukan: Row.new(stack: +449.0, per_term: +28.0389, per_day: -0.3606),   # 小寒（しょうかん）
          daikan: Row.new(stack: +823.0, per_term: +22.6998, per_day: -0.3519),    # 大寒（だいかん）
          risshun: Row.new(stack: +1122.0, per_term: +17.8923, per_day: -0.4068),  # 立春（りっしゅん）
          usui: Row.new(stack: +1346.0, per_term: +11.7966, per_day: -0.3998),     # 雨水（うすい）
          keichitsu: Row.new(stack: +1481.0, per_term: +5.7986, per_day: -0.3998), # 啓蟄（けいちつ）
          shunbun: Row.new(stack: +1526.0, per_term: -0.2433, per_day: -0.3779),   # 春分（しゅんぶん）
          seimei: Row.new(stack: +1481.0, per_term: -6.1254, per_day: -0.3634),    # 清明（せいめい）
          kokuu: Row.new(stack: +1346.0, per_term: -12.2048, per_day: -0.2987),    # 穀雨（こくう）
          rikka: Row.new(stack: +1122.0, per_term: -16.9060, per_day: -0.2919),    # 立夏（りっか）
          shouman: Row.new(stack: +823.0, per_term: -21.5362, per_day: -0.2854),   # 小満（しょうまん）
          boushu: Row.new(stack: +449.0, per_term: -26.0498, per_day: -0.2854),    # 芒種（ぼうしゅ）
          geshi: Row.new(stack: 0.0, per_term: -30.3119, per_day: +0.2854),        # 夏至（げし）
          shousho: Row.new(stack: -449.0, per_term: -25.8126, per_day: +0.2919),   # 小暑（しょうしょ）
          taisho: Row.new(stack: -823.0, per_term: -21.2454, per_day: +0.2987),    # 大暑（たいしょ）
          risshuu: Row.new(stack: -1122.0, per_term: -17.0296, per_day: +0.3634),  # 立秋（りっしゅう）
          shosho: Row.new(stack: -1346.0, per_term: -11.4744, per_day: +0.3779),   # 処暑（しょしょ）
          hakuro: Row.new(stack: -1481.0, per_term: -5.6429, per_day: +0.3779),    # 白露（はくろ）
          shuubun: Row.new(stack: -1526.0, per_term: +0.1432, per_day: +0.3998),   # 秋分（しゅうぶん）
          kanro: Row.new(stack: -1481.0, per_term: +6.1488, per_day: +0.4068),     # 寒露（かんろ）
          soukou: Row.new(stack: -1346.0, per_term: +12.6336, per_day: +0.3519),   # 霜降（そうこう）
          rittou: Row.new(stack: -1122.0, per_term: +17.8043, per_day: +0.3606),   # 立冬（りっとう）
          shousetsu: Row.new(stack: -823.0, per_term: +23.0590, per_day: +0.3695), # 小雪（しょうせつ）
          taisetsu: Row.new(stack: -449.0, per_term: +28.4618, per_day: +0.3695)   # 大雪（たいせつ）
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
