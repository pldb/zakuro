# frozen_string_literal: true

require_relative '../abstract_option'

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
        # VanishedDate 滅日
        #
        module VanishedDate
          #
          # Option 滅日集約
          #
          class Option < AbstractOption
            # @return [Calculation] 演算値
            attr_reader :calculation

            #
            # 初期化
            #
            # @param [True, False] matched オプション値有無
            # @param [Calculation] calculation 演算値
            #
            def initialize(matched: false, calculation: Calculation.new)
              super(matched: matched)
              @calculation = calculation
            end
          end
        end
      end
    end
  end
end
