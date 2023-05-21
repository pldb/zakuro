# frozen_string_literal: true

require_relative '../exception/exception'

require 'date'

# :nodoc:
module Zakuro
  # :nodoc:
  module Condition
    #
    # BasisDate 基準日
    #
    class BasisDate
      # @return [Date] 西暦日
      attr_reader :date

      #
      # 初期化
      #
      # @param [Date, String] date 西暦日/和暦日
      #
      def initialize(date:)
        @date = date
      end

      class << self
        #
        # 検証する
        #
        # @param [Date] date 日付
        #
        # @return [Array<Exception::Case::Preset>] エラープリセット配列
        #
        def validate(date:)
          failed = []
          return failed unless date

          return failed if date.is_a?(Date) || date.is_a?(String)

          failed.push(
            Exception::Case::Preset.new(
              date.class,
              template: Exception::Case::Pattern::INVALID_DATE_TYPE
            )
          )
          failed
        end
      end
    end
  end
end
