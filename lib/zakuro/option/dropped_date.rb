# frozen_string_literal: true

# :nodoc:
module Zakuro
  # :nodoc:
  module Calculation
    # :nodoc:
    module Option
      #
      # DroppedDate 没日
      #
      class DroppedDate
        # @return [Cycle::AbstractRemainder] 「有没之気」判定
        attr_reader :limit
        # @return [Integer] 年
        attr_reader :year
        # @return [Cycle::AbstractSolarTerm] 二十四節気
        attr_reader :solar_term

        #
        # 初期化
        #
        # @param [Cycle::AbstractRemainder] limit 「有没之気」判定
        # @param [Integer] year 年
        # @param [Cycle::AbstractSolarTerm] solar_term 二十四節気
        #
        def initialize(limit:, year:, solar_term:)
          @limit = limit
          @year = year
          @solar_term = solar_term
        end

        #
        # 没日が存在するか？
        #
        # @return [True] 存在あり
        # @return [False] 存在なし
        #
        def exist?
          remainder = solar_term_remainder
          minute_later = remainder.class.new(
            day: 0, minute: remainder.minute, second: remainder.second
          )

          minute_later >= limit
        end

        #
        # 「没余」を返す
        #
        # @return [Cycle::AbstractRemainder] 没余
        #
        def remainder
          # TODO: make

          # 1. 二十四節気の大余小余を取り出す
          # 2. 小余360、秒45（360/8）で積算する
          # 3. 上記2と章歳（3068055）の差を求める
          # 4. 上記3を通余で徐算する
          # 5. 上記4の商と上記1の大余が没日大余、余りが小余（没余）
        end

        private

        def solar_term_remainder
          solar_term.remainder.clone
        end
      end
    end
  end
end
