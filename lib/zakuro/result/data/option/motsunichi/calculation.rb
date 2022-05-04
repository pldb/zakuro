# frozen_string_literal: true

require_relative './solar_term'

# :nodoc:
module Zakuro
  #
  # Result 演算結果
  #
  module Result
    #
    # データ部
    #
    module Data
      #
      # Option オプション
      #
      module Option
        #
        # Motsunichi 没日
        #
        module Motsunichi
          #
          # Calculation 演算値
          #
          class Calculation
            # @return [String] 大余小余（没余）
            attr_reader :remainder
            # @return [SolarTerm] 二十四節気
            attr_reader :solar_term

            #
            # 初期化
            #
            # @param [String] remainder 大余小余（没余）
            # @param [SolarTerm] solar_term 二十四節気
            #
            def initialize(remainder: '', solar_term: SolarTerm.new)
              @remainder = remainder
              @solar_term = solar_term
            end
          end
        end
      end
    end
  end
end
