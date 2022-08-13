# frozen_string_literal: true

require_relative './month'

# :nodoc:
module Zakuro
  # :nodoc:
  module All
    # :nodoc:
    module Genka
      class << self
        #
        # データを取得する
        #
        # @return [Array<Integer, Hash>] テストデータ
        #
        def get
          months = to_month

          result = {}

          value = []
          months.each do |month|
            if month.first?
              value = [month.to_h]
              result[month.western_year] = value
              next
            end

            value.push(month.to_h)
          end

          result
        end

        private

        def to_month
          months = []

          filepath = File.expand_path(
            '../../../../../../zakuro-data/text/rekijitu.txt',
            __dir__
          )

          File.open(filepath, 'r') do |f|
            f.each_line do |line|
              month = Month.new(text: line)

              next if month.invalid?

              months.push(month)
            end
          end

          months
        end
      end
    end
  end
end
