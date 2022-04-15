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

        UNKWON_CAUSE = Template.new(
          code: 'ERROR_0999',
          message: '存在しないエラーコードです。',
          length: 0
        )
      end
    end
  end
end
