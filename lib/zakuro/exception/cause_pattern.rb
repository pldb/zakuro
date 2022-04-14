# frozen_string_literal: true

require_relative './cause_template'

# :nodoc:
module Zakuro
  # :nodoc:
  module Exception
    #
    # CausePattern 原因パターン
    #
    module CausePattern
      INTERNAL_ERROR = CauseTemplate.new(
        code: 'ERROR_0001',
        message: '致命的なエラーです。',
        length: 0
      )

      UNKWON_CAUSE = CauseTemplate.new(
        code: 'ERROR_0999',
        message: '存在しないエラーコードです。',
        length: 0
      )
    end
  end
end
