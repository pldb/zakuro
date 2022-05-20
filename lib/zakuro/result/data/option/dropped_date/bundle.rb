# frozen_string_literal: true

require_relative './calculation'

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
        # DroppedDate 没日
        #
        module DroppedDate
          #
          # Bundle 没日集約
          #
          class Bundle
            # @return [True] 使用有
            # @return [False] 使用無
            attr_reader :available
            # @return [True] 没日有
            # @return [False] 没日無
            attr_reader :matched
            # @return [Calculation] 演算値
            attr_reader :calculation

            #
            # 初期化
            #
            # @param [True, False] available 使用有無
            # @param [True, False] matched 没日有無
            # @param [Calculation] calculation 演算値
            #
            def initialize(available: false, matched: false, calculation: Calculation.new)
              @available = available
              @matched = matched
              @calculation = calculation
            end
          end
        end
      end
    end
  end
end
