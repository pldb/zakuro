# frozen_string_literal: true

# :nodoc:
module Zakuro
  # :nodoc:
  module All
    # :nodoc:
    module Reverse
      #
      # SingleDatePrinter 一日検索結果出力
      #
      class SingleDatePrinter
        # @return [Zakuro::Result::Single] 一日検索結果
        attr_reader :date

        #
        # 初期化
        #
        # @param [Zakuro::Result::Single] date 一日検索結果
        #
        def initialize(date:)
          @date = date
        end

        #
        # 西暦日を返す
        #
        # @return [String] 西暦日
        #
        def western_date
          date.data.day.western_date.format
        end

        #
        # 1行目元号の和暦日を返す
        #
        # @return [String] 和暦日
        #
        def first_japan_date
          data = date.data

          "#{data.year.first_gengou.name}#{data.year.first_gengou.number}年" \
                    "#{data.month.leaped ? '閏' : ''}#{data.month.number}月#{data.day.number}日"
        end

        #
        # 2行目元号の和暦日を返す
        #
        # @return [String] 和暦日
        #
        def second_japan_date
          data = date.data

          "#{data.year.second_gengou.name}#{data.year.second_gengou.number}年" \
                    "#{data.month.leaped ? '閏' : ''}#{data.month.number}月#{data.day.number}日"
        end

        #
        # 2行目元号が存在するか？
        #
        # @return [True] 存在あり
        # @return [False] 存在なし
        #
        def second?
          gengou_name = date.data.year.second_gengou.name

          return false if gengou_name == ''

          true
        end
      end
    end
  end
end
