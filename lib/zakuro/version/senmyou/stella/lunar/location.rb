# frozen_string_literal: true

require_relative '../../const/const'
require_relative './localization'

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
        LIMIT = Cycle::LunarRemainder.new(day: 14, minute: 6529, second: 0)
        # @return [Remainder] 弦
        QUARTER = Cycle::LunarRemainder.new(day: 7, minute: 3214, second: 25)

        # @return [True] 計算済み（前回計算あり）
        # @return [False] 未計算（初回計算）
        attr_reader :calculated
        # @return [Integer] 西暦年
        attr_reader :western_year
        # @return [True] 進（遠地点より数える）
        # @return [False] 退（近地点より数える）
        attr_reader :forward
        # @return [Cycle::LunarRemainder] 大余小余（初回：昨年天正閏余）
        attr_reader :remainder

        #
        # 初期化
        #
        # @param [Cycle::LunarRemainder] remainder 大余小余（初回：昨年天正閏余）
        # @param [Integer] western_year 西暦年
        # @param [True, False] forward 進（遠地点より数える）/退（近地点より数える）
        #
        def initialize(remainder:, western_year:, forward: true)
          @calculated = false
          @western_year = western_year
          @forward = forward
          @remainder = remainder
        end

        #
        # 入暦を計算する
        #
        def run
          if calculated
            # 1始まりで計算しているので、入暦上限を用いる
            decrease(limit: LIMIT)
            return
          end

          first
        end

        #
        # 弦の分だけ月地点を進める
        #
        def add_quarter
          @remainder.add!(QUARTER)
        end

        private

        #
        # 初回計算
        #
        def first
          @remainder = Localization.first_remainder(
            winter_solstice_age: @remainder, western_year: @western_year
          )
          # 初回は0始まりで計算しているので、暦中日を用いる
          decrease(limit: HALF_ANOMALISTIC_MONTH)
          # 1始まりに改める
          one_based

          @calculated = true
        end

        #
        # 大余小余に合わせて減算する（折り返す）
        #
        # @param [Cycle::LunarRemainder] limit 上限
        #
        def decrease(limit:)
          return if @remainder < limit

          @remainder.sub!(HALF_ANOMALISTIC_MONTH)
          @forward = !@forward
        end

        #
        # 1始まりにする
        #
        def one_based
          @remainder.add!(Cycle::Remainder.new(day: 1, minute: 0, second: 0))
        end
      end
    end
  end
end
