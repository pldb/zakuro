# frozen_string_literal: true

require_relative './abstract_scroll'
require_relative './internal/reserve/named_range'

# :nodoc:
module Zakuro
  # :nodoc:
  module Calculation
    # :nodoc:
    module Gengou
      # NamedScroll
      #
      # 元号スクロール
      #
      class NamedScroll < AbstractScroll
        #
        # 初期化
        #
        # @param [String] start_name 開始元号名
        # @param [String] last_name 終了元号名
        #
        def initialize(start_name: INVALID_NAME, last_name: INVALID_NAME)
          range = Reserve::NamedRange.new(start_name: start_name, last_name: last_name)
          super(range: range)
        end
      end
    end
  end
end
