# frozen_string_literal: true

require_relative './both/date'
require_relative './both/year'
require_relative './gengou'

# :nodoc:
module Zakuro
  # :nodoc:
  module Japan
    # :nodoc:
    module Type
      # :nodoc:
      module Base
        #
        # GengouSet 元号セット
        #
        class GengouSet
          # @return [Integer] 不正値
          INVALID = -1
          # @return [Integer] 元号セットID
          attr_reader :id
          # @return [String] 元号セット名
          attr_reader :name
          # @return [Both::Year] 元号セットでの終了年
          attr_reader :last_year
          # @return [Both::Date] 元号セットでの終了日
          attr_reader :last_date
          # @return [Array<Gengou>] 元号リスト
          attr_reader :list

          #
          # 初期化
          #
          # @param [Integer] id 元号セットID
          # @param [String] name 元号セット名
          # @param [Both::Year] last_year 元号セットでの終了年
          # @param [Both::Date] last_date 元号セットでの終了日
          # @param [Array<Gengou>] list 元号リスト
          #
          def initialize(id: INVALID, name: '', last_year: Both::Year.new,
                         last_date: Both::Date.new, list: [])
            @id = id
            @name = name
            @last_year = last_year
            @last_date = last_date
            @list = list
          end

          #
          # 指定した日付を含む元号を返す
          #
          # @param [Western::Calendar] date 日
          #
          # @return [Gengou] 元号
          #
          def include_item(date:)
            list.each do |item|
              return item if item.include?(date: date)
            end

            Gengou.new
          end

          #
          # 元号セットが不正かどうかを確認する
          #
          # @return [True] 正しくない
          # @return [False] 正しい
          #
          def invalid?
            @id == INVALID
          end
        end
      end
    end
  end
end
