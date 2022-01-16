# frozen_string_literal: true

require_relative '../base/gengou'
require_relative './first_day'
require_relative './month_label'

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
        # @return [Context] 暦コンテキスト
        attr_reader :context
        # @return [MonthLabel] 月表示名
        attr_reader :month_label
        # @return [FirstDay] 月初日（朔日）
        attr_reader :first_day
        # @return [Array<SolarTerm>] 二十四節気
        attr_reader :solar_terms
        # @return [Base::Gengou] 元号
        attr_reader :gengou

        #
        # 初期化
        #
        # @param [Context] context 暦コンテキスト
        # @param [MonthLabel] month_label 月表示名
        # @param [FirstDay] first_day 月初日（朔日）
        # @param [Array<SolarTerm>] solar_terms 二十四節気
        # @param [Base::Gengou] gengou 元号
        #
        def initialize(context: Context.new, month_label: MonthLabel.new, first_day: FirstDay.new,
                       solar_terms: [], gengou: Base::Gengou.new)
          @context = context
          @month_label = month_label
          @first_day = first_day
          @solar_terms = solar_terms
          @gengou = gengou
        end

        #
        # 不正か
        #
        # @return [True] 不正
        # @return [False] 不正なし
        #
        def invalid?
          @context.invalid?
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
          @first_day.western_date
        end

        #
        # 月初日の大余小余を返す
        #
        # @return [Remainder] 大余小余
        #
        def remainder
          @first_day.remainder
        end

        #
        # 月の大小を返す
        #
        # @return [True] 大の月（30日）
        # @return [False] 小の月（29日）
        #
        def many_days?
          @month_label.is_many_days
        end

        #
        # 月の日数を返す
        #
        # @return [Integer] 日数
        #
        def days
          @month_label.days
        end

        #
        # 月の名前（大小）を返す
        #
        # @return [String] 月の名前（大小）
        #
        def days_name
          @month_label.days_name
        end

        #
        # 月を返す
        #
        # @return [Integer] 月（xx月のxx）
        #
        def number
          @month_label.number
        end

        #
        # 閏を返す
        #
        # @return [True] 閏月
        # @return [False] 平月
        #
        def leaped?
          @month_label.leaped
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
          @solar_terms.empty?
        end

        #
        # 中気を返す
        #
        # @return [SolarTerm] 中気
        #
        def even_term
          @solar_terms.each do |term|
            return term if term.index.even?
          end

          context.resolver.solar_term.new
        end

        #
        # 節気を返す
        #
        # @return [SolarTerm] 節気
        #
        def odd_term
          @solar_terms.each do |term|
            return term if term.index.odd?
          end

          context.resolver.solar_term.new
        end

        #
        # 二十四節気を追加する
        #
        # @param [SolarTerm] term 二十四節気
        #
        def add_term(term:)
          @solar_terms.push(term)
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

          start_date = western_date
          return false if start_date.invalid?

          return false if date < start_date

          return false if date > last_date

          true
        end
      end
    end
  end
end
