# frozen_string_literal: true

require_relative '../core'

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

        #
        # 初期化
        #
        # @param [Year] year 年
        # @param [Month] month 月
        # @param [Day] day 日
        #
        def initialize(year:, month:, day:)
          super
          @year = year
          @month = month
          @day = day
        end
      end
    end
  end
end
