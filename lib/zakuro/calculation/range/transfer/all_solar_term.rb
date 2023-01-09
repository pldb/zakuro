# frozen_string_literal: true

require_relative '../../../calculation/base/year'

require_relative '../../../era/western/calendar'

# :nodoc:
module Zakuro
  # :nodoc:
  module Calculation
    # :nodoc:
    module Range
      # :nodoc:
      module Transfer
        #
        # AllSolarTerm 月内全ての二十四節気
        #
        module AllSolarTerm
          class << self
            #
            # 月内全ての二十四節気を更新する
            #
            # @param [Array<Array<Month>>] annual_ranges 年データ（冬至基準）
            #
            def update_months(annual_ranges:)
              # TODO: make
            end

            #
            # 月内全ての二十四節気を更新する
            #
            # @param [Array<Base::Year>] annual_ranges 年データ（元旦基準）
            #
            def update_years(annual_ranges:)
              # TODO: make
            end
          end
        end
      end
    end
  end
end
