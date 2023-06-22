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
          # Date 日
          #
          class Date
            # @return [Japan::Calendar] 和暦日
            attr_reader :japan
            # @return [Western::Calendar] 西暦日
            attr_reader :western

            #
            # 初期化
            #
            # @param [Japan::Calendar] japan 和暦日
            # @param [Western::Calendar] western 西暦日
            #
            def initialize(japan: Japan::Calendar.new, western: Western::Calendar.new)
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
              japan.invalid? || western.invalid?
            end
          end
        end
      end
    end
  end
end
