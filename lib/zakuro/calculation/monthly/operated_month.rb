# frozen_string_literal: true

require_relative './month'
require_relative '../../operation/operation'

# :nodoc:
module Zakuro
  # :nodoc:
  module Calculation
    # :nodoc:
    module Monthly
      # :reek:TooManyInstanceVariables { max_instance_variables: 5 }

      #
      # OperatedMonth 月情報（運用）
      #
      class OperatedMonth < Month
        # @return [Operation::MonthHistory] 変更履歴（月）
        attr_reader :history
        # @return [OperatedSolarTerms] 運用時二十四節気
        attr_reader :operated_solar_terms

        # :reek:LongParameterList {max_params: 6}
        # rubocop:disable Metrics/ParameterLists

        #
        # 初期化
        #
        # @param [Context] context 暦コンテキスト
        # @param [OperatedSolarTerms] operated_solar_terms 運用時二十四節気
        # @param [MonthLabel] month_label 月表示名
        # @param [FirstDay] first_day 月初日（朔日）
        # @param [Array<SolarTerm>] solar_terms 二十四節気
        # @param [Operation::MonthHistory] history 変更履歴（月）
        #
        def initialize(context:, operated_solar_terms:, month_label: MonthLabel.new,
                       first_day: FirstDay.new, solar_terms: [],
                       history: Operation::MonthHistory.new)
          super(context: context, month_label: month_label, first_day: first_day,
                solar_terms: solar_terms)
          @history = history
          @operated_solar_terms = operated_solar_terms
        end

        # rubocop:enable Metrics/ParameterLists

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
            number: OperatedMonth.rewrite_month_fields(
              month_diff: diff, month_label: month_label, name: 'number'
            ),
            is_many_days: OperatedMonth.rewrite_month_fields(
              month_diff: diff, month_label: month_label, name: 'is_many_days'
            ),
            leaped: OperatedMonth.rewrite_month_fields(
              month_diff: diff, month_label: month_label, name: 'leaped'
            )
          )
        end

        def self.rewrite_month_fields(month_diff:, month_label:, name:)
          method_name = name.intern

          diff = month_diff.send(method_name)
          default = month_label.send(method_name)
          return default if diff.invalid?

          diff.actual
        end

        #
        # 二十四節気ごとの差分で書き換える
        #
        def rewrite_solar_terms
          matched, operated_solar_term = @operated_solar_terms.get(
            western_date: first_day.western_date
          )

          return unless matched

          @solar_terms = OperatedMonth.create_operated_solar_terms(
            operated_solar_term: operated_solar_term,
            solar_terms: solar_terms
          )
        end

        #
        # <Description>
        #
        # @param [<Type>] operated_solar_term <description>
        # @param [Array<SolarTerm>] solar_terms 二十四節気
        #
        # @return [Array<SolarTerm>] 二十四節気
        #
        def self.create_operated_solar_terms(operated_solar_term:, solar_terms:)
          index = operated_solar_term.index

          # 別の月に移動する二十四節気。割り当てない。
          result = remove_solar_term(index: index, solar_terms: solar_terms)

          return result if used_solar_term?(index: index, solar_terms: solar_terms)

          result.push(operated_solar_term)

          result
        end

        # :reek:ControlParameter

        #
        # 二十四節気が使用されているか
        #
        # @param [Integer] index 二十四節気番号
        # @param [Array<SolarTerm>] solar_terms 二十四節気
        #
        # @return [True] 使用
        # @return [False] 未使用
        #
        def self.used_solar_term?(index:, solar_terms:)
          solar_terms.each do |solar_term|
            return true if index == solar_term.index
          end

          false
        end

        # :reek:ControlParameter

        #
        # 対象の二十四節気を除外する
        #
        # @param [Integer] index 二十四節気番号
        # @param [Array<SolarTerm>] solar_terms 二十四節気
        #
        # @return [Array<SolarTerm>] 二十四節気（対象除外済）
        #
        def self.remove_solar_term(index:, solar_terms:)
          result = []
          solar_terms.each do |solar_term|
            next if index == solar_term.index

            result.push(solar_term)
          end

          result
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
          remainder = first_day.remainder.clone
          remainder.add!(
            context.resolver.remainder.new(day: days, minute: 0, second: 0)
          )

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
          western_date = first_day.western_date.clone
          western_date += days

          western_date
        end
      end
    end
  end
end
