# frozen_string_literal: true

# :nodoc:
module Zakuro
  # :nodoc:
  module Calculation
    # :nodoc:
    module Type
      #
      # OldFloat 浮動小数点数（古代）
      #
      # @note 四捨五入は常に絶対値に対して行う
      #   * value.negative? ? value.ceil : value.floor
      #   * 絶対値だけを取り出すことで、四捨五入を平易にする
      #
      class OldFloat
        # @return [Integer] 符号
        attr_reader :sign
        # @return [Float] 絶対値
        attr_reader :abs

        #
        # 初期化
        #
        # @param [Float] value 符号つき浮動小数点数
        #
        def initialize(value)
          @sign = value.negative? ? -1 : 1
          @abs = @sign * value
        end

        #
        # 四捨五入する
        #
        def floor!
          @abs = floor
        end

        #
        # 四捨五入する（非破壊的）
        #
        # @return [Float] 絶対値
        #
        def floor
          abs.floor
        end

        #
        # 符号つき浮動小数点数を取得する
        #
        # @return [Float] 符号つき浮動小数点数
        #
        def get
          sign * abs
        end

        #
        # 負数かどうか
        #
        # @return [True] 負数
        # @return [False] 正数
        #
        def negative?
          @sign == -1
        end
      end
    end
  end
end
