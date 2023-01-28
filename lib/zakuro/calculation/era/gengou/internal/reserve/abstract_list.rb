# frozen_string_literal: true

require_relative '../../../../../era/japan/gengou/resource'
require_relative '../../../../../era/japan/gengou'
require_relative '../../../../../era/japan/calendar'
require_relative '../../../../../era/western/calendar'

require_relative '../counter'

require_relative './empty_link'

# :nodoc:
module Zakuro
  # :nodoc:
  module Calculation
    # :nodoc:
    module Gengou
      # :nodoc:
      module Reserve
        # AbstractList
        #
        # 抽象予約元号一覧
        #
        class AbstractList
          # @return [Integer] 不正年
          INVALID_YEAR = -1
          # @return [Integer] 最大月日数
          MAX_MONTH_DAYS = 30

          # @return [Symbol] 行番号
          attr_reader :index
          # @return [Western::Calendar] 開始日
          attr_reader :start_date
          # @return [Western::Calendar] 終了日
          attr_reader :last_date
          # @return [True] 運用値あり
          # @return [True] 運用値なし
          attr_reader :operated
          # @return [Array<Japan::Alignment::LinearGengou>] 予約元号一覧
          attr_reader :list

          #
          # 初期化
          #
          # @param [Integer] index n行目元号
          # @param [Western::Calendar] start_date 開始日
          # @param [Western::Calendar] last_date 終了日
          # @param [True, False] operated 運用値設定
          #
          def initialize(index:, start_date: Western::Calendar.new,
                         last_date: Western::Calendar, operated: false)
            @index = index
            @start_date = start_date.clone
            @last_date = last_date.clone
            @operated = operated
            @list = []

            update
          end

          #
          # 元号を取得する
          #
          # @param [Western::Calendar] western_date 西暦日
          #
          # @return [Gengou::Counter] 加算元号
          #
          def get(western_date: Western::Calendar.new)
            list.each do |linear_gengou|
              next if linear_gengou.out?(start_date: western_date, last_date: western_date)

              Gengou::Counter.new(gengou: linear_gengou.gengou).clone
            end

            Gengou::Counter.new
          end

          #
          # 範囲内元号を取得する
          #
          # @param [Western::Calendar] start_date 西暦開始日
          # @param [Western::Calendar] last_date 西暦終了日
          #
          # @return [Array<Gengou::Counter>] 範囲内元号
          #
          def collect(start_date: Western::Calendar.new, last_date: Western::Calendar.new)
            result = []

            list.each do |linear_gengou|
              next if linear_gengou.out?(start_date: start_date, last_date: last_date)

              result.push(
                Gengou::Counter.new(
                  gengou: linear_gengou.gengou.clone,
                  start_date: linear_gengou.start_date.clone,
                  last_date: linear_gengou.last_date.clone
                )
              )
            end

            EmptyLink.fill(counters: result, start_date: start_date, last_date: last_date)

            result
          end

          #
          # 和暦開始日を取得する
          #
          # @return [Japan::Calendar] 和暦開始日
          #
          def japan_start_date
            return Japan::Calendar.new if invalid?

            list[0].gengou.both_start_date.japan.clone
          end

          #
          # 西暦開始日を取得する
          #
          # @return [Western::Calendar] 西暦開始日
          #
          def western_start_date
            return Western::Calendar.new if invalid?

            list[0].gengou.both_start_date.western.clone
          end

          #
          # 西暦終了日を取得する
          #
          # @return [Western::Calendar] 西暦開始日
          #
          def western_last_date
            return Western::Calendar.new if invalid?

            list[-1].gengou.last_date.clone
          end

          #
          # 西暦開始年を取得する
          #
          # @return [Integer] 西暦開始年
          #
          def western_start_year
            return INVALID_YEAR if invalid?

            list[0].gengou.both_start_year.western.clone
          end

          #
          # 西暦終了年を取得する
          #
          # @return [Integer] 西暦終了年
          #
          def western_last_year
            return INVALID_YEAR if invalid?

            return INVALID_YEAR if list.size.zero?

            list[-1].gengou.last_year
          end

          #
          # 不正か
          #
          # @return [True] 不正
          # @return [False] 不正なし
          #
          def invalid?
            return true unless list

            return true if list.size.zero?

            false
          end

          #
          # 設定された元号の開始日を取得する
          #
          # @return [Western::Calendar]設定された元号の開始日
          #
          def native_start_date
            return Western::Calendar.new if list.size.zero?

            list[0].native_start_date
          end

          #
          # 開始日が設定された開始日と異なるか（行が変更されているか）
          #
          # @return [True] 異なる
          # @return [False] 同一
          #
          def change_start_date?
            return false if list.size.zero?

            list[0].change_start_date?
          end

          private

          #
          # 予約元号一覧を更新する
          #
          def update
            # override
          end

          #
          # 元号を取得する
          #
          # @param [Western::Calendar] start_date 開始日
          # @param [Western::Calendar] last_date 終了日
          #
          # @return [Array<Japan::Alignment::LinearGengou>] 元号
          #
          def line(start_date:, last_date:)
            Japan::Gengou.line(
              line: index, start_date: start_date, last_date: last_date, operated: operated
            )
          end

          #
          # 行番号に変換する
          #
          # @param [True, False] first 1行目/2行目
          #
          # @return [<Integer] 行番号
          #
          def parse_index(first: true)
            first ? Japan::Gengou::FIRST_LINE : Japan::Gengou::SECOND_LINE
          end
        end
      end
    end
  end
end
