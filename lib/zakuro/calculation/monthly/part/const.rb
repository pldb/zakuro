# frozen_string_literal: true

# :nodoc:
module Zakuro
  # :nodoc:
  module Calculation
    # :nodoc:
    module Monthly
      #
      # Const 定数
      #
      module Const
        # @return [Array<String>] 月内の弦
        PHASE_INDEXES = %w[朔日 上弦 望月 下弦].freeze
      end
    end
  end
end
