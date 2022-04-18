# frozen_string_literal: true

require_relative './abstract_range'

# :nodoc:
module Zakuro
  # :nodoc:
  module Calculation
    # :nodoc:
    module Gengou
      # :nodoc:
      module Reserve
        #
        # DatedRange 予約済み計算範囲
        #
        class DatedRange < AbstractRange
          #
          # 初期化
          #
          # @param [Western::Calendar] start_date 西暦開始日
          # @param [Western::Calendar] last_date 西暦終了日
          #
          def initialize(start_date: Western::Calendar.new, last_date: Western::Calendar.new)
            super(start_date: start_date, last_date: last_date)
          end
        end
      end
    end
  end
end
