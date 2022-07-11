# frozen_string_literal: true

require_relative '../../../../era/western/calendar'
require_relative '../../../../output/response'
require_relative '../../../../output/logger'

require_relative '../../../base/year'

require_relative '../../internal/month'

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
          # MultipleDay 複数日検索
          #
          module MultipleDay
            # @return [Output::Logger] ロガー
            LOGGER = Output::Logger.new(location: 'specifier')

            class << self
              #
              # 取得する
              #
              # @param [Context::Context] context 暦コンテキスト
              # @param [Array<Calculation::Base::Year>] years 範囲
              # @param [Western::Calendar] start_date 西暦開始日
              # @param [Western::Calendar] last_date 西暦終了日
              #
              # @return [Array<Result::Data::SingleDay>] 期間検索結果（和暦日）
              #
              def get(context:, years: [], start_date: Western::Calendar.new,
                      last_date: Western::Calendar.new)
                months = specify(
                  context: context, years: years, start_date: start_date, last_date: last_date
                )

                result = []
                months.each do |month|
                  result |= month.get
                end

                result
              end

              private

              #
              # 年を特定する
              #
              # @param [Context::Context] context 暦コンテキスト
              # @param [Array<Calculation::Base::Year>] years 範囲
              # @param [Western::Calendar] start_date 西暦開始日
              # @param [Western::Calendar] last_date 西暦終了日
              #
              # @return [Array<Month>] 特定月
              #
              def specify(context:, years: [], start_date: Western::Calendar.new,
                          last_date: Western::Calendar.new)
                result = []
                years.each do |year|
                  result |= specify_month(
                    context: context, year: year, start_date: start_date, last_date: last_date
                  )
                end

                result
              end

              # :reek:TooManyStatements { max_statements: 7 }

              #
              # 月を特定する
              #
              # @param [Context::Context] context 暦コンテキスト
              # @param [Calculation::Base::Year] year 年
              # @param [Western::Calendar] start_date 西暦開始日
              # @param [Western::Calendar] last_date 西暦終了日
              #
              # @return [Month] 対象月
              #
              def specify_month(context:, year:, start_date: Western::Calendar.new,
                                last_date: Western::Calendar.new)
                months = year.months

                specify_months = []
                months.each do |month|
                  next unless include?(month: month, start_date: start_date, last_date: last_date)

                  monthly_start_date = month.western_date.clone
                  monthly_last_date = month.last_date.clone

                  monthly_start_date = start_date.clone if start_date > monthly_start_date

                  monthly_last_date = last_date.clone if last_date < monthly_last_date

                  specify_months.push(
                    Month.new(context: context, year: year, month: month,
                              start_date: monthly_start_date, last_date: monthly_last_date)
                  )
                end

                specify_months
              end

              #
              # 月が範囲に含まれるか
              #
              # @param [Calculation::Monthly::Month] month 月
              # @param [Western::Calendar] start_date 西暦開始日
              # @param [Western::Calendar] last_date 西暦終了日
              #
              # @return [True] 含む
              # @return [False] 含まない
              #
              def include?(month:, start_date:, last_date:)
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

              #
              # 範囲が月より前にあるか
              #
              # @param [Western::Calendar] monthly_start_date 月初日
              # @param [Western::Calendar] start_date 西暦開始日
              # @param [Western::Calendar] last_date 西暦終了日
              #
              # @return [True] 前にある
              # @return [False] 前にない
              #
              def under(monthly_start_date:, start_date:, last_date:)
                start_date < monthly_start_date && last_date < monthly_start_date
              end

              #
              # 範囲が月より後にあるか
              #
              # @param [Western::Calendar] monthly_start_date 月末日
              # @param [Western::Calendar] start_date 西暦開始日
              # @param [Western::Calendar] last_date 西暦終了日
              #
              # @return [True] 後にある
              # @return [False] 後にない
              #
              def over(monthly_last_date:, start_date:, last_date:)
                start_date > monthly_last_date && last_date > monthly_last_date
              end
            end
          end
        end
      end
    end
  end
end
