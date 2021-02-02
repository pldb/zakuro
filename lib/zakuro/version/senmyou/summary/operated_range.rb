# frozen_string_literal: true

require_relative './full_range'
require_relative '../../../operation/operation'

# :nodoc:
module Zakuro
  # :nodoc:
  module Senmyou
    #
    # OperatedRange 運用結果範囲
    #
    # 何らかの理由により、計算された暦とは異なる運用結果である場合、その結果に合わせて計算結果を上書きする
    class OperatedRange
      # @return [FullRange] 完全範囲
      attr_reader :full_range

      #
      # 初期化
      #
      # @param [FullRange] full_range 完全範囲
      #
      def initialize(full_range: FullRange.new)
        @full_range = full_range
        @operation_months = Operation.months
      end

      #
      # 運用結果範囲を取得する
      #
      # @return [Array<Year>] 運用結果範囲
      #
      def get
        # TODO: 運用結果範囲を返すこと
        rewrite
      end

      def rewrite
        years = []
        @full_range.each do |year|
          operated_year = rewrite_year(year: year)
          years.push(operated_year)
        end

        years
      end

      def rewrite_year(year:)
        result = Year.new(multi_gengou: year.multi_gengou, new_year_date: year.new_year_date)
        year.months.each do |month|
          @operation_months.each do |operation|
            operated_month = rewrite_month(month: month, operation: operation)
            result.push(month: operated_month)
          end
        end

        result.commit

        result
      end

      def rewrite_month(month:, operation:)
        # TODO: 同じ西暦日の場合は書き換える
        # TODO: monthの側に月の初日（朔日）が存在しない
      end
    end
  end
end
