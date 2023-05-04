# frozen_string_literal: true

require_relative '../../../calculation/monthly/part/const'

require_relative '../const/remainder'

require_relative '../cycle/solar_term'

require_relative '../stella/origin/first_term'

require_relative '../stella/origin/january'

# :nodoc:
module Zakuro
  # :nodoc:
  module Genka
    # :nodoc:
    module Monthly
      #
      # LunarPhase 月の位相
      #
      class LunarPhase
        # @return [Cycle::Remainder] 弦
        QUARTER = Const::Remainder::QUARTER

        # @return [Array<String>] 月内の弦
        PHASE_INDEXES = Calculation::Monthly::Const::PHASE_INDEXES

        # @return [Integer] 弦の位置
        attr_reader :index
        # @return [Cycle::AbstractRemainder] 経
        attr_reader :remainder

        #
        # 初期化
        #
        # @param [Cycle::Remainder] remainder 正月経朔
        #
        def initialize(remainder:)
          # 経
          @remainder = remainder

          # 弦の位置
          @index = 0
        end

        #
        # 次の弦に進める
        #
        # @return [Remainder] 経朔
        #
        def next_phase
          adjusted = remainder.clone

          add_quarter_moon_size

          adjusted
        end

        #
        # 次の月に進める
        # @note 進めた後の月の経朔ではなく、当月のものを返却する
        #
        # @return [Remainder] 当月初の経朔
        #
        def next_month
          result = nil
          PHASE_INDEXES.each_with_index do |_phase, index|
            adjust = next_phase
            result = adjust if index.zero?
          end

          result
        end

        #
        # 経朔を返す
        #
        #  元嘉暦には経朔しかないが他の暦と揃える
        #
        # @return [Remainder] 経朔
        #
        def average_remainder
          @remainder
        end

        private

        #
        # 次の弦に進める
        #
        # @return [Integer] 弦
        #
        def next_index
          @index += 1
          @index = 0 if index >= PHASE_INDEXES.size
          @index
        end

        def add_quarter_moon_size
          remainder.add!(QUARTER)

          next_index
        end
      end
    end
  end
end
