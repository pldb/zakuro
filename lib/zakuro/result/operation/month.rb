# frozen_string_literal: true

require_relative './month/history'

# :nodoc:
module Zakuro
  #
  # Result 演算結果
  #
  module Result
    #
    # 運用情報
    #
    class Operation
      #
      # Month 運用情報（月）
      #
      class Month
        # @return [History] 月別履歴情報（当月）
        attr_reader :current
        # @return [History] 月別履歴情報（影響を与えた月）
        attr_reader :parent

        def initialize(current: History.new, parent: History.new)
          @current = current
          @parent = parent
        end
      end
    end
  end
end
