# frozen_string_literal: true

require_relative '../../../../era/western/calendar'
require_relative '../../../../output/response'
require_relative '../../../../output/logger'

require_relative '../../../base/year'

require_relative '../../internal/day'
require_relative '../../internal/option'

require_relative './single_solar_term'

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

            class << self
              #
              # 取得する
              #
              # @param [Array<Base::Year>] years 範囲
              # @param [Western::Calendar] date 西暦日
              #
              # @return [Result::Data::SingleDay] 和暦日
              #
              def get(years: [], date: Western::Calendar.new)
                year, month = specify(years: years, date: date)

                day = Day.get(month: month, date: date)

                solar_term = SingleSolarTerm.get(years: years, month: month, day: day)

                # TODO: make
                p solar_term

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
              # @param [Western::Calendar] date 西暦日
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

              # :reek:TooManyStatements { max_statements: 7 }

              #
              # 月を特定する
              #
              # @param [Base::Year] year 年
              # @param [Western::Calendar] date 西暦日
              #
              # @return [Monthly::Month] 対象月
              #
              def specify_month(year:, date:)
                months = year.months

                months.each do |month|
                  western_date = month.western_date
                  next if western_date.invalid?

                  return month if month.include?(date: date)
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
