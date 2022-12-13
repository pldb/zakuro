# frozen_string_literal: true

require_relative './reference'
require_relative './year'

# :nodoc:
module Zakuro
  # :nodoc:
  module All
    # :nodoc:
    module Motsumetsu
      #
      # テストデータを解析する
      #
      module Parser
        FIRST_LINE_REGEX = /^([一-龥]{2,4}) ([0-9]{1,2})年\(([0-9]{3,4})\)・・・(.+)/.freeze

        # TODO: refactor
        class << self
          #
          # データを取得する
          #
          # @return [Array<Year>] テストデータ
          #
          def get
            result = []
            year = Year.new

            File.open(fullpath, 'r') do |f|
              f.each_line do |line|
                text = line.strip

                next if text == ''

                if first_line?(line: line)
                  year = first_line(line: text)
                  next
                end

                second_line(year: year, line: text)

                result.push(year)
              end
            end

            result
          end

          private

          def fullpath
            Reference.path
          end

          def first_line?(line:)
            line.match?(FIRST_LINE_REGEX)
          end

          def first_line(line:)
            m = line.match(FIRST_LINE_REGEX)

            return Year.new unless m

            gengou = Gengou.new(name: m[1], year: m[2].to_i, western_year: m[3].to_i)

            dates = japan_dates(line: m[4])

            Year.new(gengou: gengou, dates: dates)
          end

          def second_line(year:, line:)
            dates = year.dates

            result = japan_dates(line: line)

            dates.concat(result)
          end

          def japan_dates(line:)
            result = []
            dates = line.split(',')
            dates.each do |date|
              date = date.strip

              next if date == ''

              parsed = JapanDate.new(text: date)

              result.push(parsed)
            end

            result
          end
        end
      end
    end
  end
end
