# frozen_string_literal: true

require_relative '../../../calculation/base/year'

require_relative '../../../era/western/calendar'

# :nodoc:
module Zakuro
  # :nodoc:
  module Calculation
    # :nodoc:
    module Range
      # :nodoc:
      module Transfer
        #
        # YearBoundary 年境界
        #
        module YearBoundary
          class << self
            #
            # 年間範囲内の年データの開始月を変更する
            #
            # @param [Context::Context] context 暦コンテキスト
            # @param [Array<Array<Monthly::Month>>] annual_ranges 年データ（冬至基準）
            #
            # @return [Array<Base::Year>] 年データ（元旦基準）
            #
            def get(context:, annual_ranges:)
              categorize(context: context, annual_ranges: annual_ranges)

              rearranged_years(context: context, annual_ranges: annual_ranges)
            end

            private

            #
            # 年間範囲内の年データの開始月を変更する
            #
            # @param [Context::Context] context 暦コンテキスト
            # @param [Array<Array<Monthly::Month>>] annual_ranges 年データ（冬至基準）
            #
            # @return [Array<Base::Year>] 年データ（元旦基準）
            #
            def rearranged_years(context:, annual_ranges:)
              years = []

              (0..(annual_ranges.size - 2)).each do |index|
                year = rearranged_year(
                  context: context, annual_ranges: annual_ranges, index: index
                )
                years.push(year)
              end

              years
            end

            #
            # 年間範囲を昨年/今年で分類する
            #
            # @param [Context::Context] context 暦コンテキスト
            # @param [Array<Array<Monthly::Month>>] annual_range 1年データ
            #
            def categorize(context:, annual_ranges:)
              annual_ranges.each do |annual_range|
                categorize_year(context: context, annual_range: annual_range)
              end
            end

            #
            # 各月を昨年/今年で分類する
            #
            # @param [Context::Context] context 暦コンテキスト
            # @param [Array<Monthly::Month>] annual_range 1年データ
            #
            def categorize_year(context:, annual_range:)
              is_last_year = true
              annual_range.each_with_index do |month, index|
                is_last_year = false if month.number == 1

                annual_range[index] = Monthly::InitializedMonth.new(
                  context: context,
                  month_label: month.month_label, first_day: month.first_day,
                  solar_terms: month.solar_terms, phase_index: month.phase_index,
                  is_last_year: is_last_year,
                  meta: month.meta
                )
              end
            end

            #
            # 年データの開始月を変更する
            #
            # @param [Context::Context] context 暦コンテキスト
            # @param [Array<Array<Monthly::Month>>] annual_ranges 年データ（冬至基準）
            # @param [Integer] index 対象年の要素番号
            #
            # @return [Base::Year] 年データ（元旦基準）
            #
            def rearranged_year(context:, annual_ranges:, index:)
              current_annual_range = annual_ranges[index]
              next_annual_range = annual_ranges[index + 1]

              year = push_current_year(context: context, annual_range: current_annual_range)
              push_last_year(annual_range: next_annual_range, year: year)

              year
            end

            #
            # 当年データを生成する
            #
            # @param [Context::Context] context 暦コンテキスト
            # @param [Array<Monthly::Month>] annual_range 1年データ
            #
            # @return [Base::Year] 当年月ありの対象年
            #
            def push_current_year(context:, annual_range:)
              year = Base::Year.new(context: context)
              annual_range.each do |month|
                next if month.is_last_year

                year.push(month: month)
              end

              year
            end

            #
            # 昨年データを生成する
            #
            # @param [Array<Monthly::Month>] annual_range 1年データ
            # @param [Base::Year] year 対象年
            #
            # @return [Base::Year] 昨年月ありの対象年
            #
            def push_last_year(annual_range:, year: Base::Year.new)
              annual_range.each do |month|
                next unless month.is_last_year

                year.push(month: month)
              end

              year
            end
          end
        end
      end
    end
  end
end
