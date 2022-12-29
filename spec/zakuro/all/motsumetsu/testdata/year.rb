# frozen_string_literal: true

require_relative './gengou'

require_relative './japan_date'

# :nodoc:
module Zakuro
  # :nodoc:
  module All
    # :nodoc:
    module Motsumetsu
      #
      # Year 年
      #
      class Year
        # @return [Gengou] 元号
        attr_reader :gengou
        # @return [Array<JapanDate>] 和暦日
        attr_reader :dates

        #
        # 初期化
        #
        # @param [Gengou] gengou 元号
        # @param [Array<JapanDate>] dates 和暦日
        #
        def initialize(gengou: Gengou.new, dates: [])
          @gengou = gengou
          @dates = dates
        end

        #
        # 不正か
        #
        # @return [True] 不正
        # @return [False] 不正なし
        #
        def invalid?
          dates.size.zero?
        end
      end
    end
  end
end
