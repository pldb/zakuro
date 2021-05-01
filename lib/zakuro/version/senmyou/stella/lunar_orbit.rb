# frozen_string_literal: true

# :nodoc:
module Zakuro
  # :nodoc:
  module Senmyou
    #
    # LunarOrbit 月軌道
    #
    module LunarOrbit
      # @return [Integer] 暦周（1近日点）
      ANOMALISTIC_MONTH = 231_458.19
      # @return [Integer] 暦中日
      # @note ANOMALISTIC_MONTH の半分に相当する
      HALF_ANOMALISTIC_MONTH = \
        Cycle::LunarRemainder.new(day: 13, minute: 6529, second: 9.5)

      #
      # Adjustment 補正値情報
      #
      module Adjustment
        #
        # Item 補正値
        #
        class Item
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

        # @return [Array<Item>] 月の補正値
        # @note キーは複合キーであり、以下のパターンに対応する
        #   * 進退
        #     * forward: 進（遠地点より数える）
        #     * back: 退（近地点より数える）
        #  * 入暦（1-14）
        #  * 小余（0-8400）
        LIST = {
          forward_01_0000_8400: Item.new(per: +830, stack: 0),
          forward_02_0000_8400: Item.new(per: +726, stack: +830),
          forward_03_0000_8400: Item.new(per: +606, stack: +1556),
          forward_04_0000_8400: Item.new(per: +471, stack: +2162),
          forward_05_0000_8400: Item.new(per: +337, stack: +2633),
          forward_06_0000_8400: Item.new(per: +202, stack: +2970),
          forward_07_0000_7465: Item.new(per: +53, stack: +3172),
          forward_07_7465_8400: Item.new(per: -7, stack: +3225),  # +3172 + 53（初益）
          forward_08_0000_8400: Item.new(per: -82, stack: +3218),
          forward_09_0000_8400: Item.new(per: -224, stack: +3136),
          forward_10_0000_8400: Item.new(per: -366, stack: +2912),
          forward_11_0000_8400: Item.new(per: -509, stack: +2546),
          forward_12_0000_8400: Item.new(per: -643, stack: +2037),
          forward_13_0000_8400: Item.new(per: -748, stack: +1394),
          forward_14_0000_6529: Item.new(per: -646, stack: +646), # 14日の小余は常に6529以下
          back_01_0000_8400: Item.new(per: -830, stack: 0),
          back_02_0000_8400: Item.new(per: -726, stack: -830),
          back_03_0000_8400: Item.new(per: -598, stack: -1556),
          back_04_0000_8400: Item.new(per: -464, stack: -2154),
          back_05_0000_8400: Item.new(per: -329, stack: -2618),
          back_06_0000_8400: Item.new(per: -195, stack: -2947),
          back_07_0000_7465: Item.new(per: -53, stack: -3142),
          back_07_7465_8400: Item.new(per: +7, stack: -3195), # -3142 - 53（初益）
          back_08_0000_8400: Item.new(per: +82, stack: -3188),
          back_09_0000_8400: Item.new(per: +225, stack: -3106),
          back_10_0000_8400: Item.new(per: +366, stack: -2881),
          back_11_0000_8400: Item.new(per: +501, stack: -2515),
          back_12_0000_8400: Item.new(per: +628, stack: -2014),
          back_13_0000_8400: Item.new(per: +740, stack: -1386),
          back_14_0000_6529: Item.new(per: +646, stack: -646) # 14日の小余は常に6529以下
        }.freeze
      end

      #
      # 月の運行による補正値を算出する
      #
      # @param [Remainder] remainder_month 月の大余小余
      # @param [True, False] is_forward 進（遠地点より数える）/退（近地点より数える）
      #
      # @return [Integer] 補正値
      #
      def self.calc_moon_orbit_value(remainder_month:, is_forward:)
        valid?(remainder: remainder_month)

        day, minute = make_calculable_remainder_value(remainder: remainder_month)

        # 引き当て
        adjustment, diff, minute = specify_moon_adjustment(
          is_forward: is_forward, day: day, minute: minute
        )
        day = make_cumulative_value_for_days(per: adjustment.per,
                                             denominator: diff, minute: minute)

        adjustment.stack + day
      end

      #
      # 大余小余を検証する
      #
      # @param [Remainder] remainder 大余小余
      #
      # @return [True] 正しい（月の位相計算に使う大余小余）
      # @return [True] 正しくない
      #
      def self.valid?(remainder:)
        return if remainder.is_a?(Cycle::LunarRemainder)

        raise ArgumentError, "unmatch parameter type: #{remainder.class}"
      end
      private_class_method :valid?

      #
      # 大余小余を計算可能な値にする
      # @note 大余の秒（second）は使わない
      #
      # @param [LunarRemainder] remainder 大余小余
      #
      # @return [Integer] 大余
      # @return [Integer] 小余
      #
      def self.make_calculable_remainder_value(remainder:)
        day = remainder.day
        minute = remainder.minute + (remainder.second / 100)
        minute = minute.floor

        [day, minute]
      end
      private_class_method :make_calculable_remainder_value

      # :reek:TooManyStatements { max_statements: 9 }

      #
      # 累計値（大余）を作成する
      #
      # @param [Integer] per 入暦（1-14）
      # @param [Integer] denominator 小余の分母
      # @param [Integer] minute 小余
      #
      # @return [Integer] 累計値（大余）
      #
      def self.make_cumulative_value_for_days(per:, denominator:, minute:)
        remainder_minute = (per * minute).to_f
        day = remainder_minute / denominator
        # 切り捨て（プラスマイナスに関わらず小数点以下切り捨て）
        day = day.negative? ? day.ceil : day.floor
        sign = remainder_minute.negative? ? -1 : 1
        remainder_day = (sign * remainder_minute) % denominator
        # 四捨五入（8400ならその半分の4200以上を繰り上げる）
        day += sign if remainder_day >= (denominator / 2)

        day
      end
      private_class_method :make_cumulative_value_for_days

      # :reek:TooManyStatements { max_statements: 9 }

      #
      # 月軌道の補正に必要な基本値を引き当てる
      #
      # @note 戻り値は calc_moon_orbit_value で使用する
      #
      # @param [True, False] is_forward 進（遠地点より数える）/退（近地点より数える）
      # @param [Integer] day 大余
      # @param [Integer] minute 小余
      #
      # @return [Adjustment::Item] 補正値
      # @return [Integer] （小余を処理する時の）分母
      # @return [Integer] 小余の下げ幅
      #
      def self.specify_moon_adjustment(is_forward:, day:, minute:)
        prefix = { true => 'forward', false => 'back' }[is_forward]

        targets = Adjustment::LIST.select \
          { |key, _| key.match(/^#{prefix}_#{format('%<day>02d', day: day)}_.*/) }

        targets.each do |key, value|
          # NOTE: 境界値は上から順に引き当てた方を返す（7日の境界値7465は上のキーで返す）
          matched, diff = \
            extract_data_from_moon_adjustment_key(key, minute)
          # 小余の下げ幅
          calc_minute = (day == 7 && minute > 7465 ? minute - 7465 : minute)
          return value, diff, calc_minute if matched
        end

        [nil, nil, nil]
      end
      private_class_method :specify_moon_adjustment

      #
      # 補正値を引き当てる
      #
      # @param [String] key 補正値のキー
      # @param [Integer] minute 小余
      #
      # @return [Adjustment::Item] 補正値
      # @return [Integer] （小余を処理する時の）分母
      #
      def self.extract_data_from_moon_adjustment_key(key, minute)
        matched = key.match(/([0-9]{4})_([0-9]{4})$/)
        start = matched[1].to_i
        finish = matched[2].to_i

        matched = minute >= start && minute <= finish
        [matched, (finish - start)]
      end
      private_class_method :extract_data_from_moon_adjustment_key

      # :reek:ControlParameter and :reek:BooleanParameter
      # :reek:LongParameterList { max_params: 4 }

      #
      # 月地点を計算する
      #
      # @param [LunarRemainder] remainder 初回（昨年冬至）, 前回計算結果（入暦）
      # @param [Integer] western_year 西暦年
      # @param [True, False] is_forward  進（遠地点より数える）/退（近地点より数える）
      # @param [True, False] first 初回計算, 次回以降計算
      #
      # @return [LunarRemainder] 入暦
      # @return [True]  進（遠地点より数える）
      # @return [False]  退（近地点より数える）
      #
      def self.calc_moon_point(remainder:, western_year:,
                               is_forward: true, first: true)
        if first
          return calc_first_moon_point(winter_solstice_age: remainder,
                                       western_year: western_year)
        end
        calc_following_moon_point(remainder: remainder, is_forward: is_forward)
      end

      # :reek:TooManyStatements { max_statements: 7 }

      #
      # 入暦（月の遠地点から数えた日数/近地点から数えた日数）を求める
      #
      # 天正冬至（入暦前回未計算）を求める
      #
      # @param [Remainder] winter_solstice_age 天正閏余
      # @param [Integer] western_year 西暦年
      #
      # @return [LunarRemainder] 入暦
      # @return [True]  進（遠地点より数える）
      # @return [False]  退（近地点より数える）
      #
      def self.calc_first_moon_point(winter_solstice_age:, western_year:)
        # 積年の開始から対象年までの年数
        total_year = \
          WinterSolstice::TOTAL_YEAR + western_year - WinterSolstice::BEGIN_YEAR

        # 通積分 - 天正閏余
        total_day = \
          total_year * WinterSolstice::YEAR - winter_solstice_age.to_minute

        remainder_month = \
          Cycle::LunarRemainder.new(total: (total_day % ANOMALISTIC_MONTH))

        remainder_month, is_forward = decrease_moon_point(
          remainder_month: remainder_month,
          remainder_limit: HALF_ANOMALISTIC_MONTH, is_forward: true
        )

        remainder_month.add!(Cycle::Remainder.new(day: 1, minute: 0, second: 0))

        [remainder_month, is_forward]
      end
      private_class_method :calc_first_moon_point

      #
      # 入暦（月の遠地点から数えた日数/近地点から数えた日数）を求める
      #
      # 前回計算結果を補正する
      #
      # @param [LunarRemainder] remainder 前回計算結果（入暦）
      # @param [True, False] is_forward  進（遠地点より数える）/退（近地点より数える）
      #
      # @return [LunarRemainder] 入暦
      # @return [True]  進（遠地点より数える）
      # @return [False]  退（近地点より数える）
      #
      def self.calc_following_moon_point(remainder:, is_forward:)
        # 前回計算結果を引き継いた場合、暦中日ではなく損益眺朒（ちょうじく）数の上限とする
        remainder_month, is_forward = \
          decrease_moon_point(
            remainder_month: remainder,
            remainder_limit: Cycle::Remainder.new(day: 14, minute: 6529, second: 0),
            is_forward: is_forward
          )

        [remainder_month, is_forward]
      end
      private_class_method :calc_following_moon_point

      #
      # 月地点を減算する
      #
      # @param [LunarRemainder] remainder_month 大余小余
      # @param [Remainder] remainder_limit 大余小余の上限（最大の入暦）
      # @param [True, False] is_forward  進（遠地点より数える）/退（近地点より数える）
      #
      # @return [LunarRemainder] 大余小余の減算結果（上限値超えした場合）
      # @return [True]  進（遠地点より数える）
      # @return [False]  退（近地点より数える）
      #
      def self.decrease_moon_point(remainder_month:, remainder_limit:, is_forward:)
        return remainder_month, is_forward if remainder_month < remainder_limit

        [remainder_month.sub(HALF_ANOMALISTIC_MONTH), !is_forward]
      end
      private_class_method :decrease_moon_point
    end
  end
end
