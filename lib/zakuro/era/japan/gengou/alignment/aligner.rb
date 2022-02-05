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
        # @return [Array<Line>] 行元号
        attr_reader :lines

        #
        # 初期化
        #
        # @param [Array<Parser] resources 元号解析結果
        #
        def initialize(resources: [])
          @lines = []

          save(resources: resources)
        end

        def save(resources: [])
          resources.each do |resource|
            # TODO: make
          end
        end

        def push(resouce:)
          # TODO: make
        end
      end
    end
  end
end
