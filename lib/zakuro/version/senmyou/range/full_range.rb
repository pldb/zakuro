# frozen_string_literal: true

require_relative '../base/multi_gengou_roller'

require_relative '../../../era/western'
require_relative './annual_range'

require_relative '../base/year'

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
      # @return [Western::Calendar] 開始日
      attr_reader :start_date
      # @return [Western::Calendar] 終了日
      attr_reader :end_date
      # @return [MultiGengouRoller] 改元処理
      attr_reader :multi_gengou_roller
      # @return [Western::Calendar] 最過去の元旦
      attr_reader :new_year_date
      # @return [Integer] 西暦年
      attr_reader :western_year

      # @return [Logger] ロガー
      LOGGER = Logger.new(location: 'full_range')

      #
      # 初期化
      #
      # @param [Western::Calendar] start_date 開始日
      # @param [Western::Calendar] end_date 終了日
      #
      def initialize(start_date: Western::Calendar.new, end_date: Western::Calendar.new)
        @start_date = start_date
        @end_date = end_date
        return if invalid?

        @multi_gengou_roller = MultiGengouRoller.new(start_date: start_date, end_date: end_date)
        @new_year_date = @multi_gengou_roller.oldest_date.clone
        @western_year = @new_year_date.year
      end

      #
      # 無効か
      #
      # @return [True] 無効
      # @return [False] 有効
      #
      def invalid?
        @start_date.invalid?
      end

      #
      # 完全範囲を取得する
      #
      # @return [Array<Year>] 完全範囲
      #
      def get
        return [] if invalid?

        years = FullRange.rearranged_years(annual_ranges: annual_ranges)
        years = update_gengou(years: years)
        update_first_day(years: years)
      end

      # :reek:TooManyStatements { max_statements: 6 }

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
          year = rearranged_year(annual_ranges: annual_ranges, index: index)
          years.push(year)
        end

        years
      end

      # :reek:TooManyStatements { max_statements: 8 }

      #
      # 完全範囲内の年データの元号を開始年基準で更新する
      #
      # @param [Array<Year>] years 年データ（元旦基準）
      #
      # @return [Array<Year>] 元号更新済み年データ（元旦基準）
      #
      def update_gengou(years:)
        updated_years = []

        nearest_end_date = choise_nearest_end_date

        years.each do |year|
          next_year(years: updated_years, year: year)

          if @new_year_date > nearest_end_date
            @multi_gengou_roller.transfer
            nearest_end_date = choise_nearest_end_date
          end
          @multi_gengou_roller.next_year
        end

        updated_years
      end

      #
      # 月初日の西暦日を更新する
      #
      # @param [Array<Year>] years 完全範囲（月初日なし）
      #
      # @return [Array<Year>] 完全範囲（月初日あり）
      #
      def update_first_day(years:)
        # TODO: リファクタリング

        result = []

        years.each do |year|
          first_day = year.new_year_date.clone

          months = []
          year.months.each do |month|
            updated_month = Month.new(
              is_last_year: month.is_last_year, number: month.number,
              is_many_days: month.is_many_days, leaped: month.leaped,
              remainder: month.remainder, phase_index: month.phase_index,
              even_term: month.even_term.clone, odd_term: month.odd_term.clone,
              western_date: first_day
            )
            months.push(updated_month)

            first_day = first_day.clone + updated_month.days
          end

          updated_year = Year.new(
            multi_gengou: year.multi_gengou, new_year_date: year.new_year_date,
            months: months, total_days: year.total_days
          )

          result.push(updated_year)
        end

        result
      end

      #
      # 当年データを生成する
      #
      # @param [Array<Year>] annual_ranges 年データ（冬至基準）
      # @param [Year] year 対象年
      #
      # @return [Year] 当年月ありの対象年
      #
      def self.push_current_year(annual_range:, year: Year.new)
        annual_range.each do |month|
          next if month.is_last_year

          year.push(month: month)
        end

        year
      end

      #
      # 昨年データを生成する
      #
      # @param [Array<Year>] annual_ranges 年データ（冬至基準）
      # @param [Year] year 対象年
      #
      # @return [Year] 昨年月ありの対象年
      #
      def self.push_last_year(annual_range:, year: Year.new)
        annual_range.each do |month|
          next unless month.is_last_year

          year.push(month: month)
        end

        year
      end

      #
      # 年データの開始月を変更する
      #
      # @param [Array<Year>] annual_ranges 年データ（冬至基準）
      # @param [Integer] index 対象年の要素番号
      #
      # @return [Year] 年データ（元旦基準）
      #
      def self.rearranged_year(annual_ranges:, index:)
        current_annual_range = annual_ranges[index]
        next_annual_range = annual_ranges[index + 1]

        year = push_current_year(annual_range: current_annual_range)
        push_last_year(annual_range: next_annual_range, year: year)

        year
      end
      private_class_method :rearranged_year

      private

      #
      # 元号処理対象の年を進める
      #
      # @param [Array<Year>] years 元号処理済み年データ（元旦基準）
      # @param [Year] year 元号処理前の年（元旦基準）
      #
      def next_year(years:, year:)
        updated_year = update_year(year: year)

        years.push(updated_year)

        next_new_year_date(total_days: updated_year.total_days)

        nil
      end

      #
      # 年の元号を更新する
      #
      # @param [Year] year 元号処理前の年（元旦基準）
      #
      # @return [Year] 元号処理済の年（元旦基準）
      #
      def update_year(year:)
        multi_gengou = @multi_gengou_roller.multi_gengou.clone

        updated_year = Year.new(multi_gengou: multi_gengou, new_year_date: @new_year_date.clone,
                                months: year.months)
        updated_year.commit

        updated_year
      end

      #
      # 次の年に進める
      #
      # @param [Integer] total_days 年の日数
      #
      def next_new_year_date(total_days:)
        @new_year_date += total_days
        @multi_gengou_roller.next(days: total_days)

        nil
      end

      #
      # 現在日からみて直近の未来に対する元号の切替前日を求める
      #
      # @return [Western::Calendar] 元号の切替前日
      #
      def choise_nearest_end_date
        @multi_gengou_roller.choise_nearest_end_date
      end
    end
  end
end