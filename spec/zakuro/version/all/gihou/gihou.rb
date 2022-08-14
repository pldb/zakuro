# frozen_string_literal: true

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

          # TODO: 最初の1月-10月のケースが処理されていない

          value = []
          lines.each do |line|
            month = line.month
            # 11月はじまりにする
            unless month.month == 11
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

        def to_line
          lines = []

          filepath = File.expand_path(
            '../../../../../../zakuro-data/text/rekijitu.txt',
            __dir__
          )

          num = 0
          File.open(filepath, 'r') do |f|
            f.each_line do |line|
              num += 1

              next unless range?(num: num)

              month = Month.new(text: line)

              next if month.invalid?

              lines.push(Line.new(num: num, month: month))
            end
          end

          lines
        end

        #
        # 範囲内か
        #
        # @param [Integer] num 行番号
        #
        # @return [True] 範囲内
        # @return [False] 範囲外
        #
        def range?(num:)
          # 文武 1年 以前
          return false if num < 3400

          # 天平宝字 8年 以降
          return false if num > 4282

          true
        end
      end
    end
  end
end
