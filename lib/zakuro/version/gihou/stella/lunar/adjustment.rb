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
        #
        # 遠/近の地点での中間
        #
        # 7、14、21日の小余の境界は下記のようにして求めた
        #   * 宣明暦の7日の小余は7465である。入暦は1始まりなので、0始まりで表現すると 6-7465 となる
        #   * 6 * 8400（統法） + 7465（初益） = 57865
        #   * これを儀鳳暦に変えると、 57865 / 1340（総法） = 6 余り 1190.845238..
        #   * これを入暦の1始まりに置き換え、少数部を消すと 7-1190、これが7日目となる
        #   * 同様の方法で14日と21日も求める
        #   * 57865 * 2 = 115730 / 1340（総法） = 13 余り 1041.690476 = 14-1041
        #   * 57865 * 3 = 173595 / 1340（総法） = 20 余り 892.5357143 = 21-892
        #
        # @return [Hash<Integer>] 遠/近の地点での中間
        HALF_DAYS = {
          7 => 1190,
          14 => 1041,
          21 => 892
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
          # @return [Integer] 最後
          LAST = 743

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

        # * 7日、14日、21日の小余は HALF_DAYS を参照のこと
        # * 28日は変日の範囲内743とした。
        #   宣明暦では 進退 14-6529（1始まりなので実質13） * 2 = 27-4658 で、
        #   これは 暦周 27-4658.19 に一致する。変日27-743.1と同等とみなした

        #
        # @return [Array<Row>] 月の補正値情報
        #
        LIST = [
          Row.new(day: 1, range: Range.new, value: Value.new(per: -134, stack: 0)),
          Row.new(day: 2, range: Range.new, value: Value.new(per: -117, stack: -134)),
          Row.new(day: 3, range: Range.new, value: Value.new(per: -99, stack: -251)),
          Row.new(day: 4, range: Range.new, value: Value.new(per: -78, stack: -350)),
          Row.new(day: 5, range: Range.new, value: Value.new(per: -56, stack: -428)),
          Row.new(day: 6, range: Range.new, value: Value.new(per: -33, stack: -484)),
          Row.new(day: 7, range: Range.new(max: HALF_DAYS[7]), value: Value.new(per: -9, stack: -517)),
          Row.new(day: 7, range: Range.new(min: HALF_DAYS[7]), value: Value.new(per: 0, stack: -526)),
          Row.new(day: 8, range: Range.new, value: Value.new(per: +14, stack: -526)),
          Row.new(day: 9, range: Range.new, value: Value.new(per: +38, stack: -512)),
          Row.new(day: 10, range: Range.new, value: Value.new(per: +62, stack: -474)),
          Row.new(day: 11, range: Range.new, value: Value.new(per: +85, stack: -412)),
          Row.new(day: 12, range: Range.new, value: Value.new(per: +104, stack: -327)),
          Row.new(day: 13, range: Range.new, value: Value.new(per: +121, stack: -223)),
          Row.new(day: 14, range: Range.new(max: HALF_DAYS[14]), value: Value.new(per: +102, stack: -102)),
          Row.new(day: 14, range: Range.new(min: HALF_DAYS[14]), value: Value.new(per: +29, stack: 0)),
          Row.new(day: 15, range: Range.new, value: Value.new(per: +128, stack: +29)),
          Row.new(day: 16, range: Range.new, value: Value.new(per: +115, stack: +157)),
          Row.new(day: 17, range: Range.new, value: Value.new(per: +95, stack: +272)),
          Row.new(day: 18, range: Range.new, value: Value.new(per: +74, stack: +367)),
          Row.new(day: 19, range: Range.new, value: Value.new(per: +52, stack: +441)),
          Row.new(day: 20, range: Range.new, value: Value.new(per: +28, stack: +493)),
          Row.new(day: 21, range: Range.new(max: HALF_DAYS[21]), value: Value.new(per: +4, stack: +521)),
          Row.new(day: 21, range: Range.new(min: HALF_DAYS[21]), value: Value.new(per: 0, stack: +525)),
          Row.new(day: 22, range: Range.new, value: Value.new(per: -20, stack: +525)),
          Row.new(day: 23, range: Range.new, value: Value.new(per: -44, stack: +505)),
          Row.new(day: 24, range: Range.new, value: Value.new(per: -68, stack: +461)),
          Row.new(day: 25, range: Range.new, value: Value.new(per: -89, stack: +393)),
          Row.new(day: 26, range: Range.new, value: Value.new(per: -108, stack: +304)),
          Row.new(day: 27, range: Range.new, value: Value.new(per: -125, stack: +196)),
          Row.new(day: 28, range: Range.new(max: Range::LAST), value: Value.new(per: -71, stack: +71))
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
          limit = HALF_DAYS.fetch(day, -1)
          # 該当なし
          return minute if limit == -1

          return minute unless minute > limit

          minute - limit
        end
      end
    end
  end
end
