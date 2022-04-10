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
      # Day 日
      #
      class Day
        # @return [Integer] 月初日から数えた日（M月d日のdに相当）
        attr_reader :number
        # @return [String] 十干十二支
        attr_reader :zodiac_name
        # @return [String] 大余小余
        attr_reader :remainder
        # @return [String] 年月日
        attr_reader :western_date

        #
        # 初期化
        #
        # @param [Integer] number 月初日から数えた日（M月d日のdに相当）
        # @param [String] zodiac_name 十干十二支
        # @param [String] remainder 大余小余
        # @param [String] western_date 年月日
        #
        def initialize(number:, zodiac_name:, remainder:, western_date:)
          @number = number
          @zodiac_name = zodiac_name
          @remainder = remainder
          @western_date = western_date
        end
      end
    end
  end
end
