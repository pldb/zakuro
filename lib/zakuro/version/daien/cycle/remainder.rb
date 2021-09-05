# frozen_string_literal: true

require_relative '../../../calculation/cycle/abstract_remainder'

require_relative '../const/number'

# :nodoc:
module Zakuro
  # :nodoc:
  module Daien
    # :nodoc:
    module Cycle
      #
      # Remainder 時刻情報（大余小余）
      #
      class Remainder < Calculation::Cycle::AbstractRemainder
        # 『歴代天文律暦等志彙編　七』中華書房 p.2056
        # 「象統;二十四」「其秒盈象統,従小餘」
        # 上記は舊唐志の記述だが、新唐志（p.2218）でも同様であることを確認した
        # @return [Integer] 分（1分=24秒）
        MINUTE = 24

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
        # @param [String] form フォーマット（大余、小余、秒それぞれを%dで指定する）
        #
        # @return [String] フォーマットした結果
        #
        def format(form: '%d-%d')
          return '' if invalid?

          super(form, @day, @minute, @second)
        end
      end

      #
      # LunarRemainder 月の位相計算向け時刻情報（大余小余）
      #
      class LunarRemainder < Calculation::Cycle::AbstractRemainder
        # @return [Integer] 分（1分=80秒）
        MINUTE = 80

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
        # @param [String] form フォーマット（大余、小余、秒それぞれを%dで指定する）
        #
        # @return [String] フォーマットした結果
        #
        def format(form: '%d-%d')
          return '' if invalid?

          super(form, @day, @minute, @second)
        end
      end
    end
  end
end
