# frozen_string_literal: true

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
      # SolarTerm 二十四節気
      #
      class SolarTerm
        # @return [Integer] 連番
        attr_reader :index
        # @return [String] 大余小余
        attr_reader :remainder

        #
        # 初期化
        #
        # @param [Integer] index 連番
        # @param [String] remainder 大余小余
        #
        def initialize(index:, remainder:)
          @index = index
          @remainder = remainder
        end
      end
    end
  end
end
