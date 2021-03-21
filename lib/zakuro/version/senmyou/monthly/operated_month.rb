# frozen_string_literal: true

require_relative './month'
require_relative '../../../operation/operation'

# :nodoc:
module Zakuro
  # :nodoc:
  module Senmyou
    #
    # OperatedMonth 月情報（運用）
    #
    class OperatedMonth < Month
      # @return [Operation::MonthHistory] 変更履歴（月）
      attr_reader :history
      # @return [OperatedSolarTerms] 運用時二十四節気
      attr_reader :operated_solar_terms

      #
      # 初期化
      #
      # @param [MonthLabel] month_label 月表示名
      # @param [FirstDay] first_day 月初日（朔日）
      # @param [Array<SolarTerm>] solar_terms 二十四節気
      # @param [Operation::MonthHistory] history 変更履歴（月）
      #
      def initialize(operated_solar_terms:, month_label: MonthLabel.new, first_day: FirstDay.new, solar_terms: [],
                     history: Operation::MonthHistory.new)
        super(month_label: month_label, first_day: first_day, solar_terms: solar_terms)
        @history = history
        @operated_solar_terms = operated_solar_terms
      end

      #
      # 書き換える
      #
      def rewrite
        rewrite_month
        rewrite_solar_terms
        # TODO: 月、二十四節気以外の書き換え
      end

      #
      # 月ごとの差分で書き換える
      #
      def rewrite_month
        diff = history.diffs.month
        number = diff.number
        leaped = diff.leaped

        return if number.invalid?

        @month_label = MonthLabel.new(
          number: number.actual,
          is_many_days: month_label.is_many_days,
          leaped: leaped.actual
        )
      end

      #
      # 二十四節気ごとの差分で書き換える
      #
      def rewrite_solar_terms
        # TODO: リファクタリング
        operated_solar_terms = []
        matched, operated_solar_term = @operated_solar_terms.get(
          western_date: @first_day.western_date
        )

        return unless matched

        used = false
        @solar_terms.each do |solar_term|
          if operated_solar_term.index == solar_term.index
            used = true
            next
          end

          operated_solar_terms.push(solar_term)
        end

        operated_solar_terms.push(operated_solar_term) unless used

        @solar_terms = operated_solar_terms
      end
    end
  end
end
