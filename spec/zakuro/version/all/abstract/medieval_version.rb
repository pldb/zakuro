# frozen_string_literal: true

require_relative './reference'

require_relative './medieval_month'
require_relative './medieval_gengou'
require_relative './medieval_line'

# :nodoc:
module Zakuro
  # :nodoc:
  module All
    # MedievalVersion 中世暦の期待値生成
    module MedievalVersion
      # @return [Array<MedievalGengou>] 11月開始
      #
      # 閏10月開始を標準とするが、歴算値によっては11月開始となる
      #
      NOVEMBER_FIRST_GENGOU = [
        MedievalGengou.new(text: '天平神護 1年')
      ].freeze

      class << self
        #
        # データを取得する
        #
        # @return [Array<Integer, Hash>] テストデータ
        #
        def get(range:)
          lines = to_line(range: range)

          result = {}

          current_index = to_first_result(lines: lines, result: result)

          to_result(lines: lines, result: result, current_index: current_index)

          result
        end

        private

        def to_first_result(lines: [], result: {})
          value = []
          lines.each_with_index do |line, index|
            month = line.month
            if index.zero?
              value = [line.to_h]
              # 11月ではないので1年前倒しする
              result[month.western_year - 1] = value
              next
            end

            return index if month.month == 11

            value.push(line.to_h)
          end

          0
        end

        def to_result(lines:, result:, current_index:)
          value = []
          lines.each_with_index do |line, index|
            next if index < current_index

            value, matched = first(result: result, line: line, value: value)

            next if matched

            value.push(line.to_h)
          end
        end

        def first(result:, line:, value:)
          month = line.month

          if leaped_october?(line: line)
            value.push(line.to_h)
            # 閏10月開始にする
            value = [line.to_h]
            result[month.western_year] = value
            return value, true
          end

          if month.november? && value.size != 1
            # 11月自体は前年にも足す
            value.push(line.to_h)
            # 11月開始にする
            value = [line.to_h]
            result[month.western_year] = value
            return value, true
          end

          [value, false]
        end

        def leaped_october?(line:)
          return false unless line.month.leaped_october?

          return false if NOVEMBER_FIRST_GENGOU.include?(line.gengou)

          true
        end

        def to_line(range:) # rubocop:disable Metrics/MethodLength
          lines = []

          gengou = MedievalGengou.new
          num = 0
          in_range = false
          File.open(fullpath, 'r') do |f|
            f.each_line do |line|
              num += 1

              month = MedievalMonth.new(text: line)

              next if month.invalid?

              gengou = MedievalGengou.new(text: line) if month.first?

              in_range = range?(in_range: in_range, gengou: gengou, range: range)

              next unless in_range

              lines.push(MedievalLine.new(num: num, gengou: gengou, month: month))
            end
          end

          lines
        end

        def fullpath
          Reference.path
        end

        def range?(in_range:, gengou:, range:)
          # 開始
          return true if !in_range && range.start?(gengou: gengou)

          # 終了
          return false if in_range && range.last?(gengou: gengou)

          in_range
        end

        def start_range?(gengou:)
          gengou.name == '文武' && gengou.year == 2
        end

        def last_range?(gengou:)
          gengou.name == '天平宝字' && gengou.year == 8
        end
      end
    end
  end
end
