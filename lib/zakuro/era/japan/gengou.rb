# frozen_string_literal: true

require_relative '../western/calendar'

require_relative './gengou/alignment'

# :nodoc:
module Zakuro
  #
  # Japan 和暦
  #
  module Japan
    #
    # Gengou 元号
    #
    module Gengou
      # @return [Integer] 1行目
      FIRST_LINE = Alignment::Aligner::FIRST_LINE
      # @return [Integer] 2行目
      SECOND_LINE = Alignment::Aligner::SECOND_LINE

      #
      # 該当行の元号を取得する
      #
      # @param [Integer] line 行番号
      # @param [Western::Calendar] start_date 開始日
      # @param [Western::Calendar] last_date 終了日
      #
      # @return [Array<LinearGengou>] 該当行の元号
      #
      def self.line(line: FIRST_LINE,
                    start_date: Western::Calendar.new, last_date: Western::Calendar.new)
        Alignment.get(
          line: line, start_date: start_date, last_date: last_date
        )
      end

      #
      # 1行目元号を取得する
      #
      # @param [Western::Calendar] start_date 開始日
      # @param [Western::Calendar] last_date 終了日
      #
      # @return [Array<LinearGengou>] 1行目元号
      #
      def self.first_line(start_date: Western::Calendar.new, last_date: Western::Calendar.new)
        Alignment.get(
          line: FIRST_LINE, start_date: start_date, last_date: last_date
        )
      end

      #
      # 2行目元号を取得する
      #
      # @param [Western::Calendar] start_date 開始日
      # @param [Western::Calendar] last_date 終了日
      #
      # @return [Array<LinearGengou>] 2行目元号
      #
      def self.second_line(start_date: Western::Calendar.new, last_date: Western::Calendar.new)
        Alignment.get(
          line: SECOND_LINE, start_date: start_date, last_date: last_date
        )
      end
    end
  end
end
