# frozen_string_literal: true

require_relative '../../const/const'

# :nodoc:
module Zakuro
  # :nodoc:
  module Senmyou
    # :nodoc:
    module Lunar
      #
      # Location 入暦
      #
      class Location
        # @return [Integer] 暦中日
        # @note ANOMALISTIC_MONTH の半分に相当する
        HALF_ANOMALISTIC_MONTH = \
          Cycle::LunarRemainder.new(day: 13, minute: 6529, second: 9.5)
        # @return [Integer] 入暦上限
        LIMIT = Cycle::Remainder.new(day: 14, minute: 6529, second: 0)
        # @return [Remainder] 弦
        QUARTER = Cycle::LunarRemainder.new(day: 7, minute: 3214, second: 25)

        # @return [True] 計算済み（前回計算あり）
        # @return [False] 未計算（初回計算）
        attr_reader :calculated
        # @return [True] 進（遠地点より数える）
        # @return [False] 退（近地点より数える）
        attr_reader :forward
        # @return [Cycle::LunarRemainder] 大余小余（初回：昨年冬至）
        attr_reader :remainder

        def initialize(remainder:, calculated: false, forward: false)
          @calculated = calculated
          @forward = forward
          @remainder = remainder
        end

        def limit
          return LIMIT if calculated

          HALF_ANOMALISTIC_MONTH
        end

        def first
          decrease
          one_based

          @calculated = true
        end

        def decrease
          return if @remainder < limit

          @remainder.sub!(HALF_ANOMALISTIC_MONTH)
          @forward = !@forward
        end

        def one_based
          @remainder.add!(Cycle::Remainder.new(day: 1, minute: 0, second: 0))
        end

        def add_quarter
          @remainder.add!(QUARTER)
        end
      end
    end
  end
end
