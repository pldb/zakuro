# frozen_string_literal: true

require_relative '../../era/western/calendar'

# :nodoc:
module Zakuro
  # :nodoc:
  module Calculation
    # :nodoc:
    module Base
      #
      # LinearGengou 直列元号
      #
      class LinearGengou
        INVALID_YEAR = -1

        # @return [Western::Calendar] 開始日
        attr_reader :start_date
        # @return [Western::Calendar] 終了日
        attr_reader :end_date
        # @return [String] 元号名
        attr_reader :name
        # @return [Integer] 年
        attr_reader :year

        #
        # 初期化
        #
        # @param [Western::Calendar] start_date 開始日
        # @param [Western::Calendar] end_date 終了日
        # @param [String] name 元号名
        # @param [Integer] 元号年
        #
        def initialize(start_date: Western::Calendar.new, end_date: Western::Calendar.new,
                       name: '', year: INVALID_YEAR)
          @start_date = start_date
          @end_date = end_date
          @name = name
          @year = year
        end

        #
        # 不正か
        #
        # @return [True] 不正
        # @return [False] 不正なし
        #
        def invalid?
          @name == '' || @year == INVALID_YEAR
        end

        #
        # 範囲内か
        #
        # @param [Western::Calendar] date 西暦日
        #
        # @return [True] 範囲内
        # @return [False] 範囲外
        #
        def include?(date: Western::Calendar.new)
          return false if invalid?

          return false if @start_date.invalid?

          return false if @end_date.invalid?

          return false if date < @start_date

          return false if date > @end_date

          true
        end
      end
    end
  end
end
