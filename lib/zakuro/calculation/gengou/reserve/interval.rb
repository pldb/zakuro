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
          # @param [Western::Calendar] start_date 西暦開始日
          # @param [Western::Calendar] end_date 西暦終了日
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
          # 1行目元号を取得する
          #
          # @param [Western::Calendar] western_date 西暦日
          #
          # @return [Gengou::Counter] 加算元号
          #
          def match_first_gengou(western_date: Western::Calendar.new)
            @first_gengou.get(western_date: western_date)
          end

          #
          # 2行目元号を取得する
          #
          # @param [Western::Calendar] western_date 西暦日
          #
          # @return [Gengou::Counter] 加算元号
          #
          def match_second_gengou(western_date: Western::Calendar.new)
            @second_gengou.get(western_date: western_date)
          end

          #
          # 一つ先の1行目元号を取得する
          #
          # @param [Western::Calendar] western_date 西暦日
          #
          # @return [Gengou::Counter] 加算元号
          #
          def proceed_first_gengou(western_date: Western::Calendar.new)
            @first_gengou.proceed(western_date: western_date)
          end

          #
          # 一つ先の2行目元号を取得する
          #
          # @param [Western::Calendar] western_date 西暦日
          #
          # @return [Gengou::Counter] 加算元号
          #
          def proceed_second_gengou(western_date: Western::Calendar.new)
            @second_gengou.proceed(western_date: western_date)
          end

          #
          # 最古の元号から和暦開始日を取得する
          #
          # @return [Japan::Calendar] 和暦開始日
          #
          def japan_start_date
            gengou = oldest_gengou

            return Japan::Calendar.new if gengou.invalid?

            gengou.japan_start_date
          end

          #
          # 最古の元号から西暦開始日を取得する
          #
          # @return [Western::Calendar] 西暦開始日
          #
          def western_start_date
            gengou = oldest_gengou

            return Western::Calendar.new if gengou.invalid?

            gengou.western_start_date
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

          private

          #
          # 最古の元号を取得する
          #
          # @return [Japan::Gengou] 最古の元号
          #
          def oldest_gengou
            return @first_gengou if @first_gengou.invalid?

            return @first_gengou if @second_gengou.invalid?

            first_western_date = @first_gengou.western_start_date
            second_western_date = @second_gengou.western_start_date

            return @first_gengou if first_western_date.invalid?

            return @first_gengou if second_western_date.invalid?

            return @first_gengou if first_western_date < second_western_date

            @second_gengou
          end
        end
      end
    end
  end
end
