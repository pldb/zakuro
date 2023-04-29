# frozen_string_literal: true

require_relative './abstract_scroll'
require_relative './internal/reserve/dated_range'

# :nodoc:
module Zakuro
  # :nodoc:
  module Calculation
    # :nodoc:
    module Gengou
      # DatedScroll
      #
      # 元号スクロール
      #
      class DatedScroll < AbstractScroll
        #
        # 初期化
        #
        # @param [Western::Calendar] start_date 西暦開始日（最大範囲）
        # @param [Western::Calendar] last_date 西暦終了日（最大範囲）
        # @param [True, False] operated 運用値設定
        # @param [True, False] restored 運用値から計算値に戻すか
        #
        def initialize(start_date: Western::Calendar.new, last_date: Western::Calendar.new,
                       operated: false, restored: false)
          range = Reserve::DatedRange.new(
            start_date: start_date, last_date: last_date, operated: operated,
            restored: restored
          )
          super(range: range)
        end
      end
    end
  end
end
