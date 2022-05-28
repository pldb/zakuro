# frozen_string_literal: true

# :nodoc:
module Zakuro
  # :nodoc:
  module Calculation
    # :nodoc:
    module Option
      # :nodoc:
      module DroppedDate
        #
        # AbstractParameter 没日引数
        #
        class AbstractParameter
          # @return [True] 有効
          # @return [False] 無効
          attr_reader :valid
          # @return [Integer] 年
          attr_reader :year
          # @return [Cycle::AbstractRemainder] 「有没之気」判定
          attr_reader :limit
          # @return [Class] 没余クラス
          attr_reader :remainder_class

          #
          # 初期化
          #
          # @param [True, False] valid 有効/無効
          # @param [Integer] year 年
          # @param [Cycle::AbstractRemainder] limit 「有没之気」判定
          # @param [Class] remainder_class 没余クラス
          #
          def initialize(valid: false, year: 0, limit: Cycle::AbstractRemainder.new,
                         remainder_class: Object)
            @valid = valid
            @year = year
            @limit = limit
            @remainder_class = remainder_class
          end
        end
      end
    end
  end
end
