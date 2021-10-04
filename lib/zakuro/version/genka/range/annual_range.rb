# frozen_string_literal: true

require_relative '../../../calculation/range/medieval_annual_range'
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

          lunar_phase = Monthly::LunarPhase.new(remainder: remainder)

          solar_average = Solar::Average.new(solar_term: solar_term)

          annual_range = Calculation::Range::MedievalAnnualRange.get(
            context: context, lunar_phase: lunar_phase, solar_average: solar_average
          )

          pop_months_on_next_year(annual_range: annual_range)
        end

        #
        # 来年の月を除去する
        #
        # @param [Array<Month>] annual_range 1年データ
        #
        # @return [Array<Month>] 1年データ
        #
        def self.pop_months_on_next_year(annual_range:)
          result = []
          number = 0
          annual_range.each do |month|
            # 来年
            break if number > month.month_label.number

            number = month.month_label.number
            result.push(month)
          end

          result
        end
      end
    end
  end
end
