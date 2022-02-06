# frozen_string_literal: true

require_relative './linear_gengou'

# :nodoc:
module Zakuro
  # :nodoc:
  module Japan
    # :nodoc:
    module Alignment
      #
      # Line 行
      #
      class Line
        # @return [Array<LinearGengou>] 元号
        attr_reader :list

        #
        # 初期化
        #
        def initialize
          @list = []
        end

        #
        # 追加する
        #
        # @param [Array<LinearGengou>] list 元号
        #
        # @return [Array<LinearGengou>] 未登録元号
        #
        def push(list: [])
          rest = rest(list: list)

          insert(list: list)

          rest
        end

        private

        def rest(list: [])
          result = list.clone

          @list.each do |gengou|
            result = gengou.meet(other: rest)
          end

          result
        end

        def insert(list: [])
          surplus_result = list.clone
          @list.each do |gengou|
            surplus_result = gengou.sub(other: surplus)
          end

          surplus_result.each do |gengou|
            @list.push(gengou: gengou)
          end
        end
      end
    end
  end
end
