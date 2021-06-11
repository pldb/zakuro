# frozen_string_literal: true

require_relative '../../../calculation/cycle/abstract_solar_term'

require_relative '../const/remainder'

require_relative './remainder'

# :nodoc:
module Zakuro
  # :nodoc:
  module Daien
    # :nodoc:
    module Cycle
      #
      # SolarTerm 二十四節気
      #
      class SolarTerm < Calculation::Cycle::AbstractSolarTerm
        # @return [Remainder] 気策（24分の1年）
        SOLAR_TERM_AVERAGE = Const::Remainder::Solar::SOLAR_TERM_AVERAGE

        #
        # 初期化
        #
        # @param [Integer] index 連番
        # @param [Remainder] remainder 時刻情報（大余小余）
        #
        def initialize(index: -1, remainder: Remainder.new)
          super(index: index, remainder: remainder, average: SOLAR_TERM_AVERAGE)
        end
      end
    end
  end
end
