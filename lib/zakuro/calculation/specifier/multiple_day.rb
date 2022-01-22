# frozen_string_literal: true

require_relative '../base/year'

require_relative '../../era/western/calendar'
require_relative '../../output/response'
require_relative '../../output/logger'

require_relative './internal/month'

# :nodoc:
module Zakuro
  # :nodoc:
  module Calculation
    # :nodoc:
    module Specifier
      #
      # MultipleDay 複数日検索
      #
      module MultipleDay
        # @return [Output::Logger] ロガー
        LOGGER = Output::Logger.new(location: 'specifier')

        #
        # 取得する
        #
        # @param [Array<Base::Year>] years 範囲
        # @param [Western::Calendar] start_date 西暦開始日
        # @param [Western::Calendar] last_date 西暦終了日
        #
        # @return [Result::Range] 期間検索結果（和暦日）
        #
        def self.get(years: [], start_date: Western::Calendar.new, last_date: Western::Calendar.new)
          months = specify(years: years, start_date: start_date, last_date: last_date)

          result = []
          months.each do |month|
            result |= month.get
          end

          result
        end

        #
        # 年を特定する
        #
        # @param [Array<Year>] years 範囲
        # @param [Western::Calendar] start_date 西暦開始日
        # @param [Western::Calendar] last_date 西暦終了日
        #
        # @return [Array<Month>] 特定月
        #
        def self.specify(years: [], start_date: Western::Calendar.new,
                         last_date: Western::Calendar.new)
          result = []
          years.each do |year|
            result |= specify_month(
              year: year, start_date: start_date, last_date: last_date
            )
          end

          result
        end
        private_class_method :specify

        # :reek:TooManyStatements { max_statements: 7 }

        #
        # 月を特定する
        #
        # @param [Year] year 年
        # @param [Western::Calendar] start_date 西暦開始日
        # @param [Western::Calendar] last_date 西暦終了日
        #
        # @return [Month] 対象月
        #
        def self.specify_month(year:, start_date: Western::Calendar.new,
                               last_date: Western::Calendar.new)
          months = year.months

          specify_months = []
          months.each do |month|
            next unless include?(month: month, start_date: start_date, last_date: last_date)

            monthly_start_date = month.western_date.clone
            monthly_last_date = month.last_date.clone

            monthly_start_date = start_date if start_date > monthly_start_date

            monthly_last_date = last_date if last_date < monthly_last_date

            specify_months.push(
              Month.new(year: year, month: month,
                        start_date: monthly_start_date, last_date: monthly_last_date)
            )
          end

          specify_months
        end
        private_class_method :specify_month

        #
        # 月が範囲に含まれるか
        #
        # @param [Monthly::Month] month 月
        # @param [Western::Calendar] start_date 西暦開始日
        # @param [Western::Calendar] last_date 西暦終了日
        #
        # @return [True] 含む
        # @return [False] 含まない
        #
        def self.include?(month:, start_date:, last_date:)
          monthly_start_date = month.western_date.clone
          monthly_last_date = month.last_date.clone

          return false if monthly_start_date.invalid?

          return false if monthly_last_date.invalid?

          return false if under(monthly_start_date: monthly_start_date,
                                start_date: start_date, last_date: last_date)

          return false if over(monthly_last_date: monthly_last_date,
                               start_date: start_date, last_date: last_date)

          true
        end

        def self.under(monthly_start_date:, start_date:, last_date:)
          start_date > monthly_start_date && last_date > monthly_start_date
        end

        def self.over(monthly_last_date:, start_date:, last_date:)
          monthly_last_date < start_date && monthly_last_date < last_date
        end
      end
    end
  end
end