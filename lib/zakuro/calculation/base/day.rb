# frozen_string_literal: true

require_relative '../../era/western/calendar'
require_relative '../cycle/abstract_remainder'

# :nodoc:
module Zakuro
  # :nodoc:
  module Calculation
    # :nodoc:
    module Base
      #
      # Day 日
      #
      class Day
        # @return [Integer] 不正日
        INVALID_NUMBER = -1

        # @return [Integer] 日
        attr_reader :number
        # @return [Western::Calendar] 西暦日
        attr_reader :western_date
        # @return [Cycle::AbstractRemainder] 和暦日
        attr_reader :remainder

        #
        # 初期化
        #
        # @param [Integer] number 日
        # @param [Western::Calendar] western_date 西暦日
        # @param [Cycle::AbstractRemainder] 和暦日
        #
        def initialize(number: 1, western_date: Western::Calendar.new,
                       remainder: Cycle::AbstractRemainder.new)
          @number = number
          @western_date = western_date
          @remainder = remainder
        end

        #
        # 不正か
        #
        # @return [True] 不正
        # @return [False] 不正なし
        #
        def invalid?
          number == INVALID_NUMBER
        end
      end
    end
  end
end
