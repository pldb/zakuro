# frozen_string_literal: true

require_relative '../../../../era/western/calendar'
require_relative '../../../../output/response'
require_relative '../../../../output/logger'

require_relative '../../../base/year'

# :nodoc:
module Zakuro
  # :nodoc:
  module Calculation
    # :nodoc:
    module Summary
      # :nodoc:
      module Western
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
              year, month = specify(years: years, date: date)
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
            # @return [Base::Year] 対象年
            # @return [Monthly::Month] 対象月
            #
            def self.specify(years:, date:)
              years.each do |year|
                month = specify_month(year: year, date: date)
                return year, month unless month.invalid?
              end

              raise ArgumentError, "invalid year range. date: #{date.format}"
            end
            private_class_method :specify

            # :reek:TooManyStatements { max_statements: 7 }

            #
            # 月を特定する
            #
            # @param [Base::Year] year 年
            # @param [Western::Calendar] date 西暦日
            #
            # @return [Monthly::Month] 対象月
            #
            def self.specify_month(year:, date:)
              months = year.months

              months.each do |month|
                western_date = month.western_date
                next if western_date.invalid?

                return month if month.include?(date: date)
              end

              Monthly::Month.new
            end
            private_class_method :specify_month
          end
        end
      end
    end
  end
end
