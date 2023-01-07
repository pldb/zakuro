# frozen_string_literal: true

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
      module Western
        # :nodoc:
        module Specifier
          #
          # SingleSolarTerm 単一二十四節気
          #
          module SingleSolarTerm
            # @return [Output::Logger] ロガー
            LOGGER = Output::Logger.new(location: 'specifier')

            class << self
              #
              # 日に対応する二十四節気を特定する
              #
              # @param [Array<Base::Year>] years 範囲
              # @param [Monthly::Month] month 対象月
              # @param [Base::Day] day 日
              #
              # @return [Cycle::AbstractSolarTerm] 二十四節気
              #
              def get(years:, month:, day:)
                # TODO: make
                months = []
                years.each do |year|
                  months.concat(year.months.clone)
                end

                index = index_of(months: months, month: month)

                specify(months: months, index: index, day: day)
              end

              private

              #
              # 月の位置を取得する
              #
              # @param [Array<Base::Month>] months 範囲
              # @param [Monthly::Month] month 対象月
              #
              # @return [Integer] 位置
              #
              def index_of(months:, month:)
                months.each_with_index do |_, index|
                  return index if months[index] == month
                end

                -1
              end

              #
              # 特定する
              #
              # @param [Array<Base::Month>] months 範囲
              # @param [Integer] index 対象連番
              # @param [Base::Day] day 日
              #
              # @return [Cycle::AbstractSolarTerm] 二十四節気
              #
              def specify(months: [], index:, day:)
                # TODO: 下記の処理は廃止したい
                #  理由としては常に前月の二十四節気がある訳ではない
                #  前月が必ずある時点で関連する二十四節気を収集したい
                solar_terms = []
                solar_terms = solar_terms.concat(months[index - 1].solar_term[-1])
                solar_terms = solar_terms.concat(months[index].solar_terms)

                # 特定方法を詳述する
                #
                # 求める日の大余は、求める月（month[index]）のいずれかにある
                #
                # |No| 項目          | 前月                |  当月              | 次月                |
                # |1 | 月            | month[index - 1]   |   month[index]    |   month[index + 1]  |
                # |2 | 考えられる範囲  |                    |-------------------|                     |
                # |3 | 二十四節気連番  | 0          1       |   2        3      |   4          5      |
                # |4 | 二十四節気大余  | 55         10      |   25       40     |   55         5      |
                solar_terms.each_cons(2) do |current_solar_term, next_solar_term|
                  day = day.remainder.day
                  current_day = current_solar_term.remainder.day
                  next_day = next_solar_term.remainder.day

                  # TODO: 大余が一巡した場合の考慮がない
                  return current_solar_term if current_day <= day && next_day > day
                end

                solar_terms[-1]
              end
            end
          end
        end
      end
    end
  end
end
