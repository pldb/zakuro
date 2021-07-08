# frozen_string_literal: true

require_relative '../../../../calculation/stella/lunar/abstract_location'

require_relative '../../const/remainder'

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
      class Location < Calculation::Lunar::AbstractLocation
        # @return [Cycle::LunarRemainder] 暦中日（1近点月の半分）
        HALF_ANOMALISTIC_MONTH = Const::Remainder::Lunar::HALF_ANOMALISTIC_MONTH
        # @return [Cycle::LunarRemainder] 弦
        QUARTER = Const::Remainder::Lunar::QUARTER

        # @return [True] 進
        # @return [False] 退
        attr_reader :forward

        #
        # 初期化
        #
        # @param [Cycle::LunarRemainder] lunar_age 天正閏余（大余小余）
        # @param [Integer] western_year 西暦年
        #
        def initialize(lunar_age:, western_year:)
          super(lunar_age: lunar_age, western_year: western_year)
          # 進
          @forward = true
        end

        #
        # 入暦を計算する
        #
        def run
          if calculated
            decrease(limit: HALF_ANOMALISTIC_MONTH)
            return
          end

          first
        end

        #
        # 弦の分だけ月地点を進める
        #
        def add_quarter
          remainder.add!(QUARTER)
        end

        private

        #
        # 初回計算
        #
        def first
          @remainder = Localization.first_remainder(
            lunar_age: remainder, western_year: western_year
          )
          decrease(limit: HALF_ANOMALISTIC_MONTH)

          @calculated = true
        end

        #
        # 大余小余に合わせて減算する（折り返す）
        #
        # @param [Cycle::LunarRemainder] limit 上限
        #
        def decrease(limit:)
          return if remainder < limit

          remainder.sub!(limit)
          @forward = !forward
        end
      end
    end
  end
end
