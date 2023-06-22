# frozen_string_literal: true

require_relative '../../../western/calendar'
require_relative '../../calendar'
require_relative './both/date'
require_relative './both/year'

# :nodoc:
module Zakuro
  # :nodoc:
  module Japan
    # :nodoc:
    module Type
      # :nodoc:
      module Base
        #
        # SwitchDate 切替日（運用/計算）
        #
        class SwitchDate
          # @return [Both::Date] 計算値
          attr_reader :calculation
          # @return [Both::Date] 運用値
          attr_reader :operation
          # @return [True, False] 運用値
          attr_reader :operated
          # @return [Japan::Calendar] 和暦日
          attr_reader :japan
          # @return [Western::Calendar] 西暦日
          attr_reader :western

          #
          # 初期化
          #
          # @param [Both::Date] calculation 計算値
          # @param [Both::Date] operation 運用値
          # @param [True, False] operated 運用値設定
          #
          def initialize(calculation: Both::Date.new, operation: Both::Date.new, operated: false)
            @calculation = calculation
            @operation = operation
            @operated = operated

            select
          end

          #
          # 不正か
          #
          # @return [True] 不正
          # @return [False] 不正なし
          #
          def invalid?
            japan.invalid? || western.invalid?
          end

          private

          def select
            @japan = operation.japan
            @western = operation.western

            return if operated

            calc_japan = calculation.japan
            calc_western = calculation.western

            @japan = calc_japan unless calc_japan.invalid?
            @western = calc_western unless calc_western.invalid?
          end
        end
      end
    end
  end
end
