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
        # AllSolarTerm 月内全ての二十四節気
        #
        module AllSolarTerm
          class << self
            #
            # 月内全ての二十四節気を更新する
            #
            # @param [Array<Array<Month>>] annual_ranges 年データ（冬至基準）
            #
            def update_months(annual_ranges:)
              annual_ranges.each do |months|
                collect(months: months)
              end
            end

            #
            # 月内全ての二十四節気を更新する
            #
            # @param [Array<Base::Year>] annual_ranges 年データ（元旦基準）
            #
            def update_years(annual_ranges:)
              annual_ranges.each do |year|
                collect(months: year.months)
              end
            end

            private

            #
            # 二十四節気を収集する
            #
            # @param [Array<Month>] months 月情報
            #
            def collect(months:)
              # TODO: refactor
              months.each_with_index do |month, index|
                next if index.zero?

                all_solar_terms = []
                all_solar_terms.push(months[index - 1].solar_terms[-1].clone)
                all_solar_terms.concat(month.solar_terms)

                months[index] = Monthly::InitializedMonth.new(
                  context: context,
                  month_label: month.month_label, first_day: month.first_day,
                  solar_terms: month.solar_terms, phase_index: month.phase_index,
                  is_last_year: month.is_last_year,
                  meta: Meta.new(all_solar_terms: all_solar_terms)
                )
              end
            end
          end
        end
      end
    end
  end
end
