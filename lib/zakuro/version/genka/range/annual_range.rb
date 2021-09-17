# frozen_string_literal: true

require_relative '../../../output/logger'
require_relative '../monthly/lunar_phase'
require_relative '../stella/solar/average'

# :nodoc:
module Zakuro
  # :nodoc:
  module Genka
    # :nodoc:
    module Range
      #
      # AnnualRange 年間範囲
      #
      module AnnualRange
        # @return [Output::Logger] ロガー
        LOGGER = Output::Logger.new(location: 'annual_range')

        #
        # 一覧取得する
        #
        #   * 対象年に対して、当年1月-翌年1月までを出力する
        #   * 対象年（西暦）と計算年（元号x年）の紐付けは行わない
        #
        # @param [Context] context 暦コンテキスト
        # @param [Integer] western_year 西暦年
        #
        # @return [Array<Month>] 1年データ
        #
        def self.get(context:, western_year:)
          # 正月中気
          solar_term = Cycle::SolarTerm.new(
            index: 4, remainder: Origin::FirstTerm.get(western_year: western_year)
          )
          # 正月に立春が含まれる可能性があるので、立春まで戻しておく
          solar_term.prev_term!

          # 経
          remainder = Origin::January.get(western_year: western_year)

          # TODO: 雨水よりも手前の節気から開始すべきだが、それには経朔と比較しなければならない
          lunar_phase = Monthly::LunarPhase.new(remainder: remainder, solar_term: solar_term)

          initialized_annual_range(context: context, lunar_phase: lunar_phase)

          # TODO: 残処理
        end

        #
        # 1年データを取得する
        #
        # @param [Context] context 暦コンテキスト
        # @param [Monthly::LunarPhase] lunar_phase 月の位相
        #
        # @return [Array<Month>] 1年データ
        #
        def self.initialized_annual_range(context:, lunar_phase:)
          result = []

          # 14ヶ月分を生成する（閏年で最大13ヶ月 + 末月の大小/二十四節気を求めるために必要な月）
          (0..13).each do |_index|
            adjusted = lunar_phase.next_month

            result.push(
              Monthly::InitializedMonth.new(
                context: context,
                month_label: Monthly::MonthLabel.new,
                first_day: Monthly::FirstDay.new(remainder: adjusted),
                phase_index: 0
              )
            )
          end

          result
        end
        private_class_method :initialized_annual_range
      end
    end
  end
end
