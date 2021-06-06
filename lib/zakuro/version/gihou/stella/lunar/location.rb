# frozen_string_literal: true

require_relative '../../const/remainder'

require_relative './localization'

# :nodoc:
module Zakuro
  # :nodoc:
  module Gihou
    # :nodoc:
    module Lunar
      #
      # Location 入暦
      #
      class Location
        # @return [Cycle::LunarRemainder] 1近点月
        ANOMALISTIC_MONTH = Const::Remainder::Lunar::ANOMALISTIC_MONTH
        # @return [Cycle::LunarRemainder] 入暦上限
        LIMIT = Const::Remainder::Lunar::LIMIT
        # @return [Cycle::LunarRemainder] 弦
        QUARTER = Const::Remainder::Lunar::QUARTER

        # @return [True] 計算済み（前回計算あり）
        # @return [False] 未計算（初回計算）
        attr_reader :calculated
        # @return [Integer] 西暦年
        attr_reader :western_year
        # @return [Cycle::LunarRemainder] 大余小余（初回：昨年天正閏余）
        attr_reader :remainder

        #
        # 初期化
        #
        # @param [Cycle::LunarRemainder] lunar_age 天正閏余（大余小余）
        # @param [Integer] western_year 西暦年
        #
        def initialize(lunar_age:, western_year:)
          @calculated = false
          @western_year = western_year
          @remainder = lunar_age
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
            lunar_age: @remainder, western_year: @western_year
          )
          # 初回は0始まりで計算しているので、入暦上限ではなく1近点月を用いる
          decrease(limit: ANOMALISTIC_MONTH)
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

          @remainder.sub!(ANOMALISTIC_MONTH)
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
