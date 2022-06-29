# frozen_string_literal: true

# :nodoc:
module Zakuro
  # :nodoc:
  module Calculation
    # :nodoc:
    module Summary
      # :nodoc:
      module Japan
        #
        # SpecifiedRange 特定範囲
        #
        class SpecifiedRange
          # @return [Result::Data::SingleDay] 特定開始日
          attr_reader :start_date
          # @return [Result::Data::SingleDay] 特定終了日
          attr_reader :last_date

          #
          # 初期化
          #
          # @param [Result::Data::SingleDay] start_date 特定開始日
          # @param [Result::Data::SingleDay] last_date 特定終了日
          #
          def initialize(start_date:, last_date:)
            @start_date = start_date
            @last_date = last_date
          end
        end
      end
    end
  end
end
