# frozen_string_literal: true

require_relative '../../../output/logger'
require_relative '../base/remainder'
require_relative '../monthly/month'
require_relative '../base/solar_term'
require_relative '../monthly/lunar_phase'
require_relative '../stella/solar_orbit'
require_relative '../stella/solar_average'
require_relative '../stella/lunar_orbit'

# :nodoc:
module Zakuro
  # :nodoc:
  module Senmyou
    # AnnualRange 年間データ
    module AnnualRange
      # @return [Logger] ロガー
      LOGGER = Logger.new(location: 'annual_range')

      # :reek:TooManyStatements { max_statements: 6 }

      #
      # 11月定朔（冬至が含まれる月の1日：補正済）を求める
      #
      # @param [Integer] western_year 西暦年
      #
      # @return [Remainder] 11月定朔
      #
      def self.calc_last_november_1st(western_year:)
        # 天正閏余
        winter_solstice_age = \
          WinterSolstice.calc_moon_age(western_year: western_year)
        # 11月経朔
        november_1st = \
          WinterSolstice.calc_averaged_last_november_1st(western_year: western_year)
        # 11月定朔

        # 補正
        correction_value = correction_value_on_last_november_1st(
          winter_solstice_age: winter_solstice_age,
          western_year: western_year
        )

        result = november_1st.add(Remainder.new(day: 0, minute: correction_value,
                                                second: 0))
        # 進朔
        result.up_on_new_moon!
        result
      end

      # :reek:TooManyStatements { max_statements: 6 }

      #
      # 一覧取得する
      #
      #   * 対象年に対して、前年11月-当年11月までを出力する
      #   * 対象年（西暦）と計算年（元号x年）の紐付けは行わない
      #
      # @param [Integer] western_year 西暦年
      #
      # @return [Array<Month>] 1年データ
      #
      def self.collect_annual_range_after_last_november_1st(western_year:)
        annual_range = initialized_annual_range(western_year: western_year)

        apply_big_and_small_of_the_month(annual_range: annual_range)

        SolarAverage.set_solar_terms_into_annual_range(western_year: western_year,
                                                       annual_range: annual_range)

        # 月間隔を取得するためだけの末尾要素を削除
        annual_range.pop

        adjust_leap_month(annual_range: annual_range)

        annual_range
      end

      #
      # 11月定朔の補正値を求める
      #
      # @param [Remainder] winter_solstice_age 天正閏余
      # @param [Integer] western_year 西暦年
      #
      # @return [Integer] 補正値
      #
      def self.correction_value_on_last_november_1st(winter_solstice_age:, western_year:)
        # 補正
        solar_term = SolarTerm.new(
          remainder: winter_solstice_age
        )
        solar_term = \
          SolarOrbit.calc_solar_term_by_remainder(
            solar_term: solar_term
          )

        moon_remainder, is_forward = LunarOrbit.calc_moon_point(
          remainder: winter_solstice_age, western_year: western_year
        )

        SolarOrbit.calc_sun_orbit_value(solar_term: solar_term) +
          LunarOrbit.calc_moon_orbit_value(remainder_month: moon_remainder,
                                           is_forward: is_forward)
      end
      private_class_method :correction_value_on_last_november_1st

      #
      # 1年データを取得する
      #
      # @param [Integer] western_year 西暦年
      #
      # @return [Array<Month>] 1年データ
      #
      def self.initialized_annual_range(western_year:)
        result = []
        lunar_phase = LunarPhase.new(western_year: western_year)

        is_last_year = true

        monthes = [11, 12] + [*1..12]

        monthes.each do |month|
          LOGGER.debug('---', "month: #{month}", "is_last_year: #{is_last_year}")

          adjusted = lunar_phase.next_month

          result.push(
            Month.new(is_last_year: is_last_year, number: month,
                      remainder: adjusted, phase_index: 0)
          )
          is_last_year = false if month == 12
        end
        result
      end
      private_class_method :initialized_annual_range

      #
      # 1年データの各月に月の大小を設定する
      #
      # @param [Array<Month>] annual_range 1年データ
      #
      def self.apply_big_and_small_of_the_month(annual_range:)
        size = annual_range.size - 1
        (0...size).each do |idx|
          current_month = annual_range[idx]
          next_month = annual_range[idx + 1]
          current_month.is_many_days = \
            current_month.remainder.same_remainder_divided_by_ten?(
              other: next_month.remainder.day
            )
        end
      end
      private_class_method :apply_big_and_small_of_the_month

      # :reek:TooManyStatements { max_statements: 10 }

      #
      # 閏月が存在した場合に以降の月を1つずつ減らす
      # @example 7,8,9 と続く月の8月が閏の場合、7, 閏7, 8 となる
      #
      # @param [Array<Month>] annual_range 1年データ
      #
      def self.adjust_leap_month(annual_range:)
        # 閏による月の再調整を行う
        leaped = false
        annual_range.each_with_index do |month, index|
          if month.even_term.invalid?
            month.leaped = true
            # NOTE: 初回閏月（閏11月）は前回月が存在しないため調整外
            leaped = true unless index.zero?
          end
          next unless leaped

          # NOTE: 常気法では閏月は2-3年に一度のため、1年に二度発生しない前提
          number = month.number - 1
          if number <= 0
            month.is_last_year = true
            number = 12
          end
          month.number = number
        end
      end
      private_class_method :adjust_leap_month
    end
  end
end
