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

      #
      # 一ヶ月戻す
      #
      def back_to_last_month
        @is_last_year = true if month_label.back_to_last_month
      end
    end
  end
end
