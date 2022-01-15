# frozen_string_literal: true

require_relative '../../../era/japan/version'
require_relative './range'

# :nodoc:
module Zakuro
  # :nodoc:
  module Calculation
    # :nodoc:
    module Version
      #
      # 暦検索
      #
      module Crawler
        #
        # 暦の範囲を取得する
        #
        # @param [Integer] start_year 開始西暦年
        # @param [Integer] end_year 終了西暦年
        #
        # @return [Array<Range>] 暦の範囲
        #
        def self.get(start_year:, end_year:)
          ranges = Japan::Version.ranges_with_year(start_year: start_year, end_year: end_year)

          result = []

          ranges.each do |range|
            next unless range.released

            range_start_year = range.start_year
            range_start_year = start_year if start_year > range.start_year

            range_end_year = range.end_year
            range_end_year = end_year if end_year < range.end_year

            result.push(
              Range.new(
                name: range.name, start_date: range.start_date.clone,
                start_year: range_start_year, end_year: range_end_year
              )
            )
          end

          result
        end
      end
    end
  end
end
