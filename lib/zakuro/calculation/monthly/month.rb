# frozen_string_literal: true

require_relative '../cycle/abstract_solar_term'

require_relative '../base/gengou'
require_relative './internal/part/first_day'
require_relative './internal/part/meta'
require_relative './internal/part/month_label'
require_relative './internal/meta/meta_collector'

require_relative './internal/solar_term_selector'
require_relative './internal/date_comparer'

# :nodoc:
module Zakuro
  # :nodoc:
  module Calculation
    # :nodoc:
    module Monthly
      #
      # Month 月情報
      #
      class Month
        # @return [Context::Context] 暦コンテキスト
        attr_reader :context
        # @return [MonthLabel] 月表示名
        attr_reader :month_label
        # @return [FirstDay] 月初日（朔日）
        attr_reader :first_day
        # @return [SolarTermSelector] 二十四節気検索
        attr_reader :solar_term_selector
        # @return [Base::Gengou] 元号
        attr_reader :gengou
        # @return [Meta] 付加情報
        attr_reader :meta

        # rubocop:disable Metrics/ParameterLists

        #
        # 初期化
        #
        # @param [Context::Context] context 暦コンテキスト
        # @param [MonthLabel] month_label 月表示名
        # @param [FirstDay] first_day 月初日（朔日）
        # @param [Array<Cyle::AbstractSolarTerm>] solar_terms 二十四節気
        # @param [Base::Gengou] gengou 元号
        # @param [Meta] meta 付加情報
        #
        def initialize(context: Context::Context.new, month_label: MonthLabel.new,
                       first_day: FirstDay.new, solar_terms: [], gengou: Base::Gengou.new,
                       meta: Meta.new)
          @context = context
          @month_label = month_label
          @first_day = first_day
          @solar_term_selector = SolarTermSelector.new(context: context, solar_terms: solar_terms)
          @gengou = gengou
          @meta = meta
        end

        # rubocop:enable Metrics/ParameterLists

        #
        # 不正か
        #
        # @return [True] 不正
        # @return [False] 不正なし
        #
        def invalid?
          context.invalid?
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
          first_day.western_date
        end

        #
        # 月初日の大余小余を返す
        #
        # @return [Remainder] 大余小余
        #
        def remainder
          first_day.remainder
        end

        #
        # 月の大小を返す
        #
        # @return [True] 大の月（30日）
        # @return [False] 小の月（29日）
        #
        def many_days?
          month_label.is_many_days
        end

        #
        # 月の日数を返す
        #
        # @return [Integer] 日数
        #
        def days
          month_label.days
        end

        #
        # 月の名前（大小）を返す
        #
        # @return [String] 月の名前（大小）
        #
        def days_name
          month_label.days_name
        end

        #
        # 月を返す
        #
        # @return [Integer] 月（xx月のxx）
        #
        def number
          month_label.number
        end

        #
        # 閏を返す
        #
        # @return [True] 閏月
        # @return [False] 平月
        #
        def leaped?
          month_label.leaped
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
          solar_term_selector.empty?
        end

        #
        # 中気を返す
        #
        # @return [Cycle::AbstractSolarTerm] 中気
        #
        def even_term
          solar_term_selector.even_term
        end

        #
        # 節気を返す
        #
        # @return [Cycle::AbstractSolarTerm] 節気
        #
        def odd_term
          solar_term_selector.odd_term
        end

        #
        # 二十四節気を返す
        #
        # @return [Array<Cyle::AbstractSolarTerm>] 二十四節気
        #
        def solar_terms
          solar_term_selector.solar_terms
        end

        #
        # 二十四節気を追加する
        #
        # @param [SolarTerm] term 二十四節気
        #
        def add_term(term:)
          solar_term_selector.add_term(term: term)
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

        #
        # 月の終了日を返す
        #
        # @return [Western::Calendar] 月の終了日
        #
        def last_date
          return Western::Calendar.new if western_date.invalid?

          western_date.clone + days - 1
        end

        #
        # 範囲内か
        #
        # @param [Western::Calendar] date 日付
        #
        # @return [True] 範囲内
        # @return [False] 範囲外
        #
        def include?(date:)
          return false if invalid?

          DateComparer.include?(
            date: date, start_date: western_date, last_date: last_date
          )
        end

        #
        # 範囲内か
        #
        # @param [Japan::Calendar] date 日付
        #
        # @return [True] 範囲内
        # @return [False] 範囲外
        #
        def include_by_japan_date?(date:)
          return false if invalid?

          DateComparer.include_by_japan_date?(
            date: date, gengou: gengou, month_label: month_label
          )
        end

        #
        # 二十四節気を正しい順序にソートする
        #
        def sort_solar_terms
          solar_term_selector.sort
        end

        #
        # 大余に対応する二十四節気
        #
        # @param [Integer] day 大余
        #
        # @return [Cycle::AbstractSolarTerm] 二十四節気
        #
        def solar_term_by_day(day:)
          solar_term_selector.solar_term_by_day(day: day, meta: meta)
        end

        #
        # メタ情報を再設定する
        #
        # @param [Month] last 前月
        #
        def reset_meta(last: Month.new)
          @meta = MetaCollector.get(
            before_month: last,
            current_month: self
          )
        end
      end
    end
  end
end
