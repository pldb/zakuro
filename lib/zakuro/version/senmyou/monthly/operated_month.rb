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
        rewrite_first_day
      end

      #
      # 月ごとの差分で書き換える
      #
      def rewrite_month
        diff = history.diffs.month

        @month_label = MonthLabel.new(
          number: rewrite_number(diff: diff.number),
          is_many_days: rewrite_many_days(diff: diff.days),
          leaped: rewrite_leaped(diff: diff.leaped)
        )
      end

      #
      # 月ごとの差分（月）で書き換える
      #
      # @param [Operation::Number] diff 差分
      #
      # @return [Integer] 月
      #
      def rewrite_number(diff:)
        return month_label.number if diff.invalid?

        diff.actual
      end

      #
      # 月ごとの差分（月の大小）で書き換える
      #
      # @param [Operation::Days] diff 差分
      #
      # @return [Integer] 月の大小
      #
      def rewrite_many_days(diff:)
        return month_label.is_many_days if diff.invalid?

        diff.many_days_actual?
      end

      #
      # 月ごとの差分（閏有無）で書き換える
      #
      # @param [Operation::Days] diff 差分
      #
      # @return [True] 閏あり
      # @return [False] 閏なし
      #
      def rewrite_leaped(diff:)
        return month_label.leaped if diff.invalid?

        diff.actual
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

      #
      # 月初日ごとの差分で書き換える
      #
      def rewrite_first_day
        diffs = @history.diffs
        return if diffs.invalid_days?

        days = diffs.days

        @first_day = FirstDay.new(
          western_date: rewrite_western_date(days: days),
          remainder: rewrite_remainder(days: days)
        )
      end

      #
      # 月初日の大余小余を日差分で書き換える
      #
      # @param [Integer] days 日差分
      #
      # @return [Remainder] 月初日の大余小余
      #
      def rewrite_remainder(days:)
        remainder = @first_day.remainder.clone
        remainder.add!(Remainder.new(day: days, minute: 0, second: 0))

        remainder
      end

      #
      # 月初日の西暦日を日差分で書き換える
      #
      # @param [Integer] days 日差分
      #
      # @return [Western::Calendar] 月初日の西暦日
      #
      def rewrite_western_date(days:)
        western_date = @first_day.western_date.clone
        western_date += days

        western_date
      end
    end
  end
end
