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
      module Validation
        #
        # SwitchDate 切替日（運用/計算）
        #
        class SwitchDate
          # @return [Hash<String, Strin>] 計算値
          attr_reader :calculation
          # @return [Hash<String, Strin>] 運用値
          attr_reader :operation

          #
          # 初期化
          #
          # @param [Hash<String, Strin>] hash 切替日（運用/計算）
          #
          def initialize(hash:)
            @calculation = hash['calculation']
            @operation = hash['operation']
          end

          #
          # 検証する
          #
          # @return [Array<String>] 不正メッセージ
          #
          def validate
            failed = []

            failed |= validate_calculation_date

            failed |= validate_operation_date

            failed
          end

          private

          #
          # 日（計算値）を検証する
          #
          # @return [Array<String>] 不正メッセージ
          #
          def validate_calculation_date
            Both::Date.new(hash: calculation, optional: true).validate
          end

          #
          # 日（運用値）を検証する
          #
          # @return [Array<String>] 不正メッセージ
          #
          def validate_operation_date
            Both::Date.new(hash: operation).validate
          end
        end
      end
    end
  end
end
