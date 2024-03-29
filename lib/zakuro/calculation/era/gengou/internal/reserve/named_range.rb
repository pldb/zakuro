# frozen_string_literal: true

require_relative './abstract_range'
require_relative './named_list'

# :nodoc:
module Zakuro
  # :nodoc:
  module Calculation
    # :nodoc:
    module Gengou
      # :nodoc:
      module Reserve
        #
        # NamedRange 予約済み計算範囲（元号名）
        #
        class NamedRange < AbstractRange
          # @return [String] 不正元号名
          INVALID_NAME = Japan::Calendar::EMPTY

          #
          # 初期化
          #
          # @param [String] start_name 開始元号名
          # @param [String] last_name 終了元号名
          # @param [True, False] operated 運用値設定
          # @param [True, False] restored 運用値から計算値に戻すか
          #
          def initialize(start_name: INVALID_NAME, last_name: INVALID_NAME,
                         operated: false, restored: false)
            @first_list = NamedList.new(
              first: true, start_name: start_name, last_name: last_name, operated: operated,
              restored: restored
            )
            @second_list = NamedList.new(
              first: false, start_name: start_name, last_name: last_name, operated: operated,
              restored: restored
            )

            start_date = western_start_date
            last_date = western_last_date

            super(
              start_date: start_date, last_date: last_date, operated: operated, restored: restored
            )
          end

          #
          # 最新の元号から西暦終了日を取得する
          #
          # @return [Western::Calendar] 西暦終了日
          #
          def western_last_date
            list = newest_list

            return Western::Calendar.new if list.invalid?

            list.western_last_date
          end

          #
          # 最新の元号を取得する
          #
          # @return [List] 最新の元号
          #
          def newest_list
            return first_list if invalid_list?

            first_western_date = first_list.western_last_date
            second_western_date = second_list.western_last_date

            return second_list if first_western_date.invalid?

            return first_list if second_western_date.invalid?

            return first_list if first_western_date > second_western_date

            second_list
          end
        end
      end
    end
  end
end
