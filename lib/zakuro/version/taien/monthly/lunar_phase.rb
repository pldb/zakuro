# frozen_string_literal: true

require_relative '../../../calculation/monthly/abstract_lunar_phase'

require_relative '../const/remainder'

require_relative '../stella/solar/location'
require_relative '../stella/solar/value'
require_relative '../stella/lunar/location'
require_relative '../stella/lunar/value'

require_relative '../stella/origin/lunar_age'
require_relative '../stella/origin/average_november'

# :nodoc:
module Zakuro
  # :nodoc:
  module Taien
    # :nodoc:
    module Monthly
      #
      # LunarPhase 月の位相
      #
      class LunarPhase < Calculation::Monthly::AbstractLunarPhase
        # @return [Cycle::Remainder] 弦
        QUARTER = Const::Remainder::Solar::QUARTER

        #
        # 初期化
        #
        # @param [Integer] western_year 西暦年
        #
        def initialize(western_year:)
          # 天正閏余
          lunar_age = Origin::LunarAge.get(western_year: western_year)

          super(
            quater: QUARTER,
            average_remainder: Origin::AverageNovember.get(western_year: western_year),
            solar_location: Solar::Location.new(lunar_age: lunar_age),
            lunar_location: Lunar::Location.new(
              western_year: western_year,
              lunar_age: Cycle::LunarRemainder.new(total: 0).add!(lunar_age)
            )
          )
        end

        private

        # :reek:TooManyStatements { max_statements: 6 }

        #
        # 現在の定朔を取得する
        #
        # @return [Remainder] 定朔
        #
        def current_remainder
          # debug("@average_remainder.format: #{@average_remainder.format(form: '%d-%d-%.5f')}")

          sum = correction_value
          adjusted = @average_remainder.add(
            Cycle::Remainder.new(day: 0, minute: sum, second: 0)
          )
          # NOTE: 儀鳳暦では進朔しない
          # adjusted.up_on_new_moon!

          debug("result: #{adjusted.format}")

          adjusted
        end

        #
        # 太陽運動の補正値を得る
        #
        # @return [Integer] 太陽運動の補正値
        #
        def correction_solar_value
          @solar_location.run
          # debug("@solar_term.remainder: #{@solar_location.remainder.format(form: '%d-%d-%.5f')}")
          # debug("@solar_term.index: #{@solar_location.index}")

          Solar::Value.get(solar_location: @solar_location)
        end

        # :reek:TooManyStatements { max_statements: 6 }

        #
        # 月運動の補正値を得る
        #
        # @return [Integer] 月運動の補正値
        #
        def correction_moon_value
          @lunar_location.run

          remainder = @lunar_location.remainder

          # debug("[lunar]remainder.format: #{remainder.format(form: '%d-%d-%.5f')}")
          # debug("[lunar]remainder.day: #{remainder.day}")
          # debug("[lunar]remainder.minute: #{remainder.minute}")

          Lunar::Value.get(remainder: remainder)
        end
      end
    end
  end
end
