# frozen_string_literal: true

require_relative '../../../../era/japan/calendar'
require_relative '../../../../era/western/calendar'
require_relative '../../../../output/response'
require_relative '../../../../output/logger'

require_relative '../../../base/year'

require_relative '../../internal/day'
require_relative '../../internal/option'

# :nodoc:
module Zakuro
  # :nodoc:
  module Calculation
    # :nodoc:
    module Summary
      # :nodoc:
      module Japan
        # :nodoc:
        module Specifier
          #
          # SingleDay 一日検索
          #
          module SingleDay
            # @return [Output::Logger] ロガー
            LOGGER = Output::Logger.new(location: 'specifier')

            class << self
              #
              # 取得する
              #
              # @param [Array<Year>] yeas 範囲
              # @param [Japan::Calendar] date 和暦日
              #
              # @return [Result::Data::SingleDay] 和暦日
              #
              def get(years: [], date: Japan::Calendar.new)
                year, month = specify(years: years, date: date)
                first_date = month.western_date.clone
                days = date.day - 1
                western_date = first_date + days
                day = Day.get(month: month, date: western_date)

                options = Option.create(month: month, day: day)

                Output::Response::SingleDay.create(
                  year: year, month: month, day: day, options: options
                )
              end

              private

              #
              # 年を特定する
              #
              # @param [Array<Year>] years 範囲
              # @param [Japan::Calendar] date 和暦日
              #
              # @return [Base::Year] 対象年
              # @return [Monthly::Month] 対象月
              #
              # @raise [ArgumentError] 引数エラー
              #
              def specify(years:, date:)
                years.each do |year|
                  month = specify_month(year: year, date: date)
                  return year, month unless month.invalid?
                end

                raise ArgumentError, "invalid year range. date: #{date.format}"
              end

              #
              # 月を特定する
              #
              # @param [Base::Year] year 年
              # @param [Japan::Calendar] date 和暦日
              #
              # @return [Monthly::Month] 対象月
              #
              def specify_month(year:, date:)
                months = year.months

                months.each do |month|
                  return month if month.include_by_japan_date?(date: date)
                end

                Monthly::Month.new
              end
            end
          end
        end
      end
    end
  end
end
