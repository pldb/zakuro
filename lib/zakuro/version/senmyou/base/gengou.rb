# frozen_string_literal: true

require_relative './era'

# :nodoc:
module Zakuro
  # :nodoc:
  module Senmyou
    #
    # Gengou 元号
    #
    class Gengou
      # @return [Japan::Gengou] 元号（1行目）
      attr_reader :first_line
      # @return [Japan::Gengou] 元号（2行目）
      attr_reader :second_line
      # @return [Integer] 年の日数
      attr_reader :total_days
      # @return [Western::Calendar] 元号内での最過去日（2つの元号が重複した場合はより過去の日となる）/ 次の元号年の年初（1月1日）
      attr_reader :first_date

      #
      # 初期化
      #
      # @note (see #next_year)
      #   次年度以降の first_date はその元号の1年目の最初の日を設定する
      #
      # @param [Western::Calendar] date 対象日
      # @param [Japan::Gengou] first_line 元号（1行目）
      #   * 計算結果を持ち越すため、自クラスでの初期化時のみ使用する
      # @param [Japan::Gengou] second_line 元号（2行目）
      #   * 計算結果を持ち越すため、自クラスでの初期化時のみ使用する
      #
      def initialize(date: Era::START_DATE, first_line: Japan::Gengou.new,
                     second_line: Japan::Gengou.new)
        @total_days = 0

        if Gengou.first_called?(first_line: first_line,
                                second_line: second_line)
          initialize_first_called(date: date)
          return
        end
        @first_line = first_line
        @second_line = second_line
        @first_date = date.clone
      end

      #
      # 初期化で最初の呼び出しかどうかを判定する
      #
      # @note 以下の前提がある
      #   * 初回呼び出しでは first_line/second_line を引数に指定しない（情報がないのでできない）
      #   * 次回以降の呼び出し（ next_year ） では計算済みのfirst_line/second_lineを渡す
      #
      # @param [Japan::Gengou] first_line 元号（1行目）
      # @param [Japan::Gengou] second_line 元号（2行目）
      #
      # @return [True] 初回呼び出し
      # @return [False] 次回以降の呼び出し
      #
      def self.first_called?(first_line:, second_line:)
        first_line.invalid? && second_line.invalid?
      end

      #
      # 初期化（初回呼び出し）
      #
      # @param [Western::Calendar] date 日付
      #
      def initialize_first_called(date:)
        raise ArgumentError, 'invalid senmyou date' unless Era.include?(date: date)

        # 2つの元号が重なった時に、元号の開始日が最も古い日
        @first_date = choise_oldest_gengou_date(
          first_line: Era.first(start_date: date),
          second_line: Era.second(start_date: date)
        )
        @first_line = Era.first(start_date: @first_date)
        @second_line = Era.second(start_date: @first_date)

        nil
      end

      #
      # 十干十二支を取得する
      #
      # @return [String] 十干十二支
      #
      def zodiac_name
        Era.zodiac_name(western_year: @first_date.year)
      end

      #
      # 年の日数に加算する
      #
      # @param [Integer] days 日数
      #
      def add_days(days: 0)
        @total_days += days

        nil
      end

      #
      # 次の年にする
      #
      # @return [Gengou] 次の年の元号
      #
      def next_year
        next_date = @first_date.clone + @total_days
        first = Gengou.next_first_line(gengou: @first_line, date: next_date)
        second = Gengou.next_second_line(gengou: @second_line, date: next_date)

        first, second = Gengou.swap_two_gengou_on_last_period(first: first,
                                                              second: second)

        Gengou.new(date: next_date,
                   first_line: first, second_line: second)
      end

      #
      # 南北朝の終末処理をする
      #
      # @note 特別対応。北朝の "明徳" を4年から主流にする（2行目から1行目にする）
      #
      # @param [Japan::Gengou] first 元号（1行目）
      # @param [Japan::Gengou] second 元号（2行目）
      #
      # @return [Array<Japan::Gengou>] 元号（1行目）, 元号（2行目）
      #
      def self.swap_two_gengou_on_last_period(first:, second:)
        if first.name == second.name
          first = second
          second = Japan::Gengou.new
        end
        [first, second]
      end

      #
      # 元号（1行目）を次の年にする
      #
      # @param [Japan::Gengou] gengou 元号（1行目）
      # @param [Western::Calendar] date 日付
      #
      # @return [Japan::Gengou] 翌年の元号（1行目）
      #
      def self.next_first_line(gengou:, date:)
        return Era.first(start_date: date) unless gengou.include?(date: date)

        next_gengou = gengou.clone
        next_gengou.next_year
        next_gengou
      end

      #
      # 元号（2行目）を次の年にする
      #
      # @param [Japan::Gengou] gengou 元号（2行目）
      # @param [Western::Calendar] date 日付
      #
      # @return [Japan::Gengou] 翌年の元号（2行目）
      #
      def self.next_second_line(gengou:, date:)
        return Era.second(start_date: date) unless gengou.include?(date: date)

        next_gengou = gengou.clone
        next_gengou.next_year
        next_gengou
      end

      #
      # 元号内での最過去日を求める
      # @note 2つの元号が重複した場合はより過去の日となる
      #
      # @param [Japan::Gengou] first_line 元号（1行目）
      # @param [Japan::Gengou] second_line 元号（2行目）
      #
      # @return [Western::Calendar] 最過去日
      #
      def choise_oldest_gengou_date(first_line: @first_line,
                                    second_line: @second_line)
        first_start_date = first_line.start_date.clone
        second_start_date = second_line.start_date.clone
        # first_lineは常に存在する
        return first_start_date if second_line.invalid?

        first_start_date < second_start_date ? first_start_date : second_start_date
      end

      #
      # 元号内での最未来日を求める
      # @note 2つの元号が重複した場合はより未来の日となる
      #
      # @param [Japan::Gengou] first_line 元号（1行目）
      # @param [Japan::Gengou] second_line 元号（2行目）
      #
      # @return [Western::Calendar] 最未来日
      #
      def choise_newest_gengou_date(first_line: @first_line,
                                    second_line: @second_line)
        first_end_date = first_line.end_date.clone
        second_end_date = second_line.end_date.clone
        # first_lineは常に存在する
        return first_end_date if second_line.invalid?

        first_end_date > second_end_date ? first_end_date : second_end_date
      end
    end
  end
end
