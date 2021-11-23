# frozen_string_literal: true

require_relative '../../era/western/calendar'

# :nodoc:
module Zakuro
  # :nodoc:
  module Calculation
    # :nodoc:
    module Base
      #
      # Gengou 元号
      #
      class Gengou
        # @return [Array<LinearGengou>] 1行目元号
        attr_reader :first_line
        # @return [Array<LinearGengou>] 2行目元号
        attr_reader :second_line

        #
        # 初期化
        #
        # @param [Array<LinearGengou>] first_line 1行目元号
        # @param [Array<LinearGengou>] second_line 2行目元号
        #
        def initialize(first_line: [], second_line: [])
          @first_line = first_line
          @second_line = second_line
        end

        #
        # 1行目元号を取得する
        #
        # @param [Western::Calendar] date 西暦日
        #
        # @return [LinearGengou] 1行目元号
        #
        def match_first_line(date: Western::Calendar)
          @first_line.each do |line|
            return line.clone if line.include?(date: date)
          end

          LinearGengou.new
        end

        #
        # 2行目元号を取得する
        #
        # @param [Western::Calendar] date 西暦日
        #
        # @return [LinearGengou] 2行目元号
        #
        def match_second_line(date: Western::Calendar)
          @second_line.each do |line|
            return line.clone if line.include?(date: date)
          end

          LinearGengou.new
        end
      end
    end
  end
end
