# frozen_string_literal: true

require_relative './operated_solar_terms'
require_relative '../../operation/operation'
require_relative '../base/operated_year'
require_relative '../../calculation/monthly/operated_month'
require_relative './transfer/gengou_scroller'

# :nodoc:
module Zakuro
  # :nodoc:
  module Calculation
    # :nodoc:
    module Range
      #
      # AbstractOperationRange 運用結果範囲
      #
      # 何らかの理由により、計算された暦とは異なる運用結果である場合、その結果に合わせて計算結果を上書きする
      class AbstractOperationRange
        # @return [Array<Year>] 年データ（完全範囲）
        attr_reader :years
        # @return [OperatedSolarTerms] 運用時二十四節気
        attr_reader :operated_solar_terms
        # @return [Context::Context] 暦コンテキスト
        attr_reader :context

        #
        # 初期化
        #
        # @param [Context::Context] context 暦コンテキスト
        # @param [Gengou::AbstractScroll] scroll 元号スクロール
        # @param [Array<Year>] years 年データ（完全範囲）
        #
        def initialize(context:, scroll:, years: [])
          @context = context
          @years = years
          @scroll = scroll
          @operated_solar_terms = OperatedSolarTerms.new(context: context, years: @years)
          @operated_solar_terms.create
        end

        #
        # 運用結果範囲を取得する
        #
        # @return [Array<Year>] 運用結果範囲
        #
        def get
          operated_years = rewrite

          AbstractOperationRange.move(operated_years: operated_years)

          AbstractOperationRange.commit(operated_years: operated_years)

          Transfer::GengouScroller.set(scroll: @scroll, years: operated_years)

          operated_years
        end

        #
        # 運用結果に書き換える
        #
        # @return [Array<OperatedYear>] 運用結果範囲
        #
        def rewrite
          operated_years = []

          years.each do |year|
            operated_year = AbstractOperationRange.rewrite_year(
              year: year,
              operated_solar_terms: @operated_solar_terms
            )
            operated_years.push(operated_year)
          end

          operated_years
        end

        #
        # 運用情報で年を跨ぐ月をその年に寄せる
        #
        # @param [Array<OperatedYear>] operated_years 運用結果範囲
        #
        def self.move(operated_years:)
          move_into_next_year(operated_years: operated_years)
          move_into_last_year(operated_years: operated_years)
        end

        #
        # 運用情報では来年に属する月を来年に寄せる
        #
        # @param [Array<OperatedYear>] operated_years 運用結果範囲
        #
        def self.move_into_next_year(operated_years:)
          operated_years.each_cons(2) do |current_year, next_year|
            months = current_year.pop_next_year_months

            next_year.unshift_months(months)
          end
        end

        #
        # 運用情報では昨年に属する月を昨年に寄せる
        #
        # @param [Array<OperatedYear>] operated_years 運用結果範囲
        #
        def self.move_into_last_year(operated_years:)
          rerversed_year = operated_years.reverse!
          rerversed_year.each_cons(2) do |current_year, last_year|
            months = current_year.shift_last_year_months
            last_year.push_months(months)
          end

          rerversed_year.reverse!
        end

        #
        # 年を確定させる
        #
        # @param [Array<OperatedYear>] operated_years 運用結果範囲
        #
        def self.commit(operated_years:)
          operated_years.each(&:commit)
        end

        #
        # 年を書き換える
        #
        # @param [Year] year 年
        # @param [OperatedSolarTerms] operated_solar_terms 運用時二十四節気
        #
        # @return [OperatedYear] 年
        #
        def self.rewrite_year(year:, operated_solar_terms:)
          context = year.context
          result = Base::OperatedYear.new(context: context)
          year.months.each do |month|
            result.push(month: resolve_month(
              context: context, month: month,
              operated_solar_terms: operated_solar_terms
            ))
          end

          result
        end

        #
        # 履歴情報の有無に応じた月にする
        #
        # @param [Context] context 暦コンテキスト
        # @param [Month] month 月
        # @param [OperatedSolarTerms] operated_solar_terms 運用時二十四節気
        #
        # @return [Month] 月
        #
        def self.resolve_month(context:, month:, operated_solar_terms:)
          history = Operation.specify_history(western_date: month.western_date)

          AbstractOperationRange.rewrite_month(
            context: context, month: month, history: history,
            operated_solar_terms: operated_solar_terms
          )
        end

        # :reek:LongParameterList {max_params: 4}

        #
        # 月を運用結果に書き換える
        #
        # @param [Context] context 暦コンテキスト
        # @param [Month] month 月
        # @param [Operation::MonthHistory] history 変更履歴
        # @param [OperatedSolarTerms] operated_solar_terms 運用時二十四節気
        #
        # @return [Month] 月（運用結果）
        #
        def self.rewrite_month(context:, month:, history:, operated_solar_terms:)
          operated_month = Monthly::OperatedMonth.new(
            context: context,
            month_label: month.month_label, first_day: month.first_day,
            solar_terms: month.solar_terms, history: history, gengou: month.gengou,
            operated_solar_terms: operated_solar_terms
          )

          operated_month.rewrite unless history.invalid?

          operated_month
        end
      end
    end
  end
end
