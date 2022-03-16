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
        #
        # 初期化
        #
        # @param [Context] context 暦コンテキスト
        # @param [String] start_name 開始元号名
        # @param [String] last_name 終了元号名
        #
        def initialize(context:, start_name:, last_name:)
          scroll = Gengou::NamedScroll.new(start_name: start_name, last_name: last_name)

          super(context: context, scroll: scroll, start_date: start_date, last_date: last_date)
        end
      end
    end
  end
end
