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

      class << self
        #
        # 該当行の元号を取得する
        #
        # @param [Integer] line 行番号
        # @param [Western::Calendar] start_date 開始日
        # @param [Western::Calendar] last_date 終了日
        # @param [True, False] operated 運用値設定
        # @param [True, False] restored 運用値から計算値に戻すか
        #
        # @return [Array<LinearGengou>] 該当行の元号
        #
        def line(line: FIRST_LINE,
                 start_date: Western::Calendar.new, last_date: Western::Calendar.new,
                 operated: false, restored: false)
          Alignment.get(
            line: line, start_date: start_date, last_date: last_date, operated: operated,
            restored: restored
          )
        end

        #
        # 該当行の元号を取得する（元号名）
        #
        # @param [Integer] line 行番号
        # @param [String] name 元号名
        # @param [True, False] operated 運用値設定
        # @param [True, False] restored 運用値から計算値に戻すか
        #
        # @return [Array<LinearGengou>] 該当行の元号
        #
        def line_by_name(line: FIRST_LINE, name:, operated: false, restored: false)
          Alignment.get_by_name(line: line, name: name, operated: operated, restored: restored)
        end
      end
    end
  end
end
