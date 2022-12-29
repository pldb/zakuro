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
      # 『日本暦日便覧』に従い、ファイル内には次のようなフォーマットでテストデータが用意されている
      # <pre>
      #
      #   天平宝字 8年(764)・・・1・19(丁巳)滅,  2・24(辛卯)没,  3・23(庚申)滅,  5・5(辛丑)没,  5・27(癸亥)滅,  7・15(庚戌)没,  8・1(丙寅)滅,
      #                     9・26(庚申)没, 10・6(己巳)滅, 12・8(庚午)没, 12・10(壬申)滅,
      #
      #   天平神護 1年(765)・・・2・14(乙亥)滅,  2・18(己卯)没,  4・17(戊寅)滅,  4・28(己丑)没,  6・21(辛巳)滅,  7・9(己亥)没,  8・24(癸未)滅,
      #                     9・19(戊申)没, 10・28(丙戌)滅,  11・1(戊午)没, 12・3(己丑)滅,
      # </pre>
      #
      module Parser
        # @return [Regexp] コメント行
        COMMENT_LINE_REGEX = /^[\s\t]*#/.freeze

        # @return [Regexp] 年ありの行（その年の最初の行）
        FIRST_LINE_REGEX = /^([一-龥]{2,4}) ([0-9]{1,2})年\(([0-9]{3,4})\)・・・(.+)/.freeze

        class << self
          #
          # データを取得する
          #
          # @return [Array<Year>] テストデータ
          #
          def get
            path = fullpath
            if path == ''
              p 'test data does not exist.skip test.'
              return []
            end

            years(path: path)
          end

          private

          def years(path:)
            result = []
            year = Year.new

            File.open(path, 'r') do |f|
              f.each_line do |line|
                text = line.strip

                next if comment_line?(line: line)

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

          def fullpath
            Reference.path
          end

          def comment_line?(line:)
            return true if line == ''

            line.match?(COMMENT_LINE_REGEX)
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
