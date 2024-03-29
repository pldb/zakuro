# frozen_string_literal: true

require_relative '../../output/logger'
require_relative '../monthly/initialized_month'

# :nodoc:
module Zakuro
  # :nodoc:
  module Calculation
    # :nodoc:
    module Range
      #
      # MedievalAnnualRange 年間範囲（中世）
      #
      # * 儀鳳暦 ～ 宣明暦 を便宜的に中世とした
      # * 冬至から1年の開始を算出する
      # * 二十四節気：平気法
      # * 月の大小：定朔
      #
      module MedievalAnnualRange
        # @return [Output::Logger] ロガー
        LOGGER = Output::Logger.new(location: 'medieval_annual_range')

        class << self
          #
          # 一覧取得する
          #
          #   * 対象年に対して、前年11月-当年11月までを出力する
          #   * 対象年（西暦）と計算年（元号x年）の紐付けは行わない
          #
          # @param [Context::Context] context 暦コンテキスト
          # @param [Monthly::AbstractLunarPhase] lunar_phase 月の位相
          # @param [Solar::AbstractAverage] solar_average 定気（太陽軌道平均）
          #
          # @return [Array<Month>] 1年データ
          #
          def get(context:, lunar_phase:, solar_average:)
            annual_range = initialized_annual_range(context: context, lunar_phase: lunar_phase)

            apply_big_and_small_of_the_month(annual_range: annual_range)

            solar_average.set(annual_range: annual_range)

            # 月間隔を取得するためだけの末尾要素を削除
            annual_range.pop

            initialize_month_label(annual_range: annual_range)
          end

          private

          #
          # 1年データを取得する
          #
          # @param [Context::Context] context 暦コンテキスト
          # @param [Monthly::LunarPhase] lunar_phase 月の位相
          #
          # @return [Array<Month>] 1年データ
          #
          def initialized_annual_range(context:, lunar_phase:)
            result = []

            # 14ヶ月分を生成する（閏年で最大13ヶ月 + 末月の大小/二十四節気を求めるために必要な月）
            14.times.each do |_index|
              average_remainder = lunar_phase.average_remainder.clone
              adjusted = lunar_phase.next_month

              result.push(
                Monthly::InitializedMonth.new(
                  context: context, month_label: Monthly::MonthLabel.new,
                  first_day: Monthly::FirstDay.new(
                    remainder: adjusted, average_remainder: average_remainder
                  ),
                  phase_index: 0
                )
              )
            end

            result
          end

          #
          # 1年データの各月に月の大小を設定する
          #
          # @param [Array<Month>] annual_range 1年データ
          #
          def apply_big_and_small_of_the_month(annual_range:)
            # NOTE: 最後の月は処理できない（=計算外の余分な月が最後に必要である）
            annual_range.each_cons(2) do |(current_month, next_month)|
              current_month.eval_many_days(next_month_day: next_month.remainder.day)
            end
          end

          #
          # 月表示情報を更新する
          #
          # @param [Array<Month>] annual_range 1年データ
          #
          def initialize_month_label(annual_range:)
            annual_range.each(&:rename_month_label_by_solar_term)
          end
        end
      end
    end
  end
end
