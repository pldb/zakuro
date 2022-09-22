# frozen_string_literal: true

require_relative '../../cycle/abstract_remainder'

# :nodoc:
module Zakuro
  # :nodoc:
  module Calculation
    # :nodoc:
    module Lunar
      #
      # AbstractLocation 入暦
      #
      class AbstractLocation
        # @return [True] 計算済み（前回計算あり）
        # @return [False] 未計算（初回計算）
        attr_reader :calculated
        # @return [Integer] 西暦年
        attr_reader :western_year
        # @return [Cycle::LunarRemainder] 大余小余（初回：昨年天正閏余）
        attr_reader :remainder
        # @return [Cycle::LunarRemainder] 弦（1朔望月の1/4）
        attr_reader :quarter

        #
        # 初期化
        #
        # @param [Cycle::LunarRemainder] lunar_age 天正閏余（大余小余）
        # @param [Cycle::LunarRemainder] quarter 弦（1朔望月の1/4）
        # @param [Integer] western_year 西暦年
        #
        def initialize(lunar_age:, quarter:, western_year:)
          @calculated = false
          @western_year = western_year
          @remainder = lunar_age
          @quarter = quarter
        end

        #
        # 入暦を計算する
        #
        def run
          # abstract
        end

        #
        # 弦の分だけ月地点を進める
        #
        def add_quarter
          remainder.add!(quarter)
        end

        #
        # 1始まりの大余小余を取得する
        #
        # @return [Cycle::AbstractRemainder] 1始まりの大余小余
        #
        def adjusted_remainder
          remainder.add(Cycle::AbstractRemainder.new(day: 1, minute: 0, second: 0))
        end

        private

        #
        # 初回計算
        #
        def first
          # abstract
        end

        #
        # 大余小余に合わせて減算する（折り返す）
        #
        # @param [Cycle::LunarRemainder] limit 上限
        #
        def decrease(limit:)
          # abstract
        end
      end
    end
  end
end
