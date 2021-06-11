# frozen_string_literal: true

require_relative '../../../calculation/range/medieval_annual_range'
require_relative '../monthly/lunar_phase'
require_relative '../stella/solar/average'

# :nodoc:
module Zakuro
  # :nodoc:
  module Daien
    # :nodoc:
    module Range
      #
      # AnnualRange 年間範囲
      #
      module AnnualRange
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
        def self.get(context:, western_year:)
          lunar_phase = Monthly::LunarPhase.new(western_year: western_year)
          solar_average = Solar::Average.new(western_year: western_year)

          Calculation::Range::MedievalAnnualRange.get(
            context: context, lunar_phase: lunar_phase, solar_average: solar_average
          )
        end
      end
    end
  end
end
