# frozen_string_literal: true

require_relative './era'
require_relative './multi_gengou'

require_relative '../../../era/japan'

# :nodoc:
module Zakuro
  # :nodoc:
  module Senmyou
    # FIXME: 宣明暦に依存しない共通処理にする

    #
    # MultiGengouRoller 改元処理
    #
    class MultiGengouRoller
      # @return [MultiGengou] 複数元号
      attr_reader :multi_gengou
      # @return [Western::Calendar] 元旦（元号が2つある場合は再過去の日付になる）
      attr_reader :oldest_date
      # @return [Western::Calendar] 元号内での最未来日（元号が2つある場合は再未来の日付になる）
      attr_reader :newest_date
      # @return [Western::Calendar] 現在日
      attr_reader :current_date

      def initialize(start_date: Era::START_DATE, end_date: Western::Calendar.new)
        end_date = start_date if end_date.invalid?

        @oldest_date = MultiGengouRoller.choise_oldest_gengou_date(
          first_line: Era.first(start_date: start_date),
          second_line: Era.second(start_date: start_date)
        )
        @current_date = @oldest_date.clone
        @newest_date = MultiGengouRoller.choise_newest_gengou_date(
          first_line: Era.first(start_date: end_date),
          second_line: Era.second(start_date: end_date)
        )

        @multi_gengou = MultiGengou.new(
          first_line: current_first_line,
          second_line: current_second_line,
          new_year_date: @oldest_date
        )
      end

      #
      # 現在日付を未来に進める
      #
      # @param [<Type>] days <description>
      #
      # @return [<Type>] <description>
      #
      def next(days: 0)
        @current_date += days
      end

      #
      # 現在日から元号（1行目）を取得する
      #
      # @return [Japan::Gengou] 元号（1行目）
      #
      def current_first_line
        MultiGengouRoller.first_line(date: @current_date)
      end

      #
      # 現在日から元号（2行目）を取得する
      #
      # @return [Japan::Gengou] 元号（2行目）
      #
      def current_second_line
        MultiGengouRoller.second_line(date: @current_date)
      end

      #
      # 改元する
      #
      # @return [MultiGengou] 複数元号
      #
      def transfer
        MultiGengouRoller.transfer(multi_gengou: @multi_gengou, date: @current_date)
      end

      #
      # 次年にする
      #
      # @return [MultiGengou] 複数元号
      #
      def next_year
        @multi_gengou.next_year
      end

      #
      # 元号（1行目）を取得する
      #
      # @return [Japan::Gengou] 元号（1行目）
      #
      def self.first_line(date: Western::Calender.new)
        Era.first(start_date: date)
      end

      #
      # 元号（2行目）を取得する
      #
      # @return [Japan::Gengou] 元号（2行目）
      #
      def self.second_line(date: Western::Calender.new)
        Era.second(start_date: date)
      end

      #
      # 改元する
      #
      # @param [MultiGengou] multi_gengou 複数元号
      # @param [Western::Calendar] date 対象日
      #
      # @return [MultiGengou] 改元済み複数元号
      #
      def self.transfer(multi_gengou:, date:)
        multi_gengou.transfer(
          first_line: first_line(date: date),
          second_line: second_line(date: date)
        )

        multi_gengou
      end

      #
      # 現在日からみて直近の未来に対する元号の切替前日を求める
      # @note 2つの元号が重複した場合はより過去の日となる
      #
      # @param [Japan::Gengou] first_line 元号（1行目）
      # @param [Japan::Gengou] second_line 元号（2行目）
      #
      # @return [Western::Calendar] 元号の切替前日
      #
      def choise_nearest_end_date
        condition = lambda do |first_date, second_date|
          first_date < second_date ? first_date : second_date
        end

        second_line = current_second_line

        MultiGengouRoller.choise_date(condition: condition, second_line: second_line,
                                      first_date: current_first_line.end_date.clone,
                                      second_date: second_line.end_date.clone)
      end

      #
      # 最過去の元旦を求める
      # @note 2つの元号が重複した場合はより過去の日となる
      #
      # @param [Japan::Gengou] first_line 元号（1行目）
      # @param [Japan::Gengou] second_line 元号（2行目）
      #
      # @return [Western::Calendar] 最過去の元旦
      #
      def self.choise_oldest_gengou_date(first_line:, second_line:)
        condition = lambda do |first_date, second_date|
          first_date < second_date ? first_date : second_date
        end
        choise_date(condition: condition, second_line: second_line,
                    first_date: first_line.new_year_date.clone,
                    second_date: second_line.new_year_date.clone)
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
      def self.choise_newest_gengou_date(first_line:, second_line:)
        condition = lambda do |first_date, second_date|
          first_date > second_date ? first_date : second_date
        end
        choise_date(condition: condition, second_line: second_line,
                    first_date: first_line.end_date.clone, second_date: second_line.end_date.clone)
      end

      # :reek:LongParameterList {max_params: 4}

      #
      # 条件を元に日付を求める
      #
      # @param [Proc] condition 比較条件
      # @param [Japan::Gengou] second_line 元号（2行目）
      # @param [Western::Calendar] first_date 比較対象（1行目）
      # @param [Western::Calendar] second_date 比較対象（2行目）
      #
      # @return [Western::Calendar] 比較結果
      #
      def self.choise_date(condition:, second_line:, first_date:, second_date:)
        # first_lineは常に存在する
        return first_date if second_line.invalid?

        condition.call(first_date, second_date)
      end
    end
  end
end
