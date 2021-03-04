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
      attr_reader :history

      #
      # 初期化
      #
      # @param [MonthLabel] month_label 月表示名
      # @param [FirstDay] first_day 月初日（朔日）
      # @param [Array<SolarTerm>] solar_terms 二十四節気
      # @param [Operation::MonthHistory] history 変更履歴（月）
      #
      def initialize(month_label: MonthLabel.new, first_day: FirstDay.new, solar_terms: [],
                     history: Operation::MonthHistory.new)
        super(month_label: month_label, first_day: first_day, solar_terms: solar_terms)
        @history = history
      end

      def rewrite
        month
        # TODO: 月以外の書き換え
      end

      def month
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
    end
  end
end
