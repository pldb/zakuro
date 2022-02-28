# frozen_string_literal: true

require_relative '../../../../../era/western/calendar'

require_relative './list'

# :nodoc:
module Zakuro
  # :nodoc:
  module Calculation
    # :nodoc:
    module Gengou
      # :nodoc:
      module Reserve
        #
        # Range 予約済み計算範囲
        #
        class Range
          # @return [List] 1行目元号
          attr_reader :first_list
          # @return [List] 2行目元号
          attr_reader :second_list

          #
          # 初期化
          #
          # @param [Western::Calendar] start_date 西暦開始日
          # @param [Western::Calendar] last_date 西暦終了日
          #
          def initialize(start_date: Western::Calendar.new, last_date: Western::Calendar.new)
            last_date = start_date.clone if last_date.invalid?

            @first_list = List.new(first: true, start_date: start_date, last_date: last_date)
            @second_list = List.new(first: false, start_date: start_date, last_date: last_date)

            renew(last_date: last_date)
          end

          #
          # 再初期化
          #   含まれる最初の元号が別の行にまたがっている場合に開始日を前倒しする
          #
          # @param [Western::Calendar] last_date 西暦終了日
          #
          def renew(last_date: Western::Calendar.new)
            native_start_date = Western::Calendar.new
            [@first_list, @second_list].each do |list|
              next unless list.change_start_date?

              if native_start_date.invalid?
                native_start_date = list.native_start_date.clone
                next
              end

              next if native_start_date <= list.native_start_date

              native_start_date = list.native_start_date.clone
            end

            return if native_start_date.invalid?

            @first_list = List.new(first: true,
                                   start_date: native_start_date, last_date: last_date)
            @second_list = List.new(first: false,
                                    start_date: native_start_date, last_date: last_date)
          end

          #
          # 不正か
          #
          # @return [True] 不正
          # @return [False] 不正なし
          #
          def invalid?
            @first_list.invalid?
          end

          #
          # 1行目元号を取得する
          #
          # @param [Western::Calendar] western_date 西暦日
          #
          # @return [Gengou::Counter] 加算元号
          #
          def match_first_list(western_date: Western::Calendar.new)
            @first_list.get(western_date: western_date)
          end

          #
          # 2行目元号を取得する
          #
          # @param [Western::Calendar] western_date 西暦日
          #
          # @return [Gengou::Counter] 加算元号
          #
          def match_second_list(western_date: Western::Calendar.new)
            @second_list.get(western_date: western_date)
          end

          #
          # 範囲内元号（1行目元号）を取得する
          #
          # @param [Western::Calendar] start_date 西暦開始日
          # @param [Western::Calendar] last_date 西暦終了日
          #
          # @return [Array<Gengou::Counter>] 範囲内元号（1行目元号）
          #
          def collect_first(start_date: Western::Calendar.new,
                            last_date: Western::Calendar.new)
            @first_list.collect(start_date: start_date, last_date: last_date)
          end

          #
          # 範囲内元号（2行目元号）を取得する
          #
          # @param [Western::Calendar] start_date 西暦開始日
          # @param [Western::Calendar] last_date 西暦終了日
          #
          # @return [Array<Gengou::Counter>] 範囲内元号（2行目元号）
          #
          def collect_second(start_date: Western::Calendar.new,
                             last_date: Western::Calendar.new)
            @second_list.collect(start_date: start_date, last_date: last_date)
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
            first_start_year = @first_list.western_start_year
            second_start_year = @second_list.western_start_year

            return first_start_year if @first_list.invalid?

            return first_start_year if @second_list.invalid?

            return first_start_year if first_start_year < second_start_year

            second_start_year
          end

          #
          # 終了西暦年を取得する
          #
          # @return [Integer] 終了西暦年
          #
          def western_last_year
            first_last_year = @first_list.western_last_year
            second_last_year = @second_list.western_last_year

            return first_last_year if @first_list.invalid?

            return first_last_year if @second_list.invalid?

            return first_last_year if first_last_year > second_last_year

            second_last_year
          end

          private

          #
          # 最古の元号を取得する
          #
          # @return [Japan::Gengou] 最古の元号
          #
          def oldest_gengou
            return @first_list if @first_list.invalid?

            return @first_list if @second_list.invalid?

            first_western_date = @first_list.western_start_date
            second_western_date = @second_list.western_start_date

            return @first_list if first_western_date.invalid?

            return @first_list if second_western_date.invalid?

            return @first_list if first_western_date < second_western_date

            @second_list
          end
        end
      end
    end
  end
end
