# frozen_string_literal: true

require_relative './abstract_list'

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
        class DatedList < AbstractList
          #
          # 初期化
          #
          # @param [True, False] first true:1行目元号, false:2行目元号
          # @param [Western::Calendar] start_date 開始日
          # @param [Western::Calendar] last_date 終了日
          #
          def initialize(first: true, start_date: Western::Calendar.new,
                         last_date: Western::Calendar)
            super(first: first, start_date: start_date, last_date: last_date)
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
          # 元号を取得する
          #
          # @param [Western::Calendar] start_date 開始日
          # @param [Western::Calendar] last_date 終了日
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
