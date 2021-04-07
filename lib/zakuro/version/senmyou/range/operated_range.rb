# frozen_string_literal: true

require_relative './full_range'
require_relative './operated_solar_terms'
require_relative '../../../operation/operation'
require_relative '../monthly/operated_month'

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
      # @return [OperatedSolarTerms] 運用時二十四節気
      attr_reader :operated_solar_terms
      #
      # 初期化
      #
      # @param [FullRange] full_range 完全範囲
      #
      def initialize(full_range: FullRange.new)
        @full_range = full_range
        @operated_solar_terms = OperatedSolarTerms.new(full_range: @full_range)
        @operated_solar_terms.create
      end

      #
      # 運用結果範囲を取得する
      #
      # @return [Array<Year>] 運用結果範囲
      #
      def get
        rewrite
      end

      #
      # 運用結果に書き換える
      #
      # @return [Array<Year>] 運用結果範囲
      #
      def rewrite
        operated_years = []
        years = @full_range.get

        years.each do |year|
          operated_year = rewrite_year(year: year)
          operated_years.push(operated_year)
        end

        operated_years
      end

      #
      # 年を書き換える
      #
      # @param [Year] year 年
      #
      # @return [Year] 年
      #
      def rewrite_year(year:)
        result = Year.new(multi_gengou: year.multi_gengou, new_year_date: year.new_year_date)
        year.months.each do |month|
          operated_month = month
          history = Operation.specify_history(western_date: month.western_date)
          operated_month = rewrite_month(month: month, history: history) unless history.invalid?
          result.push(month: operated_month)
        end

        result.commit

        result
      end

      #
      # 月を運用結果に書き換える
      #
      # @param [Month] month 月
      # @param [Operation::MonthHistory] history 変更履歴
      #
      # @return [Month] 月（運用結果）
      #
      def rewrite_month(month:, history:)
        return month unless month.western_date == history.western_date

        operated_month = OperatedMonth.new(
          month_label: month.month_label, first_day: month.first_day,
          solar_terms: month.solar_terms, history: history,
          operated_solar_terms: @operated_solar_terms
        )

        operated_month.rewrite

        Month.new(
          month_label: operated_month.month_label, first_day: operated_month.first_day,
          solar_terms: operated_month.solar_terms
        )
      end
    end
  end
end
