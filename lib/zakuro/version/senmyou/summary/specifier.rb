# frozen_string_literal: true

require_relative '../../../era/western'
require_relative './full_range'
require_relative '../base/multi_gengou_roller'
require_relative '../base/year'
require_relative '../../../output/response'
require_relative '../../../output/logger'

# :nodoc:
module Zakuro
  # :nodoc:
  module Senmyou
    #
    # SingleDaySpecifier 一日検索
    #
    module SingleDaySpecifier
      # @return [Logger] ロガー
      LOGGER = Logger.new(location: 'specifier')

      def self.get(date:)
        years = FullRange.new(start_date: date).get

        year = specify_year(years: years, date: date)

        year = transfer(year: year, date: date)

        month, first_date = specify_month(year: year, date: date)

        Response::SingleDay.save_single_day(
          param: Response::SingleDay::Param.new(
            year: year, month: month,
            date: date, days: date - first_date
          )
        )
      end

      def self.specify_year(years:, date:)
        years.reverse_each do |year|
          return year if date >= year.new_year_date
        end

        LOGGER.info("years.size: #{years.size}")
        years.each do |year|
          LOGGER.info("year: #{year.new_year_date.format}")
        end

        raise ArgumentError, "invalid year range. date: #{date.format}"
      end

      def self.transfer(year:, date:)
        multi_gengou = MultiGengouRoller.transfer(multi_gengou: year.multi_gengou, date: date)
        Year.new(multi_gengou: multi_gengou, new_year_date: year.new_year_date,
                 months: year.months, total_days: year.total_days)
      end

      def self.specify_month(year:, date:)
        current_month_date = year.new_year_date.clone
        next_month_date = current_month_date.clone
        year.months.each do |month|
          next_month_date += month.days
          return month, current_month_date if next_month_date > date

          current_month_date = next_month_date.clone
        end

        raise ArgumentError, "invalid month range. date: #{date.format}"
      end
    end
  end
end
