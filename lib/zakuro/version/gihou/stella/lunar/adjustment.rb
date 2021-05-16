# frozen_string_literal: true

require_relative '../../const/number'

# :nodoc:
module Zakuro
  # :nodoc:
  module Gihou
    # :nodoc:
    module Lunar
      #
      # Adjustment 補正値情報
      #
      module Adjustment
        # @return [Integer] 遠/近の地点での中間
        HALF_DAYS = [7].freeze

        #
        # Row 行情報
        #
        class Row
          # @return [True] 進（遠地点より数える）
          # @return [False] 退（近地点より数える）
          attr_reader :forward
          # @return [Integer] 入暦（1-14）
          attr_reader :day
          # @return [Range] 小余範囲
          attr_reader :range
          # @return [Value] 補正値
          attr_reader :value

          #
          # 初期化
          #
          # @param [True, False] forward 進（遠地点より数える）/退（近地点より数える）
          # @param [Integer] day 入暦（1-14）
          # @param [Range] range 小余範囲
          # @param [Value] value 補正値
          #
          def initialize(forward:, day:, range:, value:)
            @forward = forward
            @day = day
            @range = range
            @value = value
          end

          # :reek:ControlParameter

          #
          # 一致するか
          #
          # @param [True, False] forward 進（遠地点より数える）/退（近地点より数える）
          # @param [Integer] day 入暦（1-14）
          # @param [Integer] minute 小余
          #
          # @return [True] 一致
          # @return [False] 不一致
          #
          def match?(forward:, day:, minute:)
            return false unless @forward == forward

            return false unless @day == day

            return false unless @range.include?(minute: minute)

            true
          end

          #
          # 分母を返す
          #
          # @return [Integer] 分母
          #
          def denominator
            @range.denominator
          end
        end

        #
        # Range 小余範囲
        #
        class Range
          # @return [Integer] 下限
          MIN = 0
          # @return [Integer] 上限
          MAX = Const::Number::Cycle::DAY
          # @return [Integer] 遠/近の地点での中間
          HALF = 7465
          # @return [Integer] 各地点の最後
          LAST = 6529

          # @return [Integer] 下限
          attr_reader :min
          # @return [Integer] 上限
          attr_reader :max

          #
          # 初期化
          #
          # @param [Integer] min 下限
          # @param [Integer] max 上限
          #
          def initialize(min: MIN, max: MAX)
            @min = min
            @max = max
          end

          #
          # 含まれるか
          #
          # @param [Integer] minute 小余
          #
          # @return [True] 含まれる
          # @return [False] 含まれない
          #
          def include?(minute:)
            minute >= @min && minute <= @max
          end

          #
          # 分母を返す
          #
          # @return [Integer] 分母
          #
          def denominator
            @max - @min
          end
        end

        #
        # Value 補正値
        #
        class Value
          # @return [Integer] 損益率
          attr_reader :per
          # @return [Integer] 眺朒（ちょうじく）積
          attr_reader :stack

          #
          # 初期化
          #
          # @param [Integer] per 損益率
          # @param [Integer] stack 眺朒（ちょうじく）積
          #
          def initialize(per:, stack:)
            @per = per
            @stack = stack
          end

          #
          # 文字化
          #
          # @return [String] 文字
          #
          def to_s
            "per:#{@per}, stack:#{@stack}"
          end
        end

        # rubocop:disable Layout/LineLength

        #
        # @return [Array<Row>] 月の補正値情報
        #
        LIST = [
          Row.new(forward: true, day: 1, range: Range.new, value: Value.new(per: +830, stack: 0)),
          Row.new(forward: true, day: 2, range: Range.new, value: Value.new(per: +726, stack: +830)),
          Row.new(forward: true, day: 3, range: Range.new, value: Value.new(per: +606, stack: +1556)),
          Row.new(forward: true, day: 4, range: Range.new, value: Value.new(per: +471, stack: +2162)),
          Row.new(forward: true, day: 5, range: Range.new, value: Value.new(per: +337, stack: +2633)),
          Row.new(forward: true, day: 6, range: Range.new, value: Value.new(per: +202, stack: +2970)),
          Row.new(forward: true, day: 7, range: Range.new(max: Range::HALF), value: Value.new(per: +53, stack: +3172)),
          Row.new(forward: true, day: 7, range: Range.new(min: Range::HALF), value: Value.new(per: -7, stack: +3225)), # +3172 + 53（初益）
          Row.new(forward: true, day: 8, range: Range.new, value: Value.new(per: -82, stack: +3218)),
          Row.new(forward: true, day: 9, range: Range.new, value: Value.new(per: -224, stack: +3136)),
          Row.new(forward: true, day: 10, range: Range.new, value: Value.new(per: -366, stack: +2912)),
          Row.new(forward: true, day: 11, range: Range.new, value: Value.new(per: -509, stack: +2546)),
          Row.new(forward: true, day: 12, range: Range.new, value: Value.new(per: -643, stack: +2037)),
          Row.new(forward: true, day: 13, range: Range.new, value: Value.new(per: -748, stack: +1394)),
          Row.new(forward: true, day: 14, range: Range.new(max: Range::LAST), value: Value.new(per: -646, stack: +646)), # 14日の小余は常に6529以下
          Row.new(forward: false, day: 1, range: Range.new, value: Value.new(per: -830, stack: 0)),
          Row.new(forward: false, day: 2, range: Range.new, value: Value.new(per: -726, stack: -830)),
          Row.new(forward: false, day: 3, range: Range.new, value: Value.new(per: -598, stack: -1556)),
          Row.new(forward: false, day: 4, range: Range.new, value: Value.new(per: -464, stack: -2154)),
          Row.new(forward: false, day: 5, range: Range.new, value: Value.new(per: -329, stack: -2618)),
          Row.new(forward: false, day: 6, range: Range.new, value: Value.new(per: -195, stack: -2947)),
          Row.new(forward: false, day: 7, range: Range.new(max: Range::HALF), value: Value.new(per: -53, stack: -3142)),
          Row.new(forward: false, day: 7, range: Range.new(min: Range::HALF), value: Value.new(per: +7, stack: -3195)), # -3142 - 53（初益）
          Row.new(forward: false, day: 8, range: Range.new, value: Value.new(per: +82, stack: -3188)),
          Row.new(forward: false, day: 9, range: Range.new, value: Value.new(per: +225, stack: -3106)),
          Row.new(forward: false, day: 10, range: Range.new, value: Value.new(per: +366, stack: -2881)),
          Row.new(forward: false, day: 11, range: Range.new, value: Value.new(per: +501, stack: -2515)),
          Row.new(forward: false, day: 12, range: Range.new, value: Value.new(per: +628, stack: -2014)),
          Row.new(forward: false, day: 13, range: Range.new, value: Value.new(per: +740, stack: -1386)),
          Row.new(forward: false, day: 14, range: Range.new(max: Range::LAST), value: Value.new(per: +646, stack: -646)) # 14日の小余は常に6529以下
        ].freeze
        # rubocop:enable Layout/LineLength

        # TODO: 現行の宣明暦の処理を下記の値に差し替える
        #
        # # @return [Array<Item>] 月の補正値
        # # @note キーは複合キーであり、以下のパターンに対応する
        # #  * 変日（1-28）
        # #  * 小余（0-1340）
        # # TODO: 7、14、21日の小余の境界が分からない。『日本暦日原典』に記載がない
        # #       仮置きとして 1190 を置いた
        # #       宣明暦[7465（初益）/ 8400（統法）] * 1340（総法） = 1190.84523..
        # # TODO: 28日は変日の範囲内743とした。
        # #       宣明暦では 進退 14-6529（1始まりなので実質13） * 2 = 27-4658 で、
        # #       これは 暦周 27-4658.19 に一致する。変日27-743.1と同等とみなした
        # LIST = {
        #   key_01_0000_1340: Item.new(per: -134, stack: 0),
        #   key_02_0000_1340: Item.new(per: -117, stack: -134),
        #   key_03_0000_1340: Item.new(per: -99, stack: -251),
        #   key_04_0000_1340: Item.new(per: -78, stack: -350),
        #   key_05_0000_1340: Item.new(per: -56, stack: -428),
        #   key_06_0000_1340: Item.new(per: -33, stack: -484),
        #   key_07_0000_1190: Item.new(per: -9, stack: -517),
        #   key_07_1190_1340: Item.new(per: 0, stack: -526),
        #   key_08_0000_1340: Item.new(per: +14, stack: -526),
        #   key_09_0000_1340: Item.new(per: +38, stack: -512),
        #   key_10_0000_1340: Item.new(per: +62, stack: -474),
        #   key_11_0000_1340: Item.new(per: +85, stack: -412),
        #   key_12_0000_1340: Item.new(per: +104, stack: -327),
        #   key_13_0000_1340: Item.new(per: +121, stack: -223),
        #   key_14_0000_1190: Item.new(per: +102, stack: -102),
        #   key_14_1190_1340: Item.new(per: +29, stack: 0),
        #   key_15_0000_1340: Item.new(per: +128, stack: +29),
        #   key_16_0000_1340: Item.new(per: +115, stack: +157),
        #   key_17_0000_1340: Item.new(per: +95, stack: +272),
        #   key_18_0000_1340: Item.new(per: +74, stack: +367),
        #   key_19_0000_1340: Item.new(per: +52, stack: +441),
        #   key_20_0000_1340: Item.new(per: +28, stack: +493),
        #   key_21_0000_1190: Item.new(per: +4, stack: +521),
        #   key_21_1190_1340: Item.new(per: 0, stack: +525),
        #   key_22_0000_1340: Item.new(per: -20, stack: +525),
        #   key_23_0000_1340: Item.new(per: -44, stack: +505),
        #   key_24_0000_1340: Item.new(per: -68, stack: +461),
        #   key_25_0000_1340: Item.new(per: -89, stack: +393),
        #   key_26_0000_1340: Item.new(per: -108, stack: +304),
        #   key_27_0000_1340: Item.new(per: -125, stack: +196),
        #   key_28_0000_0743: Item.new(per: -71, stack: +71)
        # }.freeze

        #
        # 月軌道の補正に必要な基本値を引き当てる
        #
        # @param [True, False] forward 進（遠地点より数える）/退（近地点より数える）
        # @param [Integer] day 大余
        # @param [Integer] minute 小余
        #
        # @return [Row] 補正値
        #
        def self.specify(forward:, day:, minute:)
          LIST.each do |row|
            # NOTE: 範囲が重複している場合、最初に引き当てたほうを優先する
            return row if row.match?(forward: forward, day: day, minute: minute)
          end

          raise ArgumentError.new, "invalid parameter: #{forward}/#{day}/#{minute}"
        end

        # :reek:ControlParameter

        #
        # 小余の下げ幅を求める
        #
        # @param [Integer] day 大余
        # @param [Integer] minute 小余
        #
        # @return [Integer] 小余の下げ幅
        #
        def self.minus_minute(day:, minute:)
          return minute unless HALF_DAYS.include?(day)

          return minute unless minute > Range::HALF

          minute - Range::HALF
        end
      end
    end
  end
end
