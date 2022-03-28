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
            @index = parse_index(first: first)
            @start_date = start_date.clone
            @last_date = last_date.invalid? ? start_date.clone : last_date.clone
            super(index: @index, start_date: start_date, last_date: last_date)
          end
        end
      end
    end
  end
end
