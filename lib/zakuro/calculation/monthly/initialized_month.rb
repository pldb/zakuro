# frozen_string_literal: true

require_relative './month'

# TODO: moduleでMonthly とする（全暦むけに共通化したあと）

# :nodoc:
module Zakuro
  # :nodoc:
  module Senmyou
    #
    # InitializedMonth 初期月情報
    #
    class InitializedMonth < Month
      # @return [True] 昨年の月
      # @return [False] 今年の月
      # @note 冬至基準で1年データを作成するため昨年の11月-12月である可能性がある
      attr_reader :is_last_year
      # @return [Integer] 月齢（朔月、上弦、望月、下弦）
      attr_reader :phase_index

      # :reek:ControlParameter and :reek:BooleanParameter

      #
      # 初期化
      #
      # @param [MonthLabel] month_label 月表示名
      # @param [Array<SolarTerm>] solar_terms 二十四節気
      # @param [FirstDay] first_day 月初日（朔日）
      # @param [True, False] is_last_year 昨年の月/今年の月
      # @param [Integer] phase_index 月齢（朔月、上弦、望月、下弦）
      #
      def initialize(month_label: MonthLabel.new, solar_terms: [], first_day: FirstDay.new,
                     is_last_year: false, phase_index: -1)
        super(month_label: month_label, solar_terms: solar_terms, first_day: first_day)
        @is_last_year = is_last_year
        @phase_index = phase_index
      end

      # :reek:TooManyStatements { max_statements: 6 }

      #
      # 現在の二十四節気に合わせて月表示情報を書き換える
      #
      def rename_month_label_by_solar_term
        return ArgumentError.new, 'solar term must not be empty.' if empty_solar_term?

        even = even_term

        is_many_days = month_label.is_many_days
        if even.invalid?
          @month_label = MonthLabel.new(
            number: InitializedMonth.month_number_by_odd_term_index(odd_term.index),
            leaped: true, is_many_days: is_many_days
          )
          return
        end

        @month_label = MonthLabel.new(
          number: InitializedMonth.month_number_by_even_term_index(even.index),
          leaped: false, is_many_days: is_many_days
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
      def self.month_number_by_even_term_index(index)
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
      def self.month_number_by_odd_term_index(index)
        even_index = index - 1

        month_number_by_even_term_index(even_index)
      end

      #
      # 一ヶ月戻す
      #
      def back_to_last_month
        @is_last_year = true if month_label.back_to_last_month
      end

      #
      # 二十四節気の数を返す
      #
      # @return [Integer] 二十四節気の数
      #
      def solar_term_size
        solar_terms.size
      end
    end
  end
end
