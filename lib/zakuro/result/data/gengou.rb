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
      # Gengou 元号
      #
      class Gengou
        # @return [String] 元号名
        attr_reader :name
        # @return [Integer] 元号年
        attr_reader :number

        #
        # 初期化
        #
        # @param [String] name 元号名
        # @param [Integer] number 元号年
        #
        def initialize(name: '', number: -1)
          @name = name
          @number = number
        end
      end
    end
  end
end
