# frozen_string_literal: true

require_relative '../../../../era/japan/version'
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
        # @param [Integer] last_year 終了西暦年
        #
        # @return [Array<Range>] 暦の範囲
        #
        def self.get(start_year:, last_year:)
          ranges = Japan::Version.ranges_with_year(start_year: start_year, last_year: last_year)

          result = []

          ranges.each do |range|
            next unless range.released

            range_start_year = range.start_year
            range_start_year = start_year if start_year > range.start_year

            range_last_year = range.last_year
            range_last_year = last_year if last_year < range.last_year

            result.push(
              Range.new(
                name: range.name, start_date: range.start_date.clone,
                start_year: range_start_year, last_year: range_last_year
              )
            )
          end

          result
        end
      end
    end
  end
end
