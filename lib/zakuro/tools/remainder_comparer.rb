# frozen_string_literal: true

require_relative '../output/logger'

require_relative '../calculation/cycle/abstract_remainder'

# TODO: Tools -> Tool

# :nodoc:
module Zakuro
  #
  # Tools 汎用メソッド群
  #
  module Tools
    #
    # RemainderComparer 大余小余比較
    #
    module RemainderComparer
      # @return [Output::Logger] ロガー
      LOGGER = Output::Logger.new(location: 'RemainderComparer')

      class << self
        #
        # 大余を基準に範囲チェックをする
        #
        # 次のパターンで用いる
        # 1. 月内（当月朔日から当月末日（来月朔日の前日）の間）に二十四節気があるか
        #   * target: 二十四節気
        #   * start: 当月朔日
        #   * last: 次月朔日
        # 2. ある二十四節気に対象の日があるか
        #   * target: 対象の日
        #   * start: 二十四節気
        #   * last: 次の二十四節気
        #
        # @param [Calcuration::Cycle::AbstractRemainder] target 対象日
        # @param [Calcuration::Cycle::AbstractRemainder] start 範囲開始
        # @param [Calcuration::Cycle::AbstractRemainder] last 範囲終了
        #
        # @return [True] 対象日がある
        # @return [False] 対象日がない
        #
        def in_range?(target:, start:, last:)
          # 『日本暦日便覧』では下記5日を没日ありとしている
          #  これは二十四節気の小余と秒が0の場合に限って、範囲を翌日にずらすことを指している
          #
          # * 貞観12年7月18日
          # * 天喜5年3月11日
          # * 寛元1年11月4日
          # * 永享2年7月26日
          # * 元和3年3月19日
          #
          last_day = last.only_day? ? last.day + 1 : last.day
          in_range_day?(target: target.day, start: start.day, last: last_day)
        end

        #
        # 大余を基準に範囲チェックをする
        #
        # @param [Calcuration::Cycle::AbstractRemainder] target 対象日
        # @param [Calcuration::Cycle::AbstractRemainder] start 範囲開始
        # @param [Integer] limit 大余上限
        #
        # @return [True] 対象日がある
        # @return [False] 対象日がない
        #
        def in_limit?(target:, start:, limit:)
          last_day = start.add_day(limit).day

          in_range_day?(target: target.day, start: start.day, last: last_day)
        end

        private

        #
        # 大余を基準に範囲チェックをする
        #
        # @note 大余60で一巡するため 以下2パターンがある
        #   * start <= last : (二十四節気) >= start && (二十四節気) < last
        #   * start > last  : (二十四節気) >= start || (二十四節気) < last
        #
        # @param [Integer] target 対象日
        # @param [Integer] start 範囲開始
        # @param [Integer] last 範囲終了
        #
        # @return [True] 対象日がある
        # @return [False] 対象日がない
        #
        def in_range_day?(target:, start:, last:)
          start_over = (target >= start)
          last_under = (target < last)

          return start_over && last_under if start <= last

          start_over || last_under
        end
      end
    end
  end
end
