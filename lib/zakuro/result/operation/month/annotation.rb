# frozen_string_literal: true

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
        #
        # Annotation 注釈
        #
        class Annotation
          # @return [String] 注釈内容
          attr_reader :description
          # @return [String] 注釈補記
          attr_reader :note

          #
          # 初期化
          #
          # @param [String] description 注釈内容
          # @param [<Type>] note 注釈補記
          #
          def initialize(description:, note:)
            @description = description
            @note = note
          end
        end
      end
    end
  end
end
