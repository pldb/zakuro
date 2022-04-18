# frozen_string_literal: true

require_relative './template'

# :nodoc:
module Zakuro
  # :nodoc:
  module Exception
    # :nodoc:
    module Case
      #
      # Pattern 原因パターン
      #
      module Pattern
        INTERNAL_ERROR = Template.new(
          code: 'ERROR_0001',
          message: '致命的なエラーです。',
          length: 0
        )

        INVALID_DATE = Template.new(
          code: 'ERROR_0002',
          message: '一日検索の日付指定が誤っています。',
          length: 0
        )

        INVALID_RANGE = Template.new(
          code: 'ERROR_0003',
          message: '範囲検索の日付指定が誤っています。',
          length: 0
        )
      end
    end
  end
end
