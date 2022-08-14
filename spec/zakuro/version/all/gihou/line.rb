# frozen_string_literal: true

require_relative './month'

# :nodoc:
module Zakuro
  # :nodoc:
  module All
    # :nodoc:
    module Gihou
      # Line 行データ
      class Line
        # @return [Integer] 行番号
        attr_reader :num
        # @return [Month] 月
        attr_reader :month

        #
        # 初期化
        #
        # @param [Integer] num 行番号
        # @param [Month] month 月
        #
        def initialize(num: -1, month: Month.new)
          @num = num
          @month = month
        end

        #
        # 不正か
        #
        # @return [True] 不正
        # @return [False] 不正なし
        #
        def invalid?
          @num == -1
        end

        #
        # ハッシュ化する
        #
        # @return [Hash<String, Objcet>] ハッシュ
        #
        def to_h
          {
            num: num,
            month: month.to_h
          }
        end
      end
    end
  end
end
