# frozen_string_literal: true

require_relative '../../../../../era/western/calendar'

require_relative './dated_list'

# :nodoc:
module Zakuro
  # :nodoc:
  module Calculation
    # :nodoc:
    module Gengou
      # :nodoc:
      module Reserve
        #
        # AbstractRange 予約済み計算範囲
        #
        class AbstractRange
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

            @first_list = DatedList.new(first: true, start_date: start_date, last_date: last_date)
            @second_list = DatedList.new(first: false, start_date: start_date, last_date: last_date)

            renew(last_date: last_date)
          end

          #
          # 再初期化
          #   含まれる最初の元号が別の行にまたがっている場合に開始日を前倒しする
          #
          # @param [Western::Calendar] last_date 西暦終了日
          #
          def renew(last_date: Western::Calendar.new)
            start_date = native_start_date

            return if start_date.invalid?

            @first_list = DatedList.new(first: true, start_date: start_date,
                                        last_date: last_date)
            @second_list = DatedList.new(first: false, start_date: start_date,
                                         last_date: last_date)
          end

          #
          # 不正か
          #
          # @return [True] 不正
          # @return [False] 不正なし
          #
          def invalid?
            first_list.invalid?
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
            first_list.collect(start_date: start_date, last_date: last_date)
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
            second_list.collect(start_date: start_date, last_date: last_date)
          end

          #
          # 最古の元号から和暦開始日を取得する
          #
          # @return [Japan::Calendar] 和暦開始日
          #
          def japan_start_date
            list = oldest_list

            return Japan::Calendar.new if list.invalid?

            list.japan_start_date
          end

          #
          # 最古の元号から西暦開始日を取得する
          #
          # @return [Western::Calendar] 西暦開始日
          #
          def western_start_date
            list = oldest_list

            return Western::Calendar.new if list.invalid?

            list.western_start_date
          end

          #
          # 開始西暦年を取得する
          #
          # @return [Integer] 開始西暦年
          #
          def western_start_year
            first_start_year = first_list.western_start_year
            second_start_year = second_list.western_start_year

            return first_start_year if first_list.invalid?

            return first_start_year if second_list.invalid?

            return first_start_year if first_start_year < second_start_year

            second_start_year
          end

          #
          # 終了西暦年を取得する
          #
          # @return [Integer] 終了西暦年
          #
          def western_last_year
            first_last_year = first_list.western_last_year
            second_last_year = second_list.western_last_year

            return first_last_year if first_list.invalid?

            return first_last_year if second_list.invalid?

            return first_last_year if first_last_year > second_last_year

            second_last_year
          end

          private

          #
          # 設定された元号の開始日を取得する
          #
          # @return [Western::Calendar] 設定された元号の開始日
          #
          def native_start_date
            result = Western::Calendar.new
            [first_list, second_list].each do |list|
              next unless list.change_start_date?

              if result.invalid?
                result = list.native_start_date.clone
                next
              end

              next if result <= list.native_start_date

              result = list.native_start_date.clone
            end

            result
          end

          #
          # 最古の元号を取得する
          #
          # @return [List] 最古の元号
          #
          def oldest_list
            return first_list if invalid_list?

            first_western_date = first_list.western_start_date
            second_western_date = second_list.western_start_date

            return first_list if first_western_date.invalid?

            return first_list if second_western_date.invalid?

            return first_list if first_western_date < second_western_date

            second_list
          end

          #
          # 元号リストが不正か
          #
          # @return [True] 不正
          # @return [False] 不正なし
          #
          def invalid_list?
            return true if first_list.invalid?

            return true if second_list.invalid?

            false
          end
        end
      end
    end
  end
end
