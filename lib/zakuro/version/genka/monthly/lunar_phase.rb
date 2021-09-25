# frozen_string_literal: true

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

        # TODO: AbstractLunarPhase でも使用している

        # @return [Array<String>] 月内の弦
        PHASE_INDEXES = %w[朔日 上弦 望月 下弦].freeze

        # @return [Cycle::AbstractRemainder] 経
        attr_reader :remainder

        #
        # 初期化
        #
        # @param [Cycle::Remainder] remainder 正月経朔
        # @param [Cycle::SolarTerm] solar_term 正月中気/節気
        #
        def initialize(remainder:, solar_term:)
          # 二十四節気
          @solar_term = solar_term

          # 経
          @remainder = remainder

          # 弦の位置
          @index = 0
        end

        #
        # 次の弦に進める
        #
        # @return [Remainder] 定朔
        #
        def next_phase
          adjusted = remainder.clone

          add_quarter_moon_size

          adjusted
        end

        #
        # 次の月に進める
        # @note 進めた後の月の定朔ではなく、当月のものを返却する
        #
        # @return [Remainder] 当月初の定朔
        #
        def next_month
          result = nil
          PHASE_INDEXES.each_with_index do |_phase, index|
            adjust = next_phase
            result = adjust if index.zero?
          end

          result
        end

        private

        #
        # 次の弦に進める
        #
        # @return [Integer] 弦
        #
        def next_index
          @index += 1
          @index = 0 if @index >= PHASE_INDEXES.size
          @index
        end

        def add_quarter_moon_size
          @remainder.add!(QUARTER)

          next_index
        end
      end
    end
  end
end
