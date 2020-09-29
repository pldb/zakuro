# frozen_string_literal: true

require_relative '../base/multi_gengou_roller'

require_relative '../../../era/western'
require_relative './annual_range'

# :nodoc:
module Zakuro
  # :nodoc:
  module Senmyou
    # FullRange 完全範囲
    #   ある日からある日の範囲を計算可能な年月範囲
    #   * 前提として元号年はその元号の開始年から数える
    #   * ある日の元号年を求める場合、その元号が含まれる最初の年まで遡る
    #   * 元号は一つとは限らない。南北朝などで二つある場合は、古い方の元号から求める
    #
    # NOTE: 割り当てた元号は年初を基準にした元号年である
    #   * 元旦を基準にした時の正しい元号を設定している
    #   * 引き当てたい日付が元旦ではない場合、その月日に従い元号を再度求める
    #   * この再計算が必要になるのは、元号が切り替わる年のみである
    class FullRange
      attr_reader :multi_gengou_roller
      attr_reader :new_year_date
      attr_reader :western_year

      # @return [Logger] ロガー
      LOGGER = Logger.new(location: 'full_range')

      def initialize(start_date: Western::Calendar.new, end_date: Western::Calendar.new)
        @multi_gengou_roller = MultiGengouRoller.new(start_date: start_date, end_date: end_date)
        @new_year_date = @multi_gengou_roller.oldest_date.clone
        @western_year = @new_year_date.year
      end

      #
      # 完全範囲を取得する
      #
      # @return [Array<Year>] 完全範囲
      #
      def get
        years = FullRange.rearranged_years(annual_ranges: annual_ranges)
        years = update_gengou(years: years)
        years
      end

      #
      # 完全範囲内の年データを取得する
      #
      # @return [Array<Year>] 年データ（冬至基準）
      #
      def annual_ranges
        oldest_date = @new_year_date
        newest_date = @multi_gengou_roller.newest_date

        years = []
        ((oldest_date.year)..(newest_date.year + 2)).each do |year|
          years.push(
            AnnualRange.collect_annual_range_after_last_november_1st(
              western_year: year
            )
          )
        end

        years
      end

      #
      # 完全範囲内の年データの開始月を変更する
      #
      # @param [Array<Year>] annual_ranges 年データ（冬至基準）
      #
      # @return [Array<Year>] 年データ（元旦基準）
      #
      def self.rearranged_years(annual_ranges:)
        years = []

        (0..(annual_ranges.size - 2)).each do |index|
          current_annual_range = annual_ranges[index]
          next_annual_range = annual_ranges[index + 1]

          year = push_current_year(annual_range: current_annual_range)
          push_last_year(annual_range: next_annual_range, year: year)
          years.push(year)
        end

        years
      end

      #
      # 完全範囲内の年データの元号を開始年基準で更新する
      #
      # @param [Array<Year>] years 年データ（元旦基準）
      #
      # @return [Array<Year>] 元号更新済み年データ（元旦基準）
      #
      def update_gengou(years:)
        updated_years = []

        nearest_end_date = @multi_gengou_roller.choise_nearest_end_date

        years.each do |year|
          multi_gengou = @multi_gengou_roller.multi_gengou.clone

          updated_year = Year.new(multi_gengou: multi_gengou, new_year_date: @new_year_date.clone,
                                  months: year.months)
          updated_year.commit

          updated_years.push(updated_year)

          total_days = updated_year.total_days
          @new_year_date += total_days
          @multi_gengou_roller.next(days: total_days)

          if @new_year_date > nearest_end_date
            @multi_gengou_roller.transfer
            nearest_end_date = @multi_gengou_roller.choise_nearest_end_date
          end
          @multi_gengou_roller.next_year
        end

        updated_years
      end

      #
      # 当年データを生成する
      #
      def self.push_current_year(annual_range:, year: Year.new)
        annual_range.each do |month|
          next if month.is_last_year

          year.push(month: month)
        end

        year
      end

      #
      # 当年データを生成する
      #
      def self.push_last_year(annual_range:, year: Year.new)
        annual_range.each do |month|
          next unless month.is_last_year

          year.push(month: month)
        end

        year
      end
    end
  end
end
