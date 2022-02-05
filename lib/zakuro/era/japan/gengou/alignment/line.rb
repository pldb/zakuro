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
        # @param [Gengou] gengou 元号
        #
        # @return [Array<LinearGengou>] 未登録元号
        #
        def add(gengou:)
          # TODO: make
        end
      end
    end
  end
end
