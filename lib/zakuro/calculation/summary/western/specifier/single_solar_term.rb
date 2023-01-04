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
                # TODO: make
              end
            end
          end
        end
      end
    end
  end
end
