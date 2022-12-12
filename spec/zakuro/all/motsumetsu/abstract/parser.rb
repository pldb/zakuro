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
        # TODO: refactor
        class << self
          #
          # データを取得する
          #
          # @return [<Type>] テストデータ
          #
          def get
            result = []
            year = Year.new

            File.open(fullpath, 'r') do |f|
              f.each_line do |line|
                text = line.gsub("\n", '')

                next if text == ''

                year = first_line(line: text)

                next if year.invalid?

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

          def first_line(line:)
            m = line.match(/^([一-龥]{2,4}) ([0-9]{1,2})年\(([0-9]{3,4})\)・・・(.+)/)

            return Year.new unless m

            japan_dates = []
            gengou = Gengou.new(name: m[1], year: m[2].to_i, western_year: m[3].to_i)
            dates = m[4].split(',')
            dates.each do |date|
              next if date == ''

              parsed = JapanDate.new(text: date)

              japan_dates.push(parsed)
            end

            Year.new(gengou: gengou, dates: japan_dates)
          end

          def second_line(year:, line:)
            m = line.match(/^\s+(.+)/)

            return unless m

            japan_dates = year.dates

            dates = m[1].split(',')
            dates.each do |date|
              next if date == ''

              parsed = JapanDate.new(text: date)

              japan_dates.push(parsed)
            end
          end
        end
      end
    end
  end
end
