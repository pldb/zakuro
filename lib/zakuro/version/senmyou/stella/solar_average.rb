# frozen_string_literal: true

# :nodoc:
module Zakuro
  # :nodoc:
  module Senmyou
    #
    # SolarAverage 常気（太陽軌道平均）
    #
    class SolarAverage
      # @return [Remainder] 気策（24分の1年）
      SOLAR_TERM_AVERAGE = Remainder.new(day: 15, minute: 1835, second: 5)

      def initialize(western_year:)
        @solar_term = SolarAverage.first_solar_term(western_year: western_year)
      end

      def self.first_solar_term(western_year:)
        # 天正冬至
        winter_solstice = WinterSolstice.calc(western_year: western_year)

        # 二十四節気（冬至）
        solar_term = SolarTerm.new(index: 0, remainder: winter_solstice)

        solar_location_index = SolarAverage.calc_solar_location_index(western_year: western_year)

        solar_term.prev_by_index(solar_location_index)

        solar_term
      end

      def self.calc_solar_location_index(western_year:)
        # 天正閏余
        winter_solstice_age = \
          WinterSolstice.calc_moon_age(western_year: western_year)

        # 入定気を求める
        first_solar_term = SolarLocation.get(
          solar_term: SolarTerm.new(remainder: winter_solstice_age)
        )

        solar_term_index = first_solar_term.index

        # 入定気の一つ後の二十四節気まで戻す（ただし11月経朔が二十四節気上にある場合は戻さない）
        solar_term_index += 1 unless first_solar_term.remainder == Remainder.new(total: 0)

        solar_term_index
      end

      #
      # 冬至から数えた1年データの月ごとに二十四節気を割り当てる
      #
      # @param [Array<Month>] annual_range 1年データ
      #
      # @return [Array<Month>] 1年データ
      #
      def set(annual_range:)
        # 最後の月は処理できない
        (0..(annual_range.size - 2)).each do |index|
          current_month = annual_range[index]
          next_month = annual_range[index + 1]

          set_solar_term(
            current_month: current_month,
            next_month: next_month
          )
        end

        annual_range
      end

      #
      # 月内（当月朔日から当月末日（来月朔日の前日）の間）に二十四節気があるか
      # @note 大余60で一巡するため 以下2パターンがある
      #   * current_month <= next_month : (二十四節気) >= current_month && (二十四節気) < next_month
      #   * current_month > next_month  : (二十四節気) >= current_month || (二十四節気) < next_month
      #
      # @param [Remainder] solar_term 二十四節気
      # @param [Remainder] current_month 月初
      # @param [Remainder] next_month 月末
      #
      # @return [True] 対象の二十四節気がある
      # @return [False] 対象の二十四節気がない
      #
      def self.in_range_solar_term?(solar_term:, current_month:, next_month:)
        # 大余で比較する
        target_time = solar_term.day
        current_month_time = current_month.day
        next_month_time = next_month.day
        current_month_over = (target_time >= current_month_time)
        next_month_under = (target_time < next_month_time)

        return current_month_over && next_month_under if current_month_time <= next_month_time

        current_month_over || next_month_under
      end

      private

      def set_solar_term(current_month:, next_month:)
        # 安全策として無限ループは回避する
        # * 最大試行回数：4回（設定なし => 設定あり => 設定あり => 設定なし）
        # * 閏月は1回しか設定しない
        # * 最大2回設定する（中気・節気）
        (0..3).each do |_index|
          in_range = SolarAverage.in_range_solar_term?(
            solar_term: @solar_term.remainder,
            current_month: current_month.remainder,
            next_month: next_month.remainder
          )

          if in_range
            current_month.add_term(term: @solar_term.clone)
            next_solar_term
          end

          # 宣明暦は最大2つまで
          break if current_month.solar_terms.size == 2

          # 範囲内であれば続行する
          next if in_range

          # 1つ以上設定されていれば切り上げる（一つ飛ばしで二十四節気を設定することはない）
          # break unless current_month.solar_terms.size.zero?
          if current_month.solar_terms.size.zero?
            next_solar_term
            next
          end

          break
        end
      end

      def next_solar_term
        @solar_term.next!
      end
    end
  end
end
