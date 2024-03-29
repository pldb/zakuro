# frozen_string_literal: true

require_relative '../era/gengou/named_scroll'

require_relative './abstract_operation_range'

# :nodoc:
module Zakuro
  # :nodoc:
  module Calculation
    # :nodoc:
    module Range
      #
      # NamedOperationRange 運用結果範囲
      #
      class NamedOperationRange < AbstractOperationRange
        # @return [String] 不正元号名
        INVALID_NAME = Japan::Calendar::EMPTY

        #
        # 初期化
        #
        # @param [Context::Context] context 暦コンテキスト
        # @param [String] start_name 開始元号名
        # @param [String] last_name 終了元号名
        # @param [Array<Year>] years 年データ（完全範囲）
        #
        def initialize(context:, start_name: INVALID_NAME, last_name: INVALID_NAME, years: [])
          scroll = Gengou::NamedScroll.new(
            start_name: start_name, last_name: last_name, operated: true
          )

          super(context: context, scroll: scroll, years: years)
        end
      end
    end
  end
end
