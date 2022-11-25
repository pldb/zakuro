# frozen_string_literal: true

# :nodoc:
module Zakuro
  # :nodoc:
  module Calculation
    # :nodoc:
    module Option
      # :nodoc:
      module VanishedDate
        #
        # AbstractParameter 滅日引数
        #
        class AbstractParameter
          # @return [True] 有効
          # @return [False] 無効
          attr_reader :valid
          # @return [Cycle::AbstractRemainder] 「有滅之朔」判定
          attr_reader :limit
          # @return [Class] 滅余クラス
          attr_reader :remainder_class

          #
          # 初期化
          #
          # @param [True, False] valid 有効/無効
          # @param [Cycle::AbstractRemainder] limit 「有滅之朔」判定
          # @param [Class] remainder_class 滅余クラス
          #
          def initialize(valid: false, limit: Cycle::AbstractRemainder.new,
                         remainder_class: Object)
            @valid = valid
            @limit = limit
            @remainder_class = remainder_class
          end
        end
      end
    end
  end
end
