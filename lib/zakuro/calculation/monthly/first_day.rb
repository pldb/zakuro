# frozen_string_literal: true

require_relative '../../era/western'

# :nodoc:
module Zakuro
  # :nodoc:
  module Calculation
    # :nodoc:
    module Monthly
      #
      # FirstDay 月初日（朔日）
      #
      class FirstDay
        # @return [Western::Calendar] 西暦日
        attr_reader :western_date
        # @return [Remainder] 大余小余
        attr_reader :remainder

        #
        # 初期化
        #
        # @param [Remainder] remainder 西暦日
        # @param [Western::Calendar] western_date 大余小余
        #
        def initialize(western_date: Western::Calendar.new, remainder:)
          # 西暦日
          @western_date = western_date
          # 大余小余
          @remainder = remainder
        end

        #
        # ディープコピー
        #
        # @param [FirstDay] obj 自身
        #
        def initialize_copy(obj)
          @western_date = obj.western_date.clone
          @remainder = obj.remainder.clone
        end
      end
    end
  end
end
