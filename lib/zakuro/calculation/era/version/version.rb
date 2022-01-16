# frozen_string_literal: true

require_relative './internal/crawler'

# :nodoc:
module Zakuro
  # :nodoc:
  module Calculation
    # :nodoc:
    module Version
      #
      # 暦の範囲を取得する
      #
      # @param [Integer] start_year 開始西暦年
      # @param [Integer] end_year 終了西暦年
      #
      # @return [Array<Range>] 暦の範囲
      #
      def self.get(start_year:, end_year:)
        Crawler.get(start_year: start_year, end_year: end_year)
      end
    end
  end
end
