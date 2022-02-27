# frozen_string_literal: true

require_relative '../../../../../era/japan/gengou/resource'
require_relative '../../../../../era/japan/gengou'
require_relative '../../../../../era/japan/calendar'
require_relative '../../../../../era/western/calendar'

require_relative '../counter'

# :nodoc:
module Zakuro
  # :nodoc:
  module Calculation
    # :nodoc:
    module Gengou
      # :nodoc:
      module Reserve
        # List
        #
        # 予約元号一覧
        #
        class List
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
          # @return [Array<Japan::Alignment::LinearGengou>] 予約元号一覧
          attr_reader :list

          #
          # 初期化
          #
          # @param [True, False] first true:1行目元号, false:2行目元号
          # @param [Western::Calendar] start_date 開始日
          # @param [Western::Calendar] last_date 終了日
          #
          def initialize(first: true, start_date: Western::Calendar.new,
                         last_date: Western::Calendar)
            @index = first ? Japan::Gengou::FIRST_LINE : Japan::Gengou::SECOND_LINE
            @start_date = start_date.clone
            @last_date = last_date.invalid? ? start_date.clone : last_date.clone
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
            @list.each do |linear_gengou|
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

            @list.each do |linear_gengou|
              next if linear_gengou.out?(start_date: start_date, last_date: last_date)

              result.push(
                Gengou::Counter.new(
                  gengou: linear_gengou.gengou.clone,
                  start_date: linear_gengou.start_date.clone,
                  last_date: linear_gengou.last_date.clone
                )
              )
            end

            # TODO: refactor
            if result.size.zero?
              result.push(
                Gengou::Counter.new(
                  gengou: Japan::Resource::Gengou.new(
                    both_start_date: Japan::Resource::Both::Date.new(
                      western: start_date.clone
                    ),
                    last_date: last_date.clone
                  )
                )
              )
              return result
            end

            # FIXME: 有効元号の前後しか見ていない
            if start_date < result[0].start_date
              result.unshift(
                Gengou::Counter.new(
                  gengou: Japan::Resource::Gengou.new,
                  start_date: start_date.clone,
                  last_date: result[0].start_date.clone - 1
                )
              )
            end

            if last_date > result[-1].last_date
              result.push(
                Gengou::Counter.new(
                  gengou: Japan::Resource::Gengou.new,
                  start_date: result[0].last_date.clone + 1,
                  last_date: last_date.clone
                )
              )
            end

            result
          end

          #
          # 和暦開始日を取得する
          #
          # @return [Japan::Calendar] 和暦開始日
          #
          def japan_start_date
            return Japan::Calendar.new if invalid?

            @list[0].gengou.both_start_date.japan.clone
          end

          #
          # 西暦開始日を取得する
          #
          # @return [Western::Calendar] 西暦開始日
          #
          def western_start_date
            return Western::Calendar.new if invalid?

            @list[0].gengou.both_start_date.western.clone
          end

          #
          # 西暦開始年を取得する
          #
          # @return [Integer] 西暦開始年
          #
          def western_start_year
            return INVALID_YEAR if invalid?

            @list[0].gengou.both_start_year.western.clone
          end

          #
          # 西暦終了年を取得する
          #
          # @return [Integer] 西暦終了年
          #
          def western_last_year
            return INVALID_YEAR if invalid?

            return INVALID_YEAR if @list.size.zero?

            @list[-1].gengou.last_year
          end

          #
          # 不正か
          #
          # @return [True] 不正
          # @return [False] 不正なし
          #
          def invalid?
            return true unless @list

            return true if @list.size.zero?

            false
          end

          #
          # 設定された元号の開始日を取得する
          #
          # @return [Western::Calendar]設定された元号の開始日
          #
          def native_start_date
            return Western::Calendar.new if @list.size.zero?

            @list[0].native_start_date
          end

          #
          # 開始日が設定された開始日と異なるか（行が変更されているか）
          #
          # @return [True] 異なる
          # @return [False] 同一
          #
          def change_start_date?
            return false if @list.size.zero?

            @list[0].change_start_date?
          end

          private

          #
          # 予約元号一覧を更新する
          #
          def update
            # 開始日の30日前に前の元号がある場合は、前の元号を設定する
            start_date = @start_date.clone - (MAX_MONTH_DAYS + 1)
            # 開始日の30日後に次の元号がある場合は、次の元号を設定する
            last_date = @last_date.clone + (MAX_MONTH_DAYS + 1)

            @list |= line(start_date: start_date, last_date: last_date)
          end

          #
          # 元号
          #
          # @param [Western::Calendar] date 日付
          #
          # @return [Array<Japan::Alignment::LinearGengou>] 元号
          #
          def line(start_date:, last_date:)
            Japan::Gengou.line(line: @index, start_date: start_date, last_date: last_date)
          end
        end
      end
    end
  end
end
