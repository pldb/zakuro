# frozen_string_literal: true

require_relative '../../../calculation/cycle/abstract_remainder'

require_relative '../const/number'

# :nodoc:
module Zakuro
  # :nodoc:
  module Genka
    # :nodoc:
    module Cycle
      #
      # Remainder 時刻情報（大余小余）
      #
      class Remainder < Calculation::Cycle::AbstractRemainder
        # @return [Integer] 分（1分=-秒）
        MINUTE = 0

        #
        # 初期化
        #
        # @param [Integer] day 大余（"日"に相当）
        # @param [Integer] minute 小余（"分"に相当）
        # @param [Integer] second 秒
        # @param [Integer] total 繰り上げなしの小余
        #
        def initialize(day: -1, minute: -1, second: -1, total: -1)
          super(base_day: Const::Number::Cycle::DAY, base_mitune: MINUTE,
                day: day, minute: minute, second: second, total: total)
        end

        #
        # 特定の文字フォーマットにして出力する
        #
        # @return [String] フォーマットした結果
        #
        def format
          decimal = @day + @minute / @base_day.to_f
          super('%.4f', decimal)
        end
      end

      #
      # TermRemainder 時刻情報（大余小余）
      #
      class TermRemainder < Calculation::Cycle::AbstractRemainder
        # @return [Integer] 分（1分=-秒）
        MINUTE = 0

        #
        # 初期化
        #
        # @param [Integer] day 大余（"日"に相当）
        # @param [Integer] minute 小余（"分"に相当）
        # @param [Integer] second 秒
        # @param [Integer] total 繰り上げなしの小余
        #
        def initialize(day: -1, minute: -1, second: -1, total: -1)
          super(base_day: Const::Number::Cycle::TERM_DAY, base_mitune: MINUTE,
                day: day, minute: minute, second: second, total: total)
        end

        #
        # 特定の文字フォーマットにして出力する
        #
        # @return [String] フォーマットした結果
        #
        def format
          decimal = @day + @minute / @base_day.to_f
          super('%.4f', decimal)
        end
      end
    end
  end
end
