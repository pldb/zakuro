# frozen_string_literal: true

require_relative '../../era/western/calendar'

# :nodoc:
module Zakuro
  # :nodoc:
  module Calculation
    # :nodoc:
    module Gengou
      # Reserver
      #
      # 元号に基づき計算範囲を予約する
      #
      module Reserver
        #
        # 予約結果を取得する
        #
        # @param [Western::Calendar] start_date 開始日
        # @param [Western::Calendar] end_date 終了日
        #
        # @return [ReservedInterval] 予約済み計算範囲
        #
        def self.get(start_date: Western::Calendar.new, end_date: Western::Calendar.new)
          # TODO: todo
        end
      end
    end
  end
end
