# frozen_string_literal: true

require_relative '../../era/western/calendar'
require_relative '../../output/logger'

require_relative '../gengou/scroll'

require_relative '../base/gengou'
require_relative '../base/year'

require_relative './transfer/year_boundary'

# :nodoc:
module Zakuro
  # :nodoc:
  module Calculation
    # :nodoc:
    module Range
      # :reek:TooManyInstanceVariables { max_instance_variables: 6 }

      #
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
      #
      class FullRange
        # @return [Context] 暦コンテキスト
        attr_reader :context
        # @return [Western::Calendar] 開始日
        attr_reader :start_date
        # @return [Western::Calendar] 終了日
        attr_reader :end_date
        # @return [MultiGengouRoller] 改元処理
        attr_reader :scroll

        # @return [Output::Logger] ロガー
        LOGGER = Output::Logger.new(location: 'full_range')

        #
        # 初期化
        #
        # @param [Context] context 暦コンテキスト
        # @param [Western::Calendar] start_date 開始日
        # @param [Western::Calendar] end_date 終了日
        #
        def initialize(context:, start_date: Western::Calendar.new, end_date: Western::Calendar.new)
          @start_date = start_date
          @end_date = end_date
          return if invalid?

          @context = context
          @scroll = Gengou::Scroll.new(start_date: start_date, end_date: end_date)
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

          years = Transfer::YearBoundary.get(
            context: @context, annual_ranges: annual_ranges
          )
          years = update_gengou(years: years)

          years
        end

        # :reek:TooManyStatements { max_statements: 7 }

        #
        # 完全範囲内の年データを取得する
        #
        # @return [Array<Year>] 年データ（冬至基準）
        #
        def annual_ranges
          start_year = @scroll.western_start_year
          end_year = @scroll.western_end_year

          annual_range = context.resolver.annual_range

          years = []
          (start_year..(end_year + 1)).each do |year|
            years.push(
              annual_range.get(
                context: @context, western_year: year
              )
            )
          end

          years
        end

        #
        # 元号を更新する
        #
        # @param [Array<Year>] years 年データ（元旦基準）
        #
        # @return [Array<Year>] 元号更新済み年データ（元旦基準）
        #
        def update_gengou(years:)
          years.each do |year|
            year.months.each_with_index do |month, index|
              @scroll.run(month: month)
              gengou = @scroll.to_gengou
              year.months[index] = Monthly::Month.new(
                context: context,
                month_label: month.month_label,
                first_day: Monthly::FirstDay.new(
                  remainder: month.first_day.remainder,
                  western_date: gengou.start_date.clone
                ),
                solar_terms: month.solar_terms, gengou: gengou
              )
              # TODO: make
              if gengou.first_line.size.zero?
                p 'nothing'
                next
              end
              p year.months[index].first_day.western_date
              p gengou.first_line[0].name
              p gengou.first_line[0].year
            end
          end
        end

        # # :reek:TooManyStatements { max_statements: 8 }

        # #
        # # 完全範囲内の年データの元号を開始年基準で更新する
        # #
        # # @param [Array<Year>] years 年データ（元旦基準）
        # #
        # # @return [Array<Year>] 元号更新済み年データ（元旦基準）
        # #
        # def update_gengou(years:)
        #   updated_years = []

        #   nearest_end_date = choise_nearest_end_date

        #   years.each do |year|
        #     next_year(years: updated_years, year: year)

        #     if @new_year_date > nearest_end_date
        #       @multi_gengou_roller.transfer
        #       nearest_end_date = choise_nearest_end_date
        #     end
        #     @multi_gengou_roller.next_year
        #   end

        #   updated_years
        # end

        # private

        # #
        # # 元号処理対象の年を進める
        # #
        # # @param [Array<Year>] years 元号処理済み年データ（元旦基準）
        # # @param [Year] year 元号処理前の年（元旦基準）
        # #
        # def next_year(years:, year:)
        #   updated_year = update_year(year: year)

        #   years.push(updated_year)

        #   next_new_year_date(total_days: updated_year.total_days)

        #   nil
        # end

        # #
        # # 年の元号を更新する
        # #
        # # @param [Year] year 元号処理前の年（元旦基準）
        # #
        # # @return [Year] 元号処理済の年（元旦基準）
        # #
        # def update_year(year:)
        #   multi_gengou = @multi_gengou_roller.multi_gengou.clone

        #   updated_year = Base::Year.new(
        #     multi_gengou: multi_gengou, new_year_date: @new_year_date.clone,
        #     months: year.months
        #   )
        #   updated_year.commit

        #   updated_year
        # end

        # #
        # # 次の年に進める
        # #
        # # @param [Integer] total_days 年の日数
        # #
        # def next_new_year_date(total_days:)
        #   @new_year_date += total_days
        #   @multi_gengou_roller.next(days: total_days)

        #   nil
        # end

        # #
        # # 現在日からみて直近の未来に対する元号の切替前日を求める
        # #
        # # @return [Western::Calendar] 元号の切替前日
        # #
        # def choise_nearest_end_date
        #   @multi_gengou_roller.choise_nearest_end_date
        # end
      end
    end
  end
end
