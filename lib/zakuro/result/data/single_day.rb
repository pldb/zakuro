# frozen_string_literal: true

require_relative '../core'

require_relative './option/abstract_option'

require_relative 'year'

require_relative 'month'

require_relative 'day'

# :nodoc:
module Zakuro
  #
  # Result 演算結果
  #
  module Result
    #
    # データ部
    #
    module Data
      #
      # SingleDay 1日
      #
      class SingleDay < Core
        # @return [Year] 年
        attr_reader :year
        # @return [Month] 月
        attr_reader :month
        # @return [Day] 日
        attr_reader :day
        # @return [Map<String, Option::AbstractOption>] オプション
        attr_reader :options

        #
        # 初期化
        #
        # @param [Year] year 年
        # @param [Month] month 月
        # @param [Day] day 日
        # @param [Option::Bundle] options オプション
        #
        def initialize(year:, month:, day:, options: {})
          super
          @year = year
          @month = month
          @day = day
          @options = options
        end
      end
    end
  end
end
