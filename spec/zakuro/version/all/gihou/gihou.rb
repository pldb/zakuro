# frozen_string_literal: true

require_relative './gengou'
require_relative './line'

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

            month = line.month

            if month.leaped_october?
              value.push(line.to_h)
              # 閏10月開始にする
              value = [line.to_h]
              result[month.western_year] = value
              next
            end

            if month.november? && value.size != 1
              # 11月自体は前年にも足す
              value.push(line.to_h)
              # 11月開始にする
              value = [line.to_h]
              result[month.western_year] = value
              next
            end

            value.push(line.to_h)
          end
        end

        def to_line # rubocop:disable Metrics/MethodLength
          lines = []

          gengou = Gengou.new
          num = 0
          in_range = false
          File.open(fullpath, 'r') do |f|
            f.each_line do |line|
              num += 1

              month = Month.new(text: line)

              next if month.invalid?

              gengou = Gengou.new(text: line) if month.first?

              in_range = range?(in_range: in_range, gengou: gengou)

              next unless in_range

              lines.push(Line.new(num: num, month: month))
            end
          end

          lines
        end

        def fullpath
          # TODO: ファイルが存在しない場合はスキップするようにする
          File.expand_path(
            '../../../../../../zakuro-data/text/rekijitu.txt',
            __dir__
          )
        end

        def range?(in_range:, gengou:)
          # 開始
          unless in_range
            return true if gengou.name == '文武' && gengou.year == 2
          end

          # 終了
          if in_range
            return false if gengou.name == '天平宝字' && gengou.year == 8
          end

          in_range
        end
      end
    end
  end
end
