# frozen_string_literal: true

require_relative '../../../era/western/calendar'

require_relative '../../cycle/abstract_remainder'

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
        # @return [Remainder] 大余小余（経朔）
        attr_reader :average_remainder

        #
        # 初期化
        #
        # @param [Remainder] remainder 西暦日
        # @param [Western::Calendar] western_date 大余小余
        #
        def initialize(western_date: Western::Calendar.new,
                       remainder: Calculation::Cycle::AbstractRemainder.new,
                       average_remainder: Calculation::Cycle::AbstractRemainder.new)
          # 西暦日
          @western_date = western_date
          # 大余小余
          @remainder = remainder
          # 大余小余（経朔）
          @average_remainder = average_remainder
        end

        #
        # ディープコピー
        #
        # @param [FirstDay] obj 自身
        #
        def initialize_copy(obj)
          @western_date = obj.western_date.clone
          @remainder = obj.remainder.clone
          @average_remainder = obj.average_remainder.clone
        end
      end
    end
  end
end
