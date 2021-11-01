# frozen_string_literal: true

require_relative '../../era/western/calendar'

# :nodoc:
module Zakuro
  # :nodoc:
  module Calculation
    # :nodoc:
    module Gengou
      # ReservedInterval
      #
      # 予約済み計算範囲
      #
      class ReservedInterval
        # @return [List<Base::CountableGengou>] 1行目元号
        attr_reader :first_gengou_list
        # @return [List<Base::CountableGengou>] 2行目元号
        attr_reader :second_gengou_list
        # @return [Western::Calendar] 開始日
        attr_reader :start_date
        # @return [Western::Calendar] 終了日
        attr_reader :end_date

        #
        # 初期化
        #
        # @param [List<Base::CountableGengou>] first_gengou_list 1行目元号
        # @param [List<Base::CountableGengou>] second_gengou_list 2行目元号
        # @param [Western::Calendar] start_date 開始日
        # @param [Western::Calendar] end_date 終了日
        #
        def initialize(first_gengou_list: [], second_gengou_list: [],
                       start_date: Western::Calendar.new, end_date: Western::Calendar)
          @first_gengou_list = first_gengou_list
          @second_gengou_list = second_gengou_list
          @start_date = start_date
          @end_date = end_date
        end
      end
    end
  end
end
