# frozen_string_literal: true

require_relative '../abstract/reference'

require_relative '../abstract/medieval_month'
require_relative '../abstract/medieval_gengou'
require_relative '../abstract/medieval_line'

# :nodoc:
module Zakuro
  # :nodoc:
  module All
    # :nodoc:
    module Gihou
      class << self
        #
        # データを取得する
        #
        # @return [Array<Integer, Hash>] テストデータ
        #
        def get
          lines = to_line

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

          if month.leaped_october?
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

        def to_line # rubocop:disable Metrics/MethodLength
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

              in_range = range?(in_range: in_range, gengou: gengou)

              next unless in_range

              lines.push(MedievalLine.new(num: num, month: month))
            end
          end

          lines
        end

        def fullpath
          Reference.path
        end

        def range?(in_range:, gengou:)
          # 開始
          return true if !in_range && start_range?(gengou: gengou)

          # 終了
          return false if in_range && last_range?(gengou: gengou)

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
