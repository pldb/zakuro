# frozen_string_literal: true

require_relative '../output/logger'

require_relative '../calculation/cycle/abstract_remainder'

# :nodoc:
module Zakuro
  #
  # Tools 汎用メソッド群
  #
  module Tools
    # :reek:UncommunicativeVariableName {accept: e}

    #
    # RemainderComparer 大余小余比較
    #
    module RemainderComparer
      LOGGER = Output::Logger.new(location: 'RemainderComparer')

      class << self
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
        # @note 大余60で一巡するため 以下2パターンがある
        #   * start <= last : (二十四節気) >= start && (二十四節気) < last
        #   * start > last  : (二十四節気) >= start || (二十四節気) < last
        #
        # @param [Calcuration::Cycle::AbstractRemainder] target 対象日
        # @param [Calcuration::Cycle::AbstractRemainder] start 範囲開始
        # @param [Calcuration::Cycle::AbstractRemainder] last 範囲終了
        #
        # @return [True] 対象日がある
        # @return [False] 対象日がない
        #
        def in_range?(target:, start:, last:)
          # 大余で比較する
          target_time = target.day
          start_time = start.day
          last_time = last.day
          start_over = (target_time >= start_time)
          last_under = (target_time < last_time)

          return start_over && last_under if start_time <= last_time

          start_over || last_under
        end
      end
    end
  end
end
