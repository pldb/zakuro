# frozen_string_literal: true

require_relative '../era/gengou/dated_scroll'
require_relative './abstract_full_range'

# :nodoc:
module Zakuro
  # :nodoc:
  module Calculation
    # :nodoc:
    module Range
      #
      # DatedFullRange 完全範囲
      #
      class DatedFullRange < AbstractFullRange
        #
        # 初期化
        #
        # @param [Context::Context] context 暦コンテキスト
        # @param [Western::Calendar] start_date 開始日
        # @param [Western::Calendar] last_date 終了日
        # @param [True, False] operated 運用値設定
        #
        def initialize(context:, start_date: Western::Calendar.new,
                       last_date: Western::Calendar.new, operated: false)
          scroll = Gengou::DatedScroll.new(
            start_date: start_date, last_date: last_date, operated: operated
          )

          super(context: context, scroll: scroll, start_date: start_date, last_date: last_date)
        end
      end
    end
  end
end
