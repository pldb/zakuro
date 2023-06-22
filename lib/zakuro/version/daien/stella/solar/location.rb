# frozen_string_literal: true

require_relative '../../../../calculation/stella/solar/abstract_location'

require_relative '../../const/remainder'

require_relative './interval'

# :nodoc:
module Zakuro
  # :nodoc:
  module Version
    # :nodoc:
    module Daien
      # :nodoc:
      module Solar
        #
        # Location 入定気
        #
        class Location < Calculation::Solar::AbstractLocation
          # @return [Cycle::Remainder] 弦
          QUARTER = Const::Remainder::Solar::QUARTER

          #
          # 初期化
          #
          # @param [Cycle::Remainder] lunar_age 天正閏余（大余小余）
          #
          def initialize(lunar_age:)
            super(lunar_age: lunar_age, quarter: QUARTER)
          end

          # :reek:UtilityFunction

          #
          # 二十四節気番号に対応する入気定日加減数を返す
          #
          # @note 継承のためクラスメソッドにしない
          #
          # @param [Integer] index 二十四節気番号
          #
          # @return [Cycle::Remainder] 入気定日加減数
          #
          def interval(index:)
            Interval.index_of(index)
          end

          # :reek:UtilityFunction

          #
          # 入気定日加減数の要素数を返す
          #
          # @note 継承のためクラスメソッドにしない
          #
          # @return [Integer] 入気定日加減数の要素数
          #
          def interval_size
            Interval.size
          end
        end
      end
    end
  end
end
