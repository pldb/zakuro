# frozen_string_literal: true

require_relative './operated_solar_terms'
require_relative '../../operation/operation'
require_relative '../../calculation/monthly/operated_month'

# :nodoc:
module Zakuro
  # :nodoc:
  module Calculation
    # :nodoc:
    module Range
      #
      # OperatedRange 運用結果範囲
      #
      # 何らかの理由により、計算された暦とは異なる運用結果である場合、その結果に合わせて計算結果を上書きする
      class OperatedRange
        # @return [Array<Year>] 年データ（完全範囲）
        attr_reader :years
        # @return [OperatedSolarTerms] 運用時二十四節気
        attr_reader :operated_solar_terms
        # @return [Context] 暦コンテキスト
        attr_reader :context

        #
        # 初期化
        #
        # @param [Context] context 暦コンテキスト
        # @param [Array<Year>] years 年データ（完全範囲）
        #
        def initialize(context:, years: [])
          @context = context
          @years = years
          @operated_solar_terms = OperatedSolarTerms.new(context: context, years: @years)
          @operated_solar_terms.create
        end

        #
        # 運用結果範囲を取得する
        #
        # @return [Array<Year>] 運用結果範囲
        #
        def get
          rewrite
        end

        #
        # 運用結果に書き換える
        #
        # @return [Array<Year>] 運用結果範囲
        #
        def rewrite
          operated_years = []

          years.each do |year|
            operated_year = OperatedRange.rewrite_year(
              context: context, year: year,
              operated_solar_terms: @operated_solar_terms
            )
            operated_years.push(operated_year)
          end

          operated_years
        end

        #
        # 年を書き換える
        #
        # @param [Context] context 暦コンテキスト
        # @param [Year] year 年
        # @param [OperatedSolarTerms] operated_solar_terms 運用時二十四節気
        #
        # @return [Year] 年
        #
        def self.rewrite_year(context:, year:, operated_solar_terms:)
          result = Base::Year.new(
            multi_gengou: year.multi_gengou, new_year_date: year.new_year_date
          )
          year.months.each do |month|
            result.push(month: resolve_month(
              context: context, month: month,
              operated_solar_terms: operated_solar_terms
            ))
          end

          result.commit

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

          return month if history.invalid?

          OperatedRange.rewrite_month(
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
          return month unless month.western_date == history.western_date

          operated_month = Monthly::OperatedMonth.new(
            context: context,
            month_label: month.month_label, first_day: month.first_day,
            solar_terms: month.solar_terms, history: history,
            operated_solar_terms: operated_solar_terms
          )

          operated_month.rewrite

          Monthly::Month.new(
            context: context,
            month_label: operated_month.month_label, first_day: operated_month.first_day,
            solar_terms: operated_month.solar_terms
          )
        end
      end
    end
  end
end
