# frozen_string_literal: true

require_relative '../western/calendar'

require_relative './version/resource'

# :nodoc:
module Zakuro
  #
  # Japan 和暦
  #
  module Japan
    #
    # Version 暦
    #
    module Version
      class << self
        #
        # 年を基準に暦を引き当てる
        #
        # @param [Integer] start_year 開始西暦年
        # @param [Integer] last_year 終了西暦年
        #
        # @return [Array<Range>] 和暦
        #
        def ranges_with_year(start_year:, last_year:)
          result = []

          Resource::LIST.each do |range|
            next if start_year > range.last_year

            next if last_year < range.start_year.western

            result.push(range)
          end

          result
        end
      end
    end
  end
end
