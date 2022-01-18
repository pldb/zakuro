# frozen_string_literal: true

require_relative '../specifier/multiple_day'

require_relative '../range/operated_range'

require_relative '../range/full_range'

# :nodoc:
module Zakuro
  # :nodoc:
  module Calculation
    # :nodoc:
    module Summary
      #
      # Range 期間
      #
      module Range
        #
        # 生成する
        #
        # @param [Context] context 暦コンテキスト
        # @param [Western::Calendar] start_date 西暦開始日
        # @param [Western::Calendar] last_date 西暦終了日
        #
        # @return [Result::Range] 期間検索結果（和暦日）
        #
        def self.get(context:, start_date: Western::Calendar.new, last_date: Western::Calendar.new)
          # TODO: make
        end
      end
    end
  end
end
