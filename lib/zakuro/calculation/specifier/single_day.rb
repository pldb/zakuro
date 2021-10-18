# frozen_string_literal: true

require_relative '../base/multi_gengou_roller'
require_relative '../base/year'

require_relative '../../era/western/calendar'
require_relative '../../output/response'
require_relative '../../output/logger'

# :nodoc:
module Zakuro
  # :nodoc:
  module Calculation
    # :nodoc:
    module Specifier
      #
      # SingleDay 一日検索
      #
      module SingleDay
        # @return [Output::Logger] ロガー
        LOGGER = Output::Logger.new(location: 'specifier')

        #
        # 取得する
        #
        # @param [Array<Year>] yeas 範囲
        # @param [Western::Calendar] date 西暦日
        #
        # @return [Result::Data::SingleDay] 和暦日
        #
        def self.get(years: [], date: Western::Calendar.new)
          year = specify_year(years: years, date: date)

          year = transfer(year: year, date: date)

          month = specify_month(year: year, date: date)
          first_date = month.western_date

          Output::Response::SingleDay.save_single_day(
            param: Output::Response::SingleDay::Param.new(
              year: year, month: month,
              date: date, days: date - first_date
            )
          )
        end

        #
        # 年を特定する
        #
        # @param [Array<Year>] years 範囲
        # @param [Western::Calendar] date 西暦日
        #
        # @return [Year] 対象年
        #
        def self.specify_year(years:, date:)
          years.reverse_each do |year|
            return year if date >= year.new_year_date
          end

          raise ArgumentError, "invalid year range. date: #{date.format}"
        end
        private_class_method :specify_year

        #
        # 改元する
        #
        # @param [Year] year 年
        # @param [Western::Calendar] date 西暦日
        #
        # @return [Year] 改元後の年
        #
        def self.transfer(year:, date:)
          multi_gengou = Calculation::Base::MultiGengouRoller.transfer(
            multi_gengou: year.multi_gengou, date: date
          )
          Calculation::Base::Year.new(
            multi_gengou: multi_gengou, new_year_date: year.new_year_date,
            months: year.months, total_days: year.total_days
          )
        end
        private_class_method :transfer

        # :reek:TooManyStatements { max_statements: 7 }

        #
        # 月を特定する
        #
        # @param [Year] year 年
        # @param [Western::Calendar] date 西暦日
        #
        # @return [Month] 対象月
        #
        def self.specify_month(year:, date:)
          months = year.months

          current_month = months[0]
          months.each do |month|
            return current_month if month.western_date > date

            current_month = month
          end

          current_month
        end
        private_class_method :specify_month
      end
    end
  end
end
