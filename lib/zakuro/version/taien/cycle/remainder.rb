# frozen_string_literal: true

require_relative '../../../calculation/cycle/abstract_remainder'

require_relative '../const/number'

# :nodoc:
module Zakuro
  # :nodoc:
  module Taien
    # :nodoc:
    module Cycle
      #
      # Remainder 宣明暦の時刻情報（大余小余）
      #
      # * 「15日1012分5秒」のような形式で表される
      # * 分は1340で一日に繰り上げる
      # * 秒は基本的に1/6分で、6秒で1分に繰り上げる。ただし、月補正値は1分に100秒とするなど基数の変更がありえる
      # * 十干十二支（60日）を上限とした「日時分秒」の情報で、日付（date）/時刻（time）と部分的に重なる概念
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
      end
    end
  end
end
