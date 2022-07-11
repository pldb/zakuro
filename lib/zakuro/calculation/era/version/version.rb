# frozen_string_literal: true

require_relative './internal/crawler'

# :nodoc:
module Zakuro
  # :nodoc:
  module Calculation
    # :nodoc:
    module Version
      class << self
        #
        # 暦の範囲を取得する
        #
        # @param [Integer] start_year 開始西暦年
        # @param [Integer] last_year 終了西暦年
        #
        # @return [Array<Range>] 暦の範囲
        #
        def get(start_year:, last_year:)
          Crawler.get(start_year: start_year, last_year: last_year)
        end
      end
    end
  end
end
