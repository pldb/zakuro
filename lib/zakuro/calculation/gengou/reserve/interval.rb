# frozen_string_literal: true

require_relative '../../../era/western/calendar'

# :nodoc:
module Zakuro
  # :nodoc:
  module Calculation
    # :nodoc:
    module Gengou
      # :nodoc:
      module Reserve
        # Interval
        #
        # 予約済み計算範囲
        #
        class Interval
          # @return [List<Base::CountableGengou>] 1行目元号
          attr_reader :first_gengou_list
          # @return [List<Base::CountableGengou>] 2行目元号
          attr_reader :second_gengou_list

          #
          # 初期化
          #
          # @param [List<Base::CountableGengou>] first_gengou_list 1行目元号
          # @param [List<Base::CountableGengou>] second_gengou_list 2行目元号
          #
          def initialize(first_gengou_list: [], second_gengou_list: [])
            @first_gengou_list = first_gengou_list
            @second_gengou_list = second_gengou_list
          end
        end
      end
    end
  end
end
