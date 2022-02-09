# frozen_string_literal: true

require_relative './linear_gengou'

# :nodoc:
module Zakuro
  # :nodoc:
  module Japan
    # :nodoc:
    module Alignment
      #
      # Line 行
      #
      class Line
        # TODO: test

        # @return [Array<LinearGengou>] 元号
        attr_reader :list

        #
        # 初期化
        #
        def initialize
          @list = []
        end

        #
        # 追加する
        #
        # @param [Array<LinearGengou>] list 元号
        #
        # @return [Array<LinearGengou>] 未登録元号
        #
        def push(list: [])
          rest = rest(list: list)

          insert(list: list)

          rest
        end

        private

        def rest(list: [])
          result = list.clone

          @list.each do |gengou|
            result = and!(rest: result, other: gengou)
          end

          result
        end

        def insert(list: [])
          surplus_result = list.clone
          @list.each do |gengou|
            surplus_result = not!(surplus: surplus_result, other: gengou)
          end

          surplus_result.each do |gengou|
            @list.push(gengou: gengou)
          end
        end

        #
        # 重複した範囲を返す
        #
        # @param [Array<LinearGengou>] rest 残り元号
        # @param [LinearGengou] other 比較元号
        #
        # @return [Array<LinearGengou>] 重複分
        #
        def and!(rest:, other:)
          result = []
          rest.each do |gengou|
            result |= duplicate_gengou(this: gengou, other: other)
          end

          result
        end

        #
        # 範囲が重複しない差分を返す
        #
        # @param [Array<LinearGengou>] surplus 積元号
        # @param [LinearGengou] other 比較元号
        #
        # @return [Array<LinearGengou>] 差分
        #
        def not!(surplus:, other:)
          result = []
          surplus.each do |gengou|
            result |= sub_gengou(this: gengou, other: other)
          end

          result
        end

        # # 1. 完全に範囲外（開始日より前）
        # # 2. 前半のみ範囲外
        # # 3. 範囲内
        # # 4. 後半のみ範囲外
        # # 5. 完全に範囲外（開始日より後）
        # # 6. 両端が範囲外

        #
        # 重複した範囲を返す
        #
        # @param [LinearGengou] this 残り元号
        # @param [LinearGengou] other 比較元号
        #
        # @return [Array<LinearGengou>] 重複分
        #
        def duplicate_gengou(this:, other:)
          result = []
          start_date = this.start_date
          last_date = this.last_date
          if other.in?(start_date: start_date, last_date: last_date)
            result.push(this)
            return result
          end
          if other.out?(start_date: start_date, last_date: last_date)
            # 該当なし
            return result
          end

          if other.covered?(start_date: start_date, last_date: last_date)
            # 範囲内のみ返す
            result.push(
              LinearGengou.new(
                start_date: other.start_date, last_date: other.last_date,
                gengou: this.gengou
              )
            )
            return result
          end

          start = start_date > other.start_date ? start_date : other.start_date
          last = last_date < other.last_date ? last_date : other.last_date

          result.push(
            LinearGengou.new(start_date: start, last_date: last, gengou: this.gengou)
          )
          result
        end

        #
        # 範囲が重複しない差分を返す
        #
        # @param [LinearGengou] this 積元号
        # @param [LinearGengou] other 比較元号
        #
        # @return [Array<LinearGengou>] 差分
        #
        def sub_gengou(this:, other:)
          result = []
          start_date = this.start_date
          last_date = this.last_date
          if other.in?(start_date: start_date, last_date: last_date)
            # 該当なし
            return result
          end

          if other.out?(start_date: start_date, last_date: last_date)
            result.push(this)
            return result
          end
          if other.covered?(start_date: start_date, last_date: last_date)
            result.push(
              LinearGengou.new(
                start_date: start_date, last_date: other.start_date, gengou: this.gengou
              ),
              LinearGengou.new(
                start_date: last_date, last_date: other.last_date, gengou: this.gengou
              )
            )
            return result
          end

          start = start_date < other.start_date ? start_date : other.start_date
          last = last_date > other.last_date ? last_date : other.last_date

          result.push(
            LinearGengou.new(start_date: start, last_date: last, gengou: this.gengou)
          )
          result
        end
      end
    end
  end
end
