# frozen_string_literal: true

require_relative '../../cycle/zodiac'

# :nodoc:
module Zakuro
  # :nodoc:
  module Senmyou
    #
    # Year 年
    #
    class Year
      # @return [Gengou] 元号
      attr_reader :multi_gengou
      # @return [Array<Month>] 年内の全ての月
      attr_reader :months
      # @return [Integer] 年の日数
      attr_reader :total_days
      # @return [Western::Calendar] 元旦
      attr_reader :new_year_date

      #
      # 初期化
      #
      # @param [Gengou] multi_gengou 元号
      #
      def initialize(multi_gengou: MultiGengou.new, new_year_date: Western::Calendar.new,
                     months: [], total_days: 0)
        @multi_gengou = multi_gengou
        @months = months
        @new_year_date = new_year_date
        @total_days = total_days
      end

      #
      # 年の日数を確定する
      #
      def commit
        @total_days = 0
        months.each do |month|
          @total_days += month.days
        end

        self
      end

      #
      # 次年にする
      #
      # @param [Japan::Gengou] first_line 元号（1行目）
      # @param [Japan::Gengou] second_line 元号（2行目）
      #
      # @return [MultiGengou] 自身
      #
      def next_year
        @multi_gengou.next_year

        @new_year_date += @total_days
        @total_days = 0

        self
      end

      #
      # 十干十二支を取得する
      #
      # @return [String] 十干十二支
      #
      def zodiac_name
        Cycle::Zodiac.year_name(western_year: @new_year_date.year)
      end

      #
      # 月を追加する
      #
      # @param [Month] month 月
      #
      def push(month:)
        return if duplicated?(month: month)

        @months.push(month)

        nil
      end

      #
      # すでに登録済みの月と重複しているか判定する
      #
      # @note 昨年11月1日から今年1月1日の前日までで、去年データと重複する場合は登録スキップする
      #
      # @param [Month] month 月
      #
      # @return [True] 重複している
      # @return [True] 重複していない
      #
      def duplicated?(month:)
        @months.each do |existed|
          return true if existed.same?(other: month)
        end
        false
      end
    end
  end
end
