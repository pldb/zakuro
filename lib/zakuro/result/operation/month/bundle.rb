# frozen_string_literal: true

require_relative './history'

# :nodoc:
module Zakuro
  #
  # Result 演算結果
  #
  module Result
    #
    # 運用情報
    #
    module Operation
      #
      # Month 運用情報（月）
      #
      module Month
        #
        # Bundle 月履歴集約情報
        #
        class Bundle
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
end
