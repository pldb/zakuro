# frozen_string_literal: true

require_relative './alignment/aligner'

require_relative './resource'

# :nodoc:
module Zakuro
  # :nodoc:
  module Japan
    # :nodoc:
    module Gengou
      #
      # Alignment 整列
      #
      module Alignment
        # @return [Integer] 1行目元号
        FIRST_LINE = Aligner::FIRST_LINE

        # @return [Integer] 2行目元号
        SECOND_LINE = Aligner::SECOND_LINE

        # @return [Aligner] 整列結果
        SUMMARY = Aligner.new(resources: Resource::LIST)

        #
        # 指定した範囲内の元号を取得する
        #
        # @param [Integer] line 行
        # @param [Western::Calendar] start_date 開始日
        # @param [Western::Calendar] last_date 終了日
        #
        # @return [Array<LinearGengou>] 元号
        #
        def self.get(line: FIRST_LINE,
                     start_date: Western::Calendar.new, last_date: Western::Calendar.new)

          SUMMARY.get(line: line, start_date: start_date, last_date: last_date)
        end
      end
    end
  end
end
