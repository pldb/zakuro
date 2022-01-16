# frozen_string_literal: true

# :nodoc:
module Zakuro
  # :nodoc:
  module Calculation
    # :nodoc:
    module Version
      #
      # Range 暦（範囲）
      #
      class Range
        # @return [String] 暦名
        attr_reader :name
        # @return [Western::Calendar] 暦の開始日
        attr_reader :start_date
        # @return [Integer] 開始西暦年
        attr_reader :start_year
        # @return [Integer] 終了西暦年
        attr_reader :end_year

        #
        # 初期化
        #
        # @param [String] name 暦名
        # @param [Western::Calendar] start_date 暦の開始日
        # @param [Integer] start_year 開始西暦年
        # @param [Integer] end_year 終了西暦年
        #
        def initialize(name:, start_date:, start_year:, end_year:)
          @name = name
          @start_date = start_date
          @start_year = start_year
          @end_year = end_year
        end
      end
    end
  end
end
