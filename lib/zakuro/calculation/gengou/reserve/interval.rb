# frozen_string_literal: true

require_relative '../../../era/western/calendar'

require_relative './list'

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
          # @return [List] 1行目元号
          attr_reader :first_gengou
          # @return [List] 2行目元号
          attr_reader :second_gengou

          #
          # 初期化
          #
          # @param [List<Base::CountableGengou>] first_gengou_list 1行目元号
          # @param [List<Base::CountableGengou>] second_gengou_list 2行目元号
          #
          def initialize(start_date: Western::Calendar.new, end_date: Western::Calendar.new)
            @first_gengou = List.new(first: true, start_date: start_date, end_date: end_date)
            @second_gengou = List.new(first: false, start_date: start_date, end_date: end_date)
          end

          #
          # 不正か
          #
          # @return [True] 不正
          # @return [False] 不正なし
          #
          def invalid?
            @first_gengou.invalid?
          end

          #
          # 開始西暦年を取得する
          #
          # @return [Integer] 開始西暦年
          #
          def western_start_year
            first_start_year = @first_gengou.western_start_year
            second_start_year = @second_gengou.western_start_year

            return first_start_year if @first_gengou.invalid?

            return first_start_year if @second_gengou.invalid?

            return first_start_year if first_start_year < second_start_year

            second_start_year
          end

          #
          # 終了西暦年を取得する
          #
          # @return [Integer] 終了西暦年
          #
          def western_end_year
            first_end_year = @first_gengou.western_end_year
            second_end_year = @second_gengou.western_end_year

            return first_end_year if @first_gengou.invalid?

            return first_end_year if @second_gengou.invalid?

            return first_end_year if first_end_year > second_end_year

            second_end_year
          end
        end
      end
    end
  end
end
