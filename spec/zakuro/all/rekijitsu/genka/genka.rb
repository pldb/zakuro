# frozen_string_literal: true

require_relative './line'

# :nodoc:
module Zakuro
  # :nodoc:
  module All
    # :nodoc:
    module Rekijitsu
      # :nodoc:
      module Genka
        class << self
          #
          # データを取得する
          #
          # @return [Array<Integer, Hash>] テストデータ
          #
          def get
            lines = to_line

            result = {}

            value = []
            lines.each do |line|
              month = line.month
              unless month.first?
                value.push(line.to_h)
                next
              end

              break if month.western_year >= 698

              value = [line.to_h]
              result[month.western_year] = value
            end

            result
          end

          private

          def to_line # rubocop:disable Metrics/MethodLength
            lines = []

            path = filepath

            if path == ''
              p 'test data does not exist.skip test.'
              return lines
            end

            num = 0
            File.open(path, 'r') do |f|
              f.each_line do |line|
                num += 1
                month = Month.new(text: line)

                next if month.invalid?

                lines.push(Line.new(num: num, month: month))
              end
            end

            lines
          end

          def filepath
            path = File.expand_path(
              '../../../../../../zakuro-data/text/rekijitu.txt',
              __dir__
            )

            return path if File.exist?(path)

            ''
          end
        end
      end
    end
  end
end
