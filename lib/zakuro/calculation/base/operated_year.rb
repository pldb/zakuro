# frozen_string_literal: true

require_relative './year'

# :nodoc:
module Zakuro
  # :nodoc:
  module Calculation
    # :nodoc:
    module Base
      #
      # OperatedYear 年（運用）
      #
      class OperatedYear < Year
        #
        # 初期化
        #
        # @param [Array<OperatedMonth>] months 年内の全ての月
        # @param [Integer] total_days 年の日数
        #
        def initialize(months: [], total_days: 0)
          super(months: months, total_days: total_days)
        end

        #
        # 引数を月の先頭に加える
        #
        # @param [Array<OperatedMonth>] first_months 先頭の月
        #
        def unshift_months(first_months)
          # 逆順で加える
          first_months.reverse_each do |month|
            month.moved
            months.unshift(month)
          end
        end

        #
        # 引数を月の最後に加える
        #
        # @param [Array<OperatedMonth>] last_months 最後の月
        #
        def push_months(last_months)
          last_months.each do |month|
            month.moved
            months.push(month)
          end
        end

        #
        # 昨年に属する月を取り出す
        #
        # @return [Array<OperatedMonth>] 昨年に属する月
        #
        def shift_last_year_months
          result, @months = OperatedYear.devide_with(method: :last_year?, arr: months)

          result
        end

        #
        # 来年に属する月を取り出す
        #
        # @return [Array<OperatedMonth>] 来年に属する月
        #
        def pop_next_year_months
          result, @months = OperatedYear.devide_with(method: :next_year?, arr: months)

          result
        end

        # :reek:TooManyStatements { max_statements: 8 }

        #
        # メソッドで配列を分離する
        #
        # @param [Symbol] method 条件メソッド
        # @param [Array<Object>] arr 配列
        #
        # @return [Array<Object>] 一致配列
        # @return [Array<Object>] 不一致配列
        #
        def self.devide_with(method:, arr: [])
          match = []
          unmatch = []

          arr.each do |item|
            if !item.moved? && item.send(method)
              match.push(item)
              next
            end

            unmatch.push(item)
          end

          [match, unmatch]
        end
      end
    end
  end
end
