# frozen_string_literal: true

require_relative './first_day'
require_relative './month_label'

# TODO: moduleでMonthly とする（全暦むけに共通化したあと）

# :nodoc:
module Zakuro
  # :nodoc:
  module Senmyou
    #
    # Month 月情報
    #
    class Month
      # @return [MonthLabel] 月表示名
      attr_reader :month_label
      # @return [FirstDay] 月初日（朔日）
      attr_reader :first_day
      # @return [Array<SolarTerm>] 二十四節気
      attr_reader :solar_terms

      #
      # 初期化
      #
      # @param [MonthLabel] month_label 月表示名
      # @param [FirstDay] first_day 月初日（朔日）
      # @param [Array<SolarTerm>] solar_terms 二十四節気
      #
      def initialize(month_label: MonthLabel.new, first_day: FirstDay.new, solar_terms: [])
        @month_label = month_label
        @first_day = first_day
        @solar_terms = solar_terms
      end

      #
      # 中気なしは閏月とする
      #
      def eval_leaped
        leaped = even_term.invalid?

        @month_label = MonthLabel.new(number: number, is_many_days: many_days?, leaped: leaped)
      end

      #
      # 月初日の西暦日を返す
      #
      # @return [Western::Calendar] 西暦日
      #
      def western_date
        @first_day.western_date
      end

      #
      # 月初日の大余小余を返す
      #
      # @return [Remainder] 大余小余
      #
      def remainder
        @first_day.remainder
      end

      #
      # 月の大小を返す
      #
      # @return [True] 大の月（30日）
      # @return [False] 小の月（29日）
      #
      def many_days?
        @month_label.is_many_days
      end

      #
      # 月の日数を返す
      #
      # @return [Integer] 日数
      #
      def days
        @month_label.days
      end

      #
      # 月の名前（大小）を返す
      #
      # @return [String] 月の名前（大小）
      #
      def days_name
        @month_label.days_name
      end

      #
      # 月を返す
      #
      # @return [Integer] 月（xx月のxx）
      #
      def number
        @month_label.number
      end

      #
      # 閏を返す
      #
      # @return [True] 閏月
      # @return [False] 平月
      #
      def leaped?
        @month_label.leaped
      end

      #
      # 次月の大余から月の日数を定める
      #
      # @param [Integer] next_month_day 次月の大余
      #
      def eval_many_days(next_month_day:)
        is_many_days = remainder.same_remainder_divided_by_ten?(other: next_month_day)

        @month_label = MonthLabel.new(
          number: number, is_many_days: is_many_days, leaped: leaped?
        )
      end

      #
      # 二十四節気が未設定かどうかを検証する
      #
      # @return [True] 設定なし
      # @return [False] 設定あり
      #
      def empty_solar_term?
        @solar_terms.empty?
      end

      #
      # 中気を返す
      #
      # @return [SolarTerm] 中気
      #
      def even_term
        @solar_terms.each do |term|
          return term if term.index.even?
        end

        SolarTerm.new
      end

      #
      # 節気を返す
      #
      # @return [SolarTerm] 節気
      #
      def odd_term
        @solar_terms.each do |term|
          return term if term.index.odd?
        end

        SolarTerm.new
      end

      #
      # 二十四節気を追加する
      #
      # @param [SolarTerm] term 二十四節気
      #
      def add_term(term:)
        @solar_terms.push(term)
      end

      #
      # 現在の二十四節気に合わせて月表示情報を書き換える
      #
      def rename_month_label_by_solar_term
        return ArgumentError.new, 'solar term must not be empty.' if empty_solar_term?

        even = even_term

        if even.invalid?
          odd = odd_term

          @month_label = MonthLabel.new(
            number: month_number_by_odd_term_index(odd.index),
            leaped: true, is_many_days: @month_label.is_many_days
          )
          return
        end

        @month_label = MonthLabel.new(
          number: month_number_by_even_term_index(even.index),
          leaped: false, is_many_days: @month_label.is_many_days
        )
      end

      #
      # 中気の連番に合わせて月を返す
      #
      # @example
      #   20: 9月
      #   22: 10月
      #   0: 11月
      #   2: 12月
      #   4: 1月
      #
      # @param [Integer] index 中気番号
      #
      # @return [Integer] 月
      #
      def month_number_by_even_term_index(index)
        half_index = index / 2

        # 11月、12月
        return half_index + 11 if half_index < 2

        # 1月～10月
        half_index - 1
      end

      #
      # 節気の連番に合わせて月を返す
      #
      # @param [Integer] index 節気番号
      #
      # @return [Integer] 月
      #
      def month_number_by_odd_term_index(index)
        even_index = index - 1

        month_number_by_even_term_index(even_index)
      end

      #
      # 同一の月情報かを検証する
      #
      # @param [Month] other 他の月情報
      #
      # @return [True] 同一の月
      # @return [False] 異なる月
      #
      def same?(other:)
        number == other.number && leaped? == other.leaped?
      end
    end
  end
end
