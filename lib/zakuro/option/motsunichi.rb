# frozen_string_literal: true

# :nodoc:
module Zakuro
  # :nodoc:
  module Calculation
    # :nodoc:
    module Option
      #
      # Motsunichi 没日
      #
      class Motsunichi
        # @return [Cycle::AbstractRemainder] 「有没之気」判定
        attr_reader :limit
        # @return [Cycle::AbstractSolarTerm] 二十四節気
        attr_reader :solar_term

        #
        # 初期化
        #
        # @param [Cycle::AbstractRemainder] limit 「有没之気」判定
        # @param [Cycle::AbstractSolarTerm] solar_term 二十四節気
        #
        def initialize(limit:, solar_term:)
          @limit = limit
          @solar_term = solar_term
        end

        #
        # 没日が存在するか？
        #
        # @return [True] 存在あり
        # @return [False] 存在なし
        #
        def exist?
          remainder = solar_term.remainder.clone
          minute_later = remainder.class.new(day:0, minute: remainder.minute, second: remainder.second)

          minute_later >= limit
        end

        #
        # 「没余」を返す
        #
        # @return [Cycle::AbstractRemainder] 没余
        #
        def remainder
          # TODO: make
        end
      end
    end
  end
end
