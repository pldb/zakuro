# frozen_string_literal: true

require_relative '../../const/number'

# :nodoc:
module Zakuro
  # :nodoc:
  module Daien
    # :nodoc:
    module Lunar
      #
      # Adjustment 補正値情報
      #
      module Adjustment
        # 『歴代天文律暦等志彙編　七』中華書房 p.2230
        #
        # 遠/近の地点での中間
        #
        # @return [Hash<Integer>] 遠/近の地点での中間
        DAY_LIMIT = {
          7 => 2701,
          14 => 2363,
          21 => 2024,
          28 => 1686
        }.freeze

        #
        # Row 行情報
        #
        class Row
          # @return [Integer] 入暦（1-14）
          attr_reader :day
          # @return [Range] 小余範囲
          attr_reader :range
          # @return [Value] 補正値
          attr_reader :value

          #
          # 初期化
          #
          # @param [Integer] day 入暦（1-14）
          # @param [Range] range 小余範囲
          # @param [Value] value 補正値
          #
          def initialize(day:, range:, value:)
            @day = day
            @range = range
            @value = value
          end

          # :reek:ControlParameter

          #
          # 一致するか
          #
          # @param [Integer] day 入暦（1-14）
          # @param [Integer] minute 小余
          #
          # @return [True] 一致
          # @return [False] 不一致
          #
          def match?(day:, minute:)
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
          # @return [Integer] 増減率
          attr_reader :per
          # @return [Integer] 遅速積
          attr_reader :stack

          #
          # 初期化
          #
          # @param [Integer] per 増減率
          # @param [Integer] stack 遅速積
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

        # 『歴代天文律暦等志彙編　七』中華書房 p.2228-2230
        #
        # @note 7日、14日、21日、28日の小余は DAY_LIMIT を参照のこと
        #
        # @return [Array<Row>] 月の補正値情報
        #
        LIST = [
          Row.new(day: 1, range: Range.new, value: Value.new(per: +296, stack: 0)),
          Row.new(day: 2, range: Range.new, value: Value.new(per: +259, stack: +297)),
          Row.new(day: 3, range: Range.new, value: Value.new(per: +220, stack: +556)),
          Row.new(day: 4, range: Range.new, value: Value.new(per: +180, stack: +776)),
          Row.new(day: 5, range: Range.new, value: Value.new(per: +139, stack: +956)),
          Row.new(day: 6, range: Range.new, value: Value.new(per: +97, stack: +1095)),
          Row.new(day: 7, range: Range.new(max: DAY_LIMIT[7]), value: Value.new(per: +48, stack: +1192)),
          Row.new(day: 7, range: Range.new(min: DAY_LIMIT[7]), value: Value.new(per: -6, stack: +1240)), # stack: +1192 + 48
          Row.new(day: 8, range: Range.new, value: Value.new(per: -64, stack: +1234)),
          Row.new(day: 9, range: Range.new, value: Value.new(per: -106, stack: +1170)),
          Row.new(day: 10, range: Range.new, value: Value.new(per: -148, stack: +1064)),
          Row.new(day: 11, range: Range.new, value: Value.new(per: -189, stack: +916)),
          Row.new(day: 12, range: Range.new, value: Value.new(per: -229, stack: +727)),
          Row.new(day: 13, range: Range.new, value: Value.new(per: -267, stack: +498)),
          Row.new(day: 14, range: Range.new(max: DAY_LIMIT[14]), value: Value.new(per: -231, stack: +231)),
          Row.new(day: 14, range: Range.new(min: DAY_LIMIT[14]), value: Value.new(per: -66, stack: 0)), # stack: +232 - 231
          Row.new(day: 15, range: Range.new, value: Value.new(per: -289, stack: -66)),
          Row.new(day: 16, range: Range.new, value: Value.new(per: -250, stack: -355)),
          Row.new(day: 17, range: Range.new, value: Value.new(per: -211, stack: -605)),
          Row.new(day: 18, range: Range.new, value: Value.new(per: -171, stack: -816)),
          Row.new(day: 19, range: Range.new, value: Value.new(per: -130, stack: -987)),
          Row.new(day: 20, range: Range.new, value: Value.new(per: -87, stack: -1117)),
          Row.new(day: 21, range: Range.new(max: DAY_LIMIT[21]), value: Value.new(per: -36, stack: -1204)),
          Row.new(day: 21, range: Range.new(min: DAY_LIMIT[21]), value: Value.new(per: +18, stack: -1240)), # stack: -1204 - 36
          Row.new(day: 22, range: Range.new, value: Value.new(per: +73, stack: -1222)),
          Row.new(day: 23, range: Range.new, value: Value.new(per: +116, stack: -1149)),
          Row.new(day: 24, range: Range.new, value: Value.new(per: +157, stack: -1033)),
          Row.new(day: 25, range: Range.new, value: Value.new(per: +198, stack: -876)),
          Row.new(day: 26, range: Range.new, value: Value.new(per: +237, stack: -678)),
          Row.new(day: 27, range: Range.new, value: Value.new(per: +276, stack: -441)),
          Row.new(day: 28, range: Range.new(max: DAY_LIMIT[28]), value: Value.new(per: +165, stack: -165))
        ].freeze
        # rubocop:enable Layout/LineLength

        #
        # 月軌道の補正に必要な基本値を引き当てる
        #
        # @param [True, False] forward 進（遠地点より数える）/退（近地点より数える）
        # @param [Integer] day 大余
        # @param [Integer] minute 小余
        #
        # @return [Row] 補正値
        #
        def self.specify(day:, minute:)
          LIST.each do |row|
            # NOTE: 範囲が重複している場合、最初に引き当てたほうを優先する
            return row if row.match?(day: day, minute: minute)
          end

          raise ArgumentError.new, "invalid parameter: #{day}/#{minute}"
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
          limit = DAY_LIMIT.fetch(day, -1)
          # 該当なし
          return minute if limit == -1

          return minute unless minute > limit

          minute - limit
        end
      end
    end
  end
end
