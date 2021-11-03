# frozen_string_literal: true

require_relative '../../../era/japan/gengou'
require_relative '../../../era/western/calendar'

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
          # @return [Integer] 最大試行数
          MAX_SEARCH_COUNT = 10_000
          # @return [Integer] 最大月日数
          MAX_MONTH_DAYS = 30

          # @return [Symbol] メソッド名
          attr_reader :method_name
          # @return [Western::Calendar] 開始日
          attr_reader :start_date
          # @return [Western::Calendar] 終了日
          attr_reader :end_date

          #
          # 初期化
          #
          # @param [Symbol] method_name メソッド名（first_line: 1行目元号, second_line: 2行目元号）
          # @param [Western::Calendar] start_date 開始日
          # @param [Western::Calendar] end_date 終了日
          #
          def initialize(method_name:, start_date: Western::Calendar.new,
                         end_date: Western::Calendar)
            @method_name = method_name
            @start_date = start_date
            @end_date = end_date
          end

          #
          # 予約元号一覧を取得する
          #
          # @return [Array<Japan::Gengou>] 予約元号一覧
          #
          def get
            result = internal

            return result if result.size.zero?

            prev_gengou(list: result)

            next_gengou(list: result)

            result
          end

          #
          # 開始日・終了日に対応する予約元号一覧を取得する
          #
          # @return [Array<Japan::Gengou>] 予約元号一覧
          #
          def internal
            current_gengou = line(date: start_date)
            result = []

            return result if current_gengou.invalid?

            result.push(current_gengou)
            (0..MAX_SEARCH_COUNT).each do |_index|
              break if current_gengou.end_date > end_date

              current_gengou = line(date: current_gengou.end_date + 1)
              result.push(current_gengou)
            end

            result
          end

          #
          # 前の元号を設定する
          #
          # @note 開始日の30日前に前の元号がある場合は、前の元号を設定する
          #
          # @param [Array<Japan::Gengou>] list 元号一覧
          #
          def prev_gengou(list:)
            return unless list

            return if list.size.zero?

            first_gendou_date = list[0].both_start_date.western

            return if first_gendou_date < start_date - MAX_MONTH_DAYS

            gengou = line(date: first_gendou_date - 1)

            return if gengou.invalid?

            list.unshift(gengou)
          end

          #
          # 次の元号を設定する
          #
          # @note 開始日の30日後に次の元号がある場合は、次の元号を設定する
          #
          # @param [Array<Japan::Gengou>] list 元号一覧
          #
          def next_gengou(list:)
            return unless list

            return if list.size.zero?

            last_gendou_date = list[0].end_date

            return if end_date + MAX_MONTH_DAYS < last_gendou_date

            gengou = line(date: last_gendou_date + 1)

            return if gengou.invalid?

            list.push(gengou)
          end

          #
          # 元号
          #
          # @param [Western::Calendar] date 日付
          #
          # @return [Japan::Gengou] 元号
          #
          def line(date:)
            List.send(method_name, { date: date })
          end

          #
          # 1行目元号
          #
          # @param [Western::Calendar] date 日付
          #
          # @return [Japan::Gengou] 1行目元号
          #
          def self.first_line(date:)
            Zakuro::Japan::GengouResource.first_line(date: date)
          end

          #
          # 2行目元号
          #
          # @param [Western::Calendar] date 日付
          #
          # @return [Japan::Gengou] 2行目元号
          #
          def self.second_line(date:)
            Zakuro::Japan::GengouResource.second_line(date: date)
          end
        end
      end
    end
  end
end
