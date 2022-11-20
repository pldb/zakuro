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
          # @return [Integer] 理想上の月日数
          IDEAL_MONTH = 30

          # @return [Context::Context] 暦コンテキスト
          attr_reader :context
          # @return [True] 有効
          # @return [False] 無効
          attr_reader :valid
          # @return [Cycle::AbstractRemainder] 「有没之気」判定
          attr_reader :limit
          # @return [Cycle::AbstractRemainder] 経朔
          attr_reader :average_remainder
          # @return [Class] 滅余クラス
          attr_reader :remainder_class

          #
          # 初期化
          #
          # @param [Context::Context] context 暦コンテキスト
          # @param [Cycle::AbstractRemainder] average_remainder 経朔
          #
          def initialize(context:, average_remainder:)
            parameter = context.resolver.vanished_date_parameter.new
            @context = context
            @valid = parameter.valid
            @limit = parameter.limit
            @average_remainder = average_remainder
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
            minute_later = average_remainder.class.new(
              day: 0, minute: average_remainder.minute, second: average_remainder.second
            )
            minute_later < limit
          end

          #
          # 「滅余」を返す
          #
          # @return [Cycle::AbstractRemainder] 滅余
          #
          def get
            # 経朔の小余 * 30
            minute = remainder_class.new(day: 0, minute: IDEAL_MONTH * average_remainder.minute, second: 0)
            day = remainder_class.new(day: average_remainder.day, minute: 0, second: 0)

            minute.add(day)
          end
        end
      end
    end
  end
end
