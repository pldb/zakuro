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
        # Location 滅日位置
        #
        class Location
          # @return [Integer] 理想上の年日数
          IDEAL_MONTH = 360

          # @return [Context::Context] 暦コンテキスト
          attr_reader :context
          # @return [True] 有効
          # @return [False] 無効
          attr_reader :valid
          # @return [Cycle::AbstractRemainder] 「有没之気」判定
          attr_reader :limit
          # @return [Cycle::AbstractRemainder] 経朔
          attr_reader :abstract_remainder
          # @return [Class] 滅余クラス
          attr_reader :remainder_class

          #
          # 初期化
          #
          # @param [Context::Context] context 暦コンテキスト
          # @param [Cycle::AbstractRemainder] abstract_remainder 経朔
          #
          def initialize(context:, abstract_remainder:)
            parameter = context.resolver.dropped_date_parameter.new
            @context = context
            @valid = parameter.valid
            @limit = parameter.limit
            @abstract_remainder = abstract_remainder
            @remainder_class = parameter.remainder_class
          end

          #
          # 不正か
          #
          # @return [True] 不正
          # @return [False] 不正なし
          #
          def invalid?
            !@valid
          end

          #
          # 滅日が存在するか？
          #
          # @return [True] 存在あり
          # @return [False] 存在なし
          #
          def exist?
            # TODO: make
          end

          #
          # 「滅余」を返す
          #
          # @return [Cycle::AbstractRemainder] 滅余
          #
          def get
            # TODO: make
          end
        end
      end
    end
  end
end
