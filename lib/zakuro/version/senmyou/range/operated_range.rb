# frozen_string_literal: true

require_relative './full_range'
require_relative '../../../operation/operation'
require_relative '../monthly/month'

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
        @month_histroies = Operation.month_histories
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
          operated_month = month
          history = specify_history(western_date: month.western_date)
          operated_month = rewrite_month(month: month, history: history) unless history.invalid?
          result.push(month: operated_month)
        end

        result.commit

        result
      end

      def specify_history(western_date:)
        @month_histroies.each do |history|
          return history if western_date == history.western_date
        end

        Operation::MonthHistory.new
      end

      def rewrite_month(month:, history:)
        return month unless month.western_date == history.western_date

        # TODO: リファクタリング
        hash = {}
        month.instance_variables.each do |var|
          key = var.to_s.delete('@')
          hash[key.intern] = month.instance_variable_get(var)
        end

        # TODO: 書き換え処理
        diffs_month(hash: hash, history: history)
        Zakuro::Senmyou::Month.new(**hash)
      end

      def diffs_month(hash:, history:)
        diff = history.diffs.month
        number = diff.number
        leaped = diff.leaped

        return if number.invalid?

        hash[:number] = number.actual
        hash[:leaped] = leaped.actual
      end
    end
  end
end
