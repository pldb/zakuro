# frozen_string_literal: true

# TODO: moduleでMonthly とする（全暦むけに共通化したあと）

# :nodoc:
module Zakuro
  # :nodoc:
  module Senmyou
    #
    # MonthLabel 月表示情報
    #
    class MonthLabel
      # @return [True] 大の月（30日）
      # @return [False] 小の月（29日）
      attr_reader :is_many_days
      # @return [Integer] 月（xx月のxx）
      attr_reader :number
      # @return [True] 閏月
      # @return [False] 平月
      attr_reader :leaped

      def initialize(number: -1, is_many_days: false, leaped: false)
        # 月の大小
        @is_many_days = is_many_days
        # 月
        @number = number
        # 閏
        @leaped = leaped
      end

      #
      # 月の日数を返す
      #
      # @return [Integer] 日数
      #
      def days
        @is_many_days ? 30 : 29
      end

      #
      # 月の名前（大小）を返す
      #
      # @return [String] 月の名前（大小）
      #
      def days_name
        @is_many_days ? '大' : '小'
      end

      #
      # 一ヶ月戻す
      #
      # @return [True] 昨年
      # @return [False] 今年
      #
      def back_to_last_month
        @number -= 1

        return false if @number.positive?

        @number = 12

        true
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
        @number == other.number && @leaped == other.leaped
      end
    end
  end
end
