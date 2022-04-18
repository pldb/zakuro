# frozen_string_literal: true

require_relative './gengou'

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
      # Year 年
      #
      class Year
        # @return [Gengou] 元号（1行目）
        attr_reader :first_gengou
        # @return [Gengou] 元号（2行目）
        attr_reader :second_gengou
        # @return [String] 十干十二支
        attr_reader :zodiac_name
        # @return [Integer] 日数
        attr_reader :total_days

        #
        # 初期化
        #
        # @param [Gengou] first_gengou 元号（1行目）
        # @param [Gengou] second_gengou 元号（2行目）
        # @param [String] zodiac_name 十干十二支
        # @param [Integer] total_days 日数
        #
        def initialize(first_gengou:, second_gengou:, zodiac_name:, total_days:)
          @first_gengou = first_gengou
          @second_gengou = second_gengou
          @zodiac_name = zodiac_name
          @total_days = total_days
        end
      end
    end
  end
end
