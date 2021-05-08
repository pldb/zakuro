# frozen_string_literal: true

require_relative '../const/const'

# :nodoc:
module Zakuro
  # :nodoc:
  module Senmyou
    #
    # LunarOrbit 月軌道
    #
    module LunarLocation
      # @return [Integer] 1近日点
      ANOMALISTIC_MONTH = Const::Cycle::ANOMALISTIC_MONTH
      # @return [Integer] 暦中日
      # @note ANOMALISTIC_MONTH の半分に相当する
      HALF_ANOMALISTIC_MONTH = \
        Cycle::LunarRemainder.new(day: 13, minute: 6529, second: 9.5)

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
