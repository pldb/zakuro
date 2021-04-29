# frozen_string_literal: true

require_relative '../base/multi_gengou_roller'

require_relative '../../../era/western'
require_relative './annual_range'

require_relative '../base/year'

# :nodoc:
module Zakuro
  # :nodoc:
  module Senmyou
    #
    # YearBoundary 年境界
    #
    module YearBoundary
      #
      # 年間範囲内の年データの開始月を変更する
      #
      # @param [Array<Year>] annual_ranges 年データ（冬至基準）
      #
      # @return [Array<Year>] 年データ（元旦基準）
      #
      def self.rearranged_years(annual_ranges:)
        years = []

        (0..(annual_ranges.size - 2)).each do |index|
          year = rearranged_year(annual_ranges: annual_ranges, index: index)
          years.push(year)
        end

        years
      end

      #
      # 年データの開始月を変更する
      #
      # @param [Array<Year>] annual_ranges 年データ（冬至基準）
      # @param [Integer] index 対象年の要素番号
      #
      # @return [Year] 年データ（元旦基準）
      #
      def self.rearranged_year(annual_ranges:, index:)
        current_annual_range = annual_ranges[index]
        next_annual_range = annual_ranges[index + 1]

        year = push_current_year(annual_range: current_annual_range)
        push_last_year(annual_range: next_annual_range, year: year)

        year
      end
      private_class_method :rearranged_year

      #
      # 当年データを生成する
      #
      # @param [Array<Year>] annual_ranges 年データ（冬至基準）
      # @param [Year] year 対象年
      #
      # @return [Year] 当年月ありの対象年
      #
      def self.push_current_year(annual_range:, year: Year.new)
        annual_range.each do |month|
          next if month.is_last_year

          year.push(month: month)
        end

        year
      end

      #
      # 昨年データを生成する
      #
      # @param [Array<Year>] annual_ranges 年データ（冬至基準）
      # @param [Year] year 対象年
      #
      # @return [Year] 昨年月ありの対象年
      #
      def self.push_last_year(annual_range:, year: Year.new)
        annual_range.each do |month|
          next unless month.is_last_year

          year.push(month: month)
        end

        year
      end
    end
  end
end
