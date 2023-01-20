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
        # Location 没日位置
        #
        class Location
          # @return [Integer] 理想上の年日数
          IDEAL_YEAR = 360

          # @return [Context::Context] 暦コンテキスト
          attr_reader :context
          # @return [True] 有効
          # @return [False] 無効
          attr_reader :valid
          # @return [Cycle::AbstractRemainder] 「有没之気」判定
          attr_reader :limit
          # @return [Integer] 年
          attr_reader :year
          # @return [Cycle::AbstractSolarTerm] 二十四節気
          attr_reader :solar_term
          # @return [Class] 没余クラス
          attr_reader :remainder_class

          #
          # 初期化
          #
          # @param [Context::Context] context 暦コンテキスト
          # @param [Cycle::AbstractSolarTerm] solar_term 二十四節気
          #
          def initialize(context:, solar_term:)
            parameter = context.resolver.dropped_date_parameter.new
            @context = context
            @valid = parameter.valid
            @limit = parameter.limit
            @year = parameter.year
            @remainder_class = parameter.remainder_class
            @solar_term = solar_term
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
          # 没日が存在するか？
          #
          # @return [True] 存在あり
          # @return [False] 存在なし
          #
          def exist?
            !solar_term_remainder.invalid?
          end

          #
          # 「没余」を返す
          #
          # @return [Cycle::AbstractRemainder] 没余
          #
          def get
            # 1. 二十四節気の大余小余を取り出す
            remainder = solar_term_remainder
            # 2. 小余360、秒45（360/8）で乗算する
            total = multiple_ideal_year(remainder: remainder)
            # 3. 上記2と章歳（3068055）の差を求める
            diff = (year - total).abs
            # 4. 上記3を通余で徐算する
            result = remainder_class.new(total: diff)
            # 5. 上記4の商と上記1の大余が没日大余、余りが小余（没余）
            day = remainder_class.new(day: remainder.day, minute: 0, second: 0)

            day.add(result)
          end

          private

          #
          # 二十四節気の大余小余を取得する
          #
          # @return [Type::Optional<Cycle::AbstractRemainder>] 大余小余
          #
          def solar_term_remainder
            solar_term.remainder
          end

          #
          # 理想上の年数を乗算する
          #
          #  宣明暦：小余360、秒45（360/8）で積算する
          #
          # @return [Cycle::AbstractRemainder] 大余小余
          #
          # @return [Integer] 乗算結果
          #
          def multiple_ideal_year(remainder:)
            minute = remainder.minute * IDEAL_YEAR
            second = remainder.second * (IDEAL_YEAR / remainder.base_minute)
            minute + second
          end
        end
      end
    end
  end
end
