# frozen_string_literal: true

# :nodoc:
module Zakuro
  # :nodoc:
  module Senmyou
    #
    # WesternDateAllocation 西暦日の割り当て
    #
    module WesternDateAllocation
      #
      # 月初日の西暦日を更新する
      #
      # @param [Array<Year>] years 完全範囲（月初日なし）
      #
      # @return [Array<Year>] 完全範囲（月初日あり）
      #
      def self.get(years:)
        update_first_day(years: years)

        years
      end

      #
      # 月初日の西暦日を更新する
      #
      # @param [Array<Year>] years 完全範囲（月初日なし）
      #
      def self.update_first_day(years:)
        years.each_with_index do |year, index|
          new_year_date = year.new_year_date.clone

          months = year.months
          update_first_day_within_all_months(
            new_year_date: new_year_date, months: months
          )

          years[index] = Year.new(
            multi_gengou: year.multi_gengou, new_year_date: new_year_date,
            months: months, total_days: year.total_days
          )
        end
      end

      #
      # 全ての月で月初日の西暦日を更新する
      #
      # @param [Western::Calendar] new_year_date 元旦
      # @param [Array<Month>] months 月データ
      #
      def self.update_first_day_within_all_months(new_year_date:, months:)
        date = new_year_date.clone
        months.each_with_index do |month, index|
          updated_month = Month.new(
            month_label: month.month_label,
            first_day: FirstDay.new(remainder: month.first_day.remainder,
                                    western_date: date),
            solar_terms: month.solar_terms
          )
          months[index] = updated_month

          date = date.clone + updated_month.days
        end
      end
      private_class_method :update_first_day_within_all_months
    end
  end
end
