# frozen_string_literal: true

require_relative '../../../western/calendar'

require_relative './line'

# :nodoc:
module Zakuro
  #
  # Japan 和暦
  #
  module Japan
    #
    # Alignment 整列
    #
    module Alignment
      #
      # Aligner 元号整列
      #
      class Aligner
        # @return [Integer] 1行目元号
        FIRST_LINE = 0

        # @return [Integer] 2行目元号
        SECOND_LINE = 1

        # @return [Array<Integer>] 元号リスト
        LINE_INDEXES = [FIRST_LINE, SECOND_LINE].freeze

        # @return [Integer] 行数
        LINE_SIZE = LINE_INDEXES.size

        # @return [Array<Line>] 行元号
        attr_reader :lines

        #
        # 初期化
        #
        # @param [Array<Set>] resources 元号解析結果
        #
        def initialize(resources: [])
          @lines = []
          (1..LINE_SIZE).each do |_index|
            @lines.push(Line.new)
          end

          save(resources: resources)
        end

        #
        # 行元号に追加する
        #
        # @param [Set] set 元号セット
        #
        def push(set:)
          list = set.list
          list.each do |gengou|
            push_gengou(gengou: gengou)
          end
        end

        #
        # 指定した範囲内の元号を取得する
        #
        # @param [Integer] line 行
        # @param [Western::Calendar] start_date 開始日
        # @param [Western::Calendar] last_date 終了日
        #
        # @return [Array<LinearGengou>] 元号
        #
        def get(line:, start_date:, last_date:)
          raise ArgumentError.new, 'invalid line number' unless LINE_INDEXES.include?(line)

          @lines[line].get(start_date: start_date, last_date: last_date)
        end

        private

        #
        # 保存する
        #
        # @param [Array<Set>] resources 元号解析結果
        #
        def save(resources: [])
          resources.each do |set|
            push(set: set)
          end
        end

        #
        # 元号を追加する
        #
        # @param [Gengou] gengou 元号
        #
        def push_gengou(gengou:)
          rest = [
            LinearGengou.new(gengou: gengou)
          ]
          @lines.each do |line|
            rest = line.push(list: rest)
          end
        end
      end
    end
  end
end
