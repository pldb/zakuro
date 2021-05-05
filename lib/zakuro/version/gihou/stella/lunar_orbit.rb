# frozen_string_literal: true

# :nodoc:
module Zakuro
  # :nodoc:
  module Senmyou
    #
    # LunarOrbit 月軌道
    #
    module LunarOrbit
      # @return [Integer] 変日（1近日点 = 27日743分1秒（1分=12秒））
      ANOMALISTIC_MONTH = 36_923.1

      #
      # Adjustment 補正値情報
      #
      module Adjustment
        #
        # Item 補正値
        #
        class Item
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

        # @return [Array<Item>] 月の補正値
        # @note キーは複合キーであり、以下のパターンに対応する
        #  * 変日（1-28）
        #  * 小余（0-1340）
        # TODO: 7日、21日の小余の境界が分からない。『日本暦日原典』に記載がない
        #       仮置きとして 1190 を置いた
        #       宣明暦[7465（初益）/ 8400（統法）] * 1340（総法） = 1190.84523..
        # TODO: 28日の小余は不明。要調査
        LIST = {
          key_01_0000_1340: Item.new(per: -134, stack: 0),
          key_02_0000_1340: Item.new(per: -117, stack: -134),
          key_03_0000_1340: Item.new(per: -99, stack: -251),
          key_04_0000_1340: Item.new(per: -78, stack: -350),
          key_05_0000_1340: Item.new(per: -56, stack: -428),
          key_06_0000_1340: Item.new(per: -33, stack: -484),
          key_07_0000_1190: Item.new(per: -9, stack: -517),
          key_07_1190_1340: Item.new(per: 0, stack: -526),
          key_08_0000_1340: Item.new(per: +14, stack: -526),
          key_09_0000_1340: Item.new(per: +38, stack: -512),
          key_10_0000_1340: Item.new(per: +62, stack: -474),
          key_11_0000_1340: Item.new(per: +85, stack: -412),
          key_12_0000_1340: Item.new(per: +104, stack: -327),
          key_13_0000_1340: Item.new(per: +121, stack: -223),
          key_14_0000_1190: Item.new(per: +102, stack: -102),
          key_14_1190_1340: Item.new(per: +29, stack: 0),
          key_15_0000_1340: Item.new(per: +128, stack: +29),
          key_16_0000_1340: Item.new(per: +115, stack: +157),
          key_17_0000_1340: Item.new(per: +95, stack: +272),
          key_18_0000_1340: Item.new(per: +74, stack: +367),
          key_19_0000_1340: Item.new(per: +52, stack: +441),
          key_20_0000_1340: Item.new(per: +28, stack: +493),
          key_21_0000_1190: Item.new(per: +4, stack: +521),
          key_21_1190_1340: Item.new(per: 0, stack: +525),
          key_22_0000_1340: Item.new(per: -20, stack: +525),
          key_23_0000_1340: Item.new(per: -44, stack: +505),
          key_24_0000_1340: Item.new(per: -68, stack: +461),
          key_25_0000_1340: Item.new(per: -89, stack: +393),
          key_26_0000_1340: Item.new(per: -108, stack: +304),
          key_27_0000_1340: Item.new(per: -125, stack: +196),
          key_28_0000_1340: Item.new(per: -71, stack: +71)
        }.freeze
      end

      # TODO: 補正値算出

      # :reek:TooManyStatements { max_statements: 9 }

      #
      # 月軌道の補正に必要な基本値を引き当てる
      #
      # @note 戻り値は calc_moon_orbit_value で使用する
      #
      # @param [Integer] day 大余
      # @param [Integer] minute 小余
      #
      # @return [Adjustment::Item] 補正値
      # @return [Integer] （小余を処理する時の）分母
      # @return [Integer] 小余の下げ幅
      #
      def self.specify_moon_adjustment(day:, minute:)
        targets = Adjustment::LIST.select \
          { |key, _| key.match(/^#{prefix}_#{format('%<day>02d', day: day)}_.*/) }

        targets.each do |key, value|
          # NOTE: 境界値は上から順に引き当てた方を返す（7日の境界値7465は上のキーで返す）
          matched, diff = \
            extract_data_from_moon_adjustment_key(key, minute)

          next unless matched

          return value, diff, minute unless [7, 14, 21].include?(day)

          # 小余の下げ幅
          calc_minute = minute > 1190 ? minute - 1190 : minute
          return value, diff, calc_minute
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

      #   #
      #   # 月の運行による補正値を算出する
      #   #
      #   # @param [Remainder] remainder_month 月の大余小余
      #   # @param [True, False] is_forward 進（遠地点より数える）/退（近地点より数える）
      #   #
      #   # @return [Integer] 補正値
      #   #
      #   def self.calc_moon_orbit_value(remainder_month:, is_forward:)
      #     valid?(remainder: remainder_month)

      #     day, minute = make_calculable_remainder_value(remainder: remainder_month)

      #     # 引き当て
      #     adjustment, diff, minute = specify_moon_adjustment(
      #       is_forward: is_forward, day: day, minute: minute
      #     )
      #     day = make_cumulative_value_for_days(per: adjustment.per,
      #                                          denominator: diff, minute: minute)

      #     adjustment.stack + day
      #   end

      #   #
      #   # 大余小余を検証する
      #   #
      #   # @param [Remainder] remainder 大余小余
      #   #
      #   # @return [True] 正しい（月の位相計算に使う大余小余）
      #   # @return [True] 正しくない
      #   #
      #   def self.valid?(remainder:)
      #     return if remainder.is_a?(Cycle::LunarRemainder)

      #     raise ArgumentError, "unmatch parameter type: #{remainder.class}"
      #   end
      #   private_class_method :valid?

      #   #
      #   # 大余小余を計算可能な値にする
      #   # @note 大余の秒（second）は使わない
      #   #
      #   # @param [LunarRemainder] remainder 大余小余
      #   #
      #   # @return [Integer] 大余
      #   # @return [Integer] 小余
      #   #
      #   def self.make_calculable_remainder_value(remainder:)
      #     day = remainder.day
      #     minute = remainder.minute + (remainder.second / 100)
      #     minute = minute.floor

      #     [day, minute]
      #   end
      #   private_class_method :make_calculable_remainder_value

      #   # :reek:TooManyStatements { max_statements: 9 }

      #   #
      #   # 累計値（大余）を作成する
      #   #
      #   # @param [Integer] per 入暦（1-14）
      #   # @param [Integer] denominator 小余の分母
      #   # @param [Integer] minute 小余
      #   #
      #   # @return [Integer] 累計値（大余）
      #   #
      #   def self.make_cumulative_value_for_days(per:, denominator:, minute:)
      #     remainder_minute = (per * minute).to_f
      #     day = remainder_minute / denominator
      #     # 切り捨て（プラスマイナスに関わらず小数点以下切り捨て）
      #     day = day.negative? ? day.ceil : day.floor
      #     sign = remainder_minute.negative? ? -1 : 1
      #     remainder_day = (sign * remainder_minute) % denominator
      #     # 四捨五入（8400ならその半分の4200以上を繰り上げる）
      #     day += sign if remainder_day >= (denominator / 2)

      #     day
      #   end
      #   private_class_method :make_cumulative_value_for_days

      #   # :reek:TooManyStatements { max_statements: 9 }

      #   #
      #   # 月軌道の補正に必要な基本値を引き当てる
      #   #
      #   # @note 戻り値は calc_moon_orbit_value で使用する
      #   #
      #   # @param [True, False] is_forward 進（遠地点より数える）/退（近地点より数える）
      #   # @param [Integer] day 大余
      #   # @param [Integer] minute 小余
      #   #
      #   # @return [Adjustment::Item] 補正値
      #   # @return [Integer] （小余を処理する時の）分母
      #   # @return [Integer] 小余の下げ幅
      #   #
      #   def self.specify_moon_adjustment(is_forward:, day:, minute:)
      #     prefix = { true => 'forward', false => 'back' }[is_forward]

      #     targets = Adjustment::LIST.select \
      #       { |key, _| key.match(/^#{prefix}_#{format('%<day>02d', day: day)}_.*/) }

      #     targets.each do |key, value|
      #       # NOTE: 境界値は上から順に引き当てた方を返す（7日の境界値7465は上のキーで返す）
      #       matched, diff = \
      #         extract_data_from_moon_adjustment_key(key, minute)
      #       # 小余の下げ幅
      #       calc_minute = (day == 7 && minute > 7465 ? minute - 7465 : minute)
      #       return value, diff, calc_minute if matched
      #     end

      #     [nil, nil, nil]
      #   end
      #   private_class_method :specify_moon_adjustment

      #   #
      #   # 補正値を引き当てる
      #   #
      #   # @param [String] key 補正値のキー
      #   # @param [Integer] minute 小余
      #   #
      #   # @return [Adjustment::Item] 補正値
      #   # @return [Integer] （小余を処理する時の）分母
      #   #
      #   def self.extract_data_from_moon_adjustment_key(key, minute)
      #     matched = key.match(/([0-9]{4})_([0-9]{4})$/)
      #     start = matched[1].to_i
      #     finish = matched[2].to_i

      #     matched = minute >= start && minute <= finish
      #     [matched, (finish - start)]
      #   end
      #   private_class_method :extract_data_from_moon_adjustment_key

      #   # :reek:ControlParameter and :reek:BooleanParameter
      #   # :reek:LongParameterList { max_params: 4 }

      #   #
      #   # 月地点を計算する
      #   #
      #   # @param [LunarRemainder] remainder 初回（昨年冬至）, 前回計算結果（入暦）
      #   # @param [Integer] western_year 西暦年
      #   # @param [True, False] is_forward  進（遠地点より数える）/退（近地点より数える）
      #   # @param [True, False] first 初回計算, 次回以降計算
      #   #
      #   # @return [LunarRemainder] 入暦
      #   # @return [True]  進（遠地点より数える）
      #   # @return [False]  退（近地点より数える）
      #   #
      #   def self.calc_moon_point(remainder:, western_year:,
      #                            is_forward: true, first: true)
      #     if first
      #       return calc_first_moon_point(winter_solstice_age: remainder,
      #                                    western_year: western_year)
      #     end
      #     calc_following_moon_point(remainder: remainder, is_forward: is_forward)
      #   end

      #   # :reek:TooManyStatements { max_statements: 7 }

      #   #
      #   # 入暦（月の遠地点から数えた日数/近地点から数えた日数）を求める
      #   #
      #   # 天正冬至（入暦前回未計算）を求める
      #   #
      #   # @param [Remainder] winter_solstice_age 天正閏余
      #   # @param [Integer] western_year 西暦年
      #   #
      #   # @return [LunarRemainder] 入暦
      #   # @return [True]  進（遠地点より数える）
      #   # @return [False]  退（近地点より数える）
      #   #
      #   def self.calc_first_moon_point(winter_solstice_age:, western_year:)
      #     # 積年の開始から対象年までの年数
      #     total_year = \
      #       WinterSolstice::TOTAL_YEAR + western_year - WinterSolstice::BEGIN_YEAR

      #     # 通積分 - 天正閏余
      #     total_day = \
      #       total_year * WinterSolstice::YEAR - winter_solstice_age.to_minute

      #     remainder_month = \
      #       Cycle::LunarRemainder.new(total: (total_day % ANOMALISTIC_MONTH))

      #     remainder_month, is_forward = decrease_moon_point(
      #       remainder_month: remainder_month,
      #       remainder_limit: HALF_ANOMALISTIC_MONTH, is_forward: true
      #     )

      #     remainder_month.add!(Cycle::Remainder.new(day: 1, minute: 0, second: 0))

      #     [remainder_month, is_forward]
      #   end
      #   private_class_method :calc_first_moon_point

      #   #
      #   # 入暦（月の遠地点から数えた日数/近地点から数えた日数）を求める
      #   #
      #   # 前回計算結果を補正する
      #   #
      #   # @param [LunarRemainder] remainder 前回計算結果（入暦）
      #   # @param [True, False] is_forward  進（遠地点より数える）/退（近地点より数える）
      #   #
      #   # @return [LunarRemainder] 入暦
      #   # @return [True]  進（遠地点より数える）
      #   # @return [False]  退（近地点より数える）
      #   #
      #   def self.calc_following_moon_point(remainder:, is_forward:)
      #     # 前回計算結果を引き継いた場合、暦中日ではなく損益眺朒（ちょうじく）数の上限とする
      #     remainder_month, is_forward = \
      #       decrease_moon_point(
      #         remainder_month: remainder,
      #         remainder_limit: Cycle::Remainder.new(day: 14, minute: 6529, second: 0),
      #         is_forward: is_forward
      #       )

      #     [remainder_month, is_forward]
      #   end
      #   private_class_method :calc_following_moon_point

      #   #
      #   # 月地点を減算する
      #   #
      #   # @param [LunarRemainder] remainder_month 大余小余
      #   # @param [Remainder] remainder_limit 大余小余の上限（最大の入暦）
      #   # @param [True, False] is_forward  進（遠地点より数える）/退（近地点より数える）
      #   #
      #   # @return [LunarRemainder] 大余小余の減算結果（上限値超えした場合）
      #   # @return [True]  進（遠地点より数える）
      #   # @return [False]  退（近地点より数える）
      #   #
      #   def self.decrease_moon_point(remainder_month:, remainder_limit:, is_forward:)
      #     return remainder_month, is_forward if remainder_month < remainder_limit

      #     [remainder_month.sub(HALF_ANOMALISTIC_MONTH), !is_forward]
      #   end
      #   private_class_method :decrease_moon_point
    end
  end
end
