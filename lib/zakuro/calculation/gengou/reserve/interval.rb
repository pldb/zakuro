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
          # @return [Integer] 不正年
          INVALID_YEAR = -1
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

          #
          # 開始西暦年を取得する
          #
          # @return [Integer] 開始西暦年
          #
          def start_western_year
            # TODO: test
            return INVALID_YEAR if invalid?

            first_start_year = first_gengou_list[0].both_start_year.western

            return first_start_year if invalid_second?

            second_start_year = second_gengou_list[0].both_start_year.western

            first_start_year <= second_start_year ? first_start_year : second_start_year
          end

          #
          # 終了西暦年を取得する
          #
          # @return [Integer] 終了西暦年
          #
          def end_western_year
            # TODO: test
            return INVALID_YEAR if invalid?

            first_end_year = first_gengou_list[-1].end_year

            return first_end_year if invalid_second?

            second_end_year = second_gengou_list[-1].end_year

            first_end_year >= second_end_year ? first_end_year : second_end_year
          end

          #
          # 1行目元号が不正か
          #
          # @return [True] 不正
          # @return [True] 不正なし
          #
          def invalid_first?
            return true unless first_gengou_list

            first_gengou_list.size.zero?
          end

          #
          # 2行目元号が不正か
          #
          # @return [True] 不正
          # @return [True] 不正なし
          #
          def invalid_second?
            return true unless second_gengou_list

            second_gengou_list.size.zero?
          end

          #
          # 不正か
          #
          # @return [True] 不正
          # @return [True] 不正なし
          #
          def invalid?
            # 1行目元号が存在しない場合は不正
            return true if invalid_first?

            # 2行目元号のみ正しい場合も不正と見なす
            !invalid_second?
          end
        end
      end
    end
  end
end
