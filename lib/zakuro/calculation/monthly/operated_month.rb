# frozen_string_literal: true

require_relative '../../operation/operation'
require_relative './operated_solar_term'
require_relative './month'

# :nodoc:
module Zakuro
  # :nodoc:
  module Calculation
    # :nodoc:
    module Monthly
      # :reek:TooManyInstanceVariables { max_instance_variables: 6 }

      #
      # OperatedMonth 月情報（運用）
      #
      class OperatedMonth < Month
        # @return [Operation::MonthHistory] 変更履歴（月）
        attr_reader :history
        # @return [OperatedSolarTerm] 運用時二十四節気
        attr_reader :operated_solar_term

        # :reek:LongParameterList {max_params: 6}
        # rubocop:disable Metrics/ParameterLists

        #
        # 初期化
        #
        # @param [Context::Context] context 暦コンテキスト
        # @param [OperatedSolarTerm] operated_solar_term 運用時二十四節気
        # @param [MonthLabel] month_label 月表示名
        # @param [FirstDay] first_day 月初日（朔日）
        # @param [Array<SolarTerm>] solar_terms 二十四節気
        # @param [Operation::MonthHistory] history 変更履歴（月）
        # @param [Meta] meta 付加情報
        #
        def initialize(context:, operated_solar_term:, month_label: MonthLabel.new,
                       first_day: FirstDay.new, solar_terms: [], gengou: Base::Gengou.new,
                       history: Operation::MonthHistory.new, meta: Meta.new)
          super(context: context, month_label: month_label, first_day: first_day,
                solar_terms: solar_terms, gengou: gengou, meta: meta)
          @history = history
          @operated_solar_term = operated_solar_term
          @moved = false
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
            number: self.class.rewrite_month_fields(
              month_diff: diff, month_label: month_label, name: 'number'
            ),
            is_many_days: self.class.rewrite_month_fields(
              month_diff: diff, month_label: month_label, name: 'is_many_days'
            ),
            leaped: self.class.rewrite_month_fields(
              month_diff: diff, month_label: month_label, name: 'leaped'
            )
          )
        end

        #
        # 二十四節気ごとの差分で書き換える
        #
        def rewrite_solar_terms
          matched, solar_term = operated_solar_term.get(
            western_date: first_day.western_date
          )

          return unless matched

          @solar_terms = OperatedSolarTerm.create_operated_solar_term(
            operated_solar_term: solar_term,
            solar_terms: solar_terms
          )
        end

        #
        # 月初日ごとの差分で書き換える
        #
        def rewrite_first_day
          diffs = history.diffs
          return if diffs.invalid_days?

          days = diffs.days

          @first_day = FirstDay.new(
            western_date: rewrite_western_date(days: days),
            remainder: rewrite_remainder(days: days),
            average_remainder: rewrite_average_remainder(days: days)
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
        # 月初日の大余小余を日差分で書き換える（経朔）
        #
        # @param [Integer] days 日差分
        #
        # @return [Remainder] 月初日の大余小余
        #
        def rewrite_average_remainder(days:)
          remainder = first_day.average_remainder.clone
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

        #
        # 運用情報では昨年の月か
        #
        # @return [True] 昨年の月
        # @return [False] 今年/来年の月
        #
        def last_year?
          history_month_number.last_year?
        end

        #
        # 運用情報では来年の月か
        #
        # @return [True] 来年の月
        # @return [False] 今年/昨年の月
        #
        def next_year?
          history_month_number.next_year?
        end

        #
        # 別の年に移動したか
        #
        # @return [True] 移動済
        # @return [False] 移動なし
        #
        def moved?
          @moved
        end

        #
        # 移動済とする
        #
        def moved
          @moved = true
        end

        class << self
          #
          # 計算結果を該当のフィールドの運用情報に書き換える
          #
          # @param [Operation::Diffs] month_diff 月差分
          # @param [MonthLabel] month_label 月表示情報
          # @param [String] name フィールド名
          #
          # @return [Object] 運用情報
          #
          def rewrite_month_fields(month_diff:, month_label:, name:)
            method_name = name.intern

            diff = month_diff.send(method_name)
            default = month_label.send(method_name)
            return default if diff.invalid?

            diff.dest
          end
        end

        private

        def history_month_number
          history.diffs.month.number
        end
      end
    end
  end
end
