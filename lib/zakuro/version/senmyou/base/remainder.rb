# frozen_string_literal: true

require_relative '../../../cycle/abstract_remainder'

# :nodoc:
module Zakuro
  # :nodoc:
  module Senmyou
    #
    # Remainder 宣明暦の時刻情報（大余小余）
    #
    # * 「15日1835分5秒」のような形式で表される
    # * 分は8400で一日に繰り上げる
    # * 秒は基本的に1/8分で、8秒で1分に繰り上げる。ただし、月補正値は1分に100秒とするなど基数の変更がありえる
    # * 十干十二支（60日）を上限とした「日時分秒」の情報で、日付（date）/時刻（time）と部分的に重なる概念
    #
    class Remainder < Cycle::AbstractRemainder
      # @return [Integer] 統法（1日=8400分）
      DAY = 8400
      # @return [Integer] 分（1分=8秒）
      MINUTE = 8

      #
      # 初期化
      #
      # @param [Integer] day 大余（"日"に相当）
      # @param [Integer] minute 小余（"分"に相当）
      # @param [Integer] second 秒
      # @param [Integer] total 繰り上げなしの小余
      #
      def initialize(day: -1, minute: -1, second: -1, total: -1)
        super(day: day, minute: minute, second: second, total: total,
              base_day: DAY, base_mitune: MINUTE)
      end
    end

    #
    # LunarRemainder 月の位相計算向け時刻情報（大余小余）
    #
    class LunarRemainder < Cycle::AbstractRemainder
      # @return [Integer] 統法（1日=8400分）
      DAY = 8400
      # @return [Integer] 分（1分=100秒）
      MINUTE = 100

      #
      # 初期化
      #
      # @param [Integer] day 大余（"日"に相当）
      # @param [Integer] minute 小余（"分"に相当）
      # @param [Integer] second 秒
      # @param [Integer] total 繰り上げなしの小余
      #
      def initialize(day: -1, minute: -1, second: -1, total: -1)
        super(day: day, minute: minute, second: second, total: total,
              base_day: DAY, base_mitune: MINUTE)
      end
    end
  end
end
