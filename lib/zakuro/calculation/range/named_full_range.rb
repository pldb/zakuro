# frozen_string_literal: true

require_relative '../era/gengou/named_scroll'
require_relative './abstract_full_range'

# :nodoc:
module Zakuro
  # :nodoc:
  module Calculation
    # :nodoc:
    module Range
      #
      # NamedFullRange 完全範囲
      #
      class NamedFullRange < AbstractFullRange
        # @return [String] 不正元号名
        INVALID_NAME = Japan::Calendar::EMPTY

        #
        # 初期化
        #
        # @param [Context::Context] context 暦コンテキスト
        # @param [String] start_name 開始元号名
        # @param [String] last_name 終了元号名
        #
        def initialize(context:, start_name: INVALID_NAME, last_name: INVALID_NAME)
          scroll = Gengou::NamedScroll.new(
            start_name: start_name, last_name: last_name, operated: false
          )
          range = scroll.range

          super(
            context: context, scroll: scroll,
            start_date: range.western_start_date, last_date: range.western_last_date
          )
        end
      end
    end
  end
end
