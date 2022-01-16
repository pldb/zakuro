# frozen_string_literal: true

require_relative '../../../../era/western/calendar'
require_relative './reserve/interval'
require_relative './reserve/list'

# :nodoc:
module Zakuro
  # :nodoc:
  module Calculation
    # :nodoc:
    module Gengou
      # Reserve
      #
      # 元号に基づき計算範囲を予約する
      #
      module Reserve
        #
        # 予約結果を取得する
        #
        #   * 開始日・終了日から計算する範囲を求める
        #   * 開始日・終了日の範囲内にある元号全てが対象となる
        #   * 元号に応じて計算範囲は変化する
        #     * 元号の開始日（改元日）が開始日よりも前であれば、結果開始日は前者になる
        #     * 元号の終了日（改元前日）が終了日よりも後であれば、結果終了日は前者になる
        #     * 南北朝のように複数元号に属する場合、より広い範囲の元号に合わせる
        #   * 属する元号よりもさらに範囲を広げる場合がある
        #     * 開始日が最初の元号の改元後30日以内の場合、さらに前の元号まで対象にする
        #     * 終了日が最後の元号の改元前日30日以内の場合、さらに次の元号まで対象にする
        #
        # @param [Western::Calendar] start_date 開始日
        # @param [Western::Calendar] last_date 終了日
        #
        # @return [Interval] 予約済み計算範囲
        #
        def self.get(start_date: Western::Calendar.new, last_date: Western::Calendar.new)
          Interval.new(start_date: start_date, last_date: last_date)
        end
      end
    end
  end
end
