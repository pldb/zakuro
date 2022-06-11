# frozen_string_literal: true

require_relative '../era/gengou/dated_scroll'

require_relative './abstract_operation_range'

# :nodoc:
module Zakuro
  # :nodoc:
  module Calculation
    # :nodoc:
    module Range
      #
      # DatedOperationRange 運用結果範囲
      #
      class DatedOperationRange < AbstractOperationRange
        #
        # 初期化
        #
        # @param [Context::Context] context 暦コンテキスト
        # @param [Western::Calendar] start_date 開始日
        # @param [Western::Calendar] last_date 終了日
        # @param [Array<Year>] years 年データ（完全範囲）
        #
        def initialize(context:, start_date: Western::Calendar.new,
                       last_date: Western::Calendar.new, years: [])
          scroll = Gengou::DatedScroll.new(start_date: start_date, last_date: last_date)
          super(context: context, scroll: scroll, years: years)
        end
      end
    end
  end
end
