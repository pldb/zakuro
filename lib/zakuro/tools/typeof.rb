# frozen_string_literal: true

require_relative '../calculation/cycle/abstract_remainder'
require_relative '../era/western'

# :nodoc:
module Zakuro
  #
  # Tools 汎用メソッド群
  #
  module Tools
    #
    # Typeof 型判定
    #
    module Typeof
      #
      # 時間を表す型か
      #
      # @param [Object] obj 引数
      #
      # @return [True] 時間型である
      # @return [False] 時間型ではない
      #
      def self.time?(obj:)
        return true if obj.is_a?(Western::Calendar)

        return true if obj.is_a?(Cycle::AbstractRemainder)

        false
      end
    end
  end
end
