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

          # TODO: refactor

          value = []
          first = true
          current_index = 0
          lines.each_with_index do |line, index|
            month = line.month
            if first
              first = false
              value = [line.to_h]
              # 11月ではないので1年前倒しする
              result[month.western_year - 1] = value
              next
            end

            if month.month == 11
              current_index = index
              break
            end

            value.push(line.to_h)
          end

          value = []
          lines.each_with_index do |line, index|
            next if index < current_index

            month = line.month

            if month.month == 11
              # 11月自体は前年にも足す
              value.push(line.to_h)
              # 11月開始にする
              value = [line.to_h]
              result[month.western_year] = value
              next
            end

            value.push(line.to_h)
          end

          result
        end

        private

        def to_line
          lines = []

          # TODO: ファイルが存在しない場合はスキップするようにする
          filepath = File.expand_path(
            '../../../../../../zakuro-data/text/rekijitu.txt',
            __dir__
          )

          gengou = Gengou.new
          num = 0
          in_range = false
          File.open(filepath, 'r') do |f|
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
