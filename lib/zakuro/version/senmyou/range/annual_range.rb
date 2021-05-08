# frozen_string_literal: true

require_relative '../../../output/logger'
require_relative '../cycle/remainder'
require_relative '../cycle/solar_term'
require_relative '../../../calculation/monthly/initialized_month'
require_relative '../monthly/lunar_phase'
require_relative '../stella/lunar/location'
require_relative '../stella/lunar/orbit'
require_relative '../stella/solar/average'
require_relative '../stella/solar/location'
require_relative '../stella/solar/orbit'

# :nodoc:
module Zakuro
  # :nodoc:
  module Senmyou
    # :nodoc:
    module Range
      #
      # AnnualRange 年間範囲
      #
      module AnnualRange
        # @return [Output::Logger] ロガー
        LOGGER = Output::Logger.new(location: 'annual_range')

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
            Solar::WinterSolstice.calc_moon_age(western_year: western_year)
          # 11月経朔
          november_1st = \
            Solar::WinterSolstice.calc_averaged_last_november_1st(western_year: western_year)
          # 11月定朔

          # 補正
          correction_value = correction_value_on_last_november_1st(
            winter_solstice_age: winter_solstice_age,
            western_year: western_year
          )

          result = november_1st.add(Cycle::Remainder.new(day: 0, minute: correction_value,
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
        # @param [Context] context 暦コンテキスト
        # @param [Integer] western_year 西暦年
        #
        # @return [Array<Month>] 1年データ
        #
        def self.collect_annual_range_after_last_november_1st(context:, western_year:)
          annual_range = initialized_annual_range(context: context, western_year: western_year)

          apply_big_and_small_of_the_month(annual_range: annual_range)

          solar_average = Solar::Average.new(western_year: western_year)
          solar_average.set(annual_range: annual_range)

          # 月間隔を取得するためだけの末尾要素を削除
          annual_range.pop

          initialize_month_label(annual_range: annual_range)
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
          solar_term = Cycle::SolarTerm.new(
            remainder: winter_solstice_age
          )
          solar_term = \
            Solar::Location.get(
              solar_term: solar_term
            )

          moon_remainder, is_forward = Lunar::Location.calc_moon_point(
            remainder: winter_solstice_age, western_year: western_year
          )

          Solar::Orbit.calc_sun_orbit_value(solar_term: solar_term) +
            Lunar::Orbit.calc_moon_orbit_value(remainder_month: moon_remainder,
                                               is_forward: is_forward)
        end
        private_class_method :correction_value_on_last_november_1st

        #
        # 1年データを取得する
        #
        # @param [Context] context 暦コンテキスト
        # @param [Integer] western_year 西暦年
        #
        # @return [Array<Month>] 1年データ
        #
        def self.initialized_annual_range(context:, western_year:)
          result = []
          lunar_phase = Monthly::LunarPhase.new(western_year: western_year)

          # 14ヶ月分を生成する（閏年で最大13ヶ月 + 末月の大小/二十四節気を求めるために必要な月）
          (0..13).each do |_index|
            adjusted = lunar_phase.next_month

            result.push(
              Calculation::Monthly::InitializedMonth.new(
                context: context,
                month_label: Calculation::Monthly::MonthLabel.new,
                first_day: Calculation::Monthly::FirstDay.new(remainder: adjusted),
                phase_index: 0
              )
            )
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
          # NOTE: 最後の月は処理できない（=計算外の余分な月が最後に必要である）
          annual_range.each_cons(2) do |(current_month, next_month)|
            current_month.eval_many_days(next_month_day: next_month.remainder.day)
          end
        end
        private_class_method :apply_big_and_small_of_the_month

        #
        # 月表示情報を更新する
        #
        # @param [Array<Month>] annual_range 1年データ
        #
        def self.initialize_month_label(annual_range:)
          annual_range.each(&:rename_month_label_by_solar_term)
        end
        private_class_method :initialize_month_label
      end
    end
  end
end
