# frozen_string_literal: true

require_relative '../../../../calculation/stella/solar/choukei_value'

require_relative '../../const/number'

require_relative './adjustment'

# :nodoc:
module Zakuro
  # :nodoc:
  module Senmyou
    # :nodoc:
    module Solar
      #
      # Value 太陽補正値
      #
      module Value
        # @return [Integer] 1日
        DAY = Const::Number::Cycle::DAY

        #
        # 太陽の運行による補正値を算出する
        #
        # @param [SolarTerm] solar_location 入定気
        #
        # @return [Integer] 補正値
        #
        def self.get(solar_location:)
          remainder = solar_location.remainder

          row = Adjustment.specify(index: solar_location.index)

          Calculation::Solar::ChoukeiValue.get(remainder: remainder, row: row)
        end
      end
    end
  end
end
