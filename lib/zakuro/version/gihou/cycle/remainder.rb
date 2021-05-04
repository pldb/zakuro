# frozen_string_literal: true

require_relative '../../../calculation/cycle/abstract_remainder'

# :nodoc:
module Zakuro
  # :nodoc:
  module Gihou
    # :nodoc:
    module Cycle
      #
      # Remainder 儀鳳暦の時刻情報（大余小余）
      #
      # * 「15日1835分5秒」のような形式で表される
      # * 分は1340で一日に繰り上げる
      # * 秒は基本的に1/6分で、6秒で1分に繰り上げる。ただし、月補正値は1分に100秒とするなど基数の変更がありえる
      # * 十干十二支（60日）を上限とした「日時分秒」の情報で、日付（date）/時刻（time）と部分的に重なる概念
      #
      class Remainder < Calculation::Cycle::AbstractRemainder
        # @return [Integer] 総法（1日=1340分）
        DAY = 1340
        # @return [Integer] 分（1分=6秒）
        MINUTE = 6

        #
        # 初期化
        #
        # @param [Integer] day 大余（"日"に相当）
        # @param [Integer] minute 小余（"分"に相当）
        # @param [Integer] second 秒
        # @param [Integer] total 繰り上げなしの小余
        #
        def initialize(day: -1, minute: -1, second: -1, total: -1)
          super(base_day: DAY, base_mitune: MINUTE,
                day: day, minute: minute, second: second, total: total)
        end
      end

      #
      # LunarRemainder 月の位相計算向け時刻情報（大余小余）
      #
      class LunarRemainder < Calculation::Cycle::AbstractRemainder
        # @return [Integer] 総法（1日=1340分）
        DAY = 1340
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
          super(base_day: DAY, base_mitune: MINUTE,
                day: day, minute: minute, second: second, total: total)
        end
      end
    end
  end
end
