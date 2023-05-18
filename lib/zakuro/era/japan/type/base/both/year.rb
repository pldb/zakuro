# frozen_string_literal: true

require_relative '../../../../western/calendar'

require_relative '../../../calendar'

# :nodoc:
module Zakuro
  # :nodoc:
  module Japan
    # :nodoc:
    module Type
      # :nodoc:
      module Base
        # :nodoc:
        module Both
          #
          # Year 年
          #
          class Year
            # @return [Integer] 不正値
            INVALID = -1
            # @return [Integer] 和暦元号年
            attr_reader :japan
            # @return [Integer] 西暦年
            attr_reader :western

            #
            # 初期化
            #
            # @param [Integer] japan 和暦元号年
            # @param [Integer] western 西暦年
            #
            def initialize(japan: INVALID, western: INVALID)
              @japan = japan
              @western = western
            end

            #
            # 不正か
            #
            # @return [True] 不正
            # @return [False] 不正なし
            #
            def invalid?
              japan == INVALID || western == INVALID
            end
          end
        end
      end
    end
  end
end
