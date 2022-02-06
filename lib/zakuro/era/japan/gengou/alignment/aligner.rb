# frozen_string_literal: true

require_relative '../../../western/calendar'

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
        # @return [Integer] 行数
        LINE_SIZE = 2

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
        # 元号を追加する
        #
        # @param [Gengou] gengou 元号
        #
        def push_gengou(gengou:)
          rest = [
            LinearGengou.new(gengou: gengou)
          ]
          @lines.each do |line|
            rest = line.push(gengou: rest)
          end
        end
      end
    end
  end
end
