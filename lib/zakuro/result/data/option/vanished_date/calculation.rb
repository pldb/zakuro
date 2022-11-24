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
      # Option オプション
      #
      module Option
        #
        # VanishedDate 滅日
        #
        module VanishedDate
          #
          # Calculation 演算値
          #
          class Calculation
            # @return [String] 大余小余（滅余）
            attr_reader :remainder
            # @return [String] 経朔
            attr_reader :average_remainder

            #
            # 初期化
            #
            # @param [String] remainder 大余小余（滅余）
            # @param [String] average_remainder 経朔
            #
            def initialize(remainder: '', average_remainder: '')
              @remainder = remainder
              @average_remainder = average_remainder
            end
          end
        end
      end
    end
  end
end
