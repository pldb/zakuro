# frozen_string_literal: true

require_relative './division'

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
        # 下記のパターンが存在し、戻り値は重複分となる
        #
        # 1. 完全に範囲外（開始日より前）
        #   [@list]:      |-------|-------|
        #   [list]:  |---|
        # 2. 前半のみ範囲外
        #   [@list]:      |-------|-------|
        #   [list]:  |------|
        # 3. 範囲内
        #   [@list]: |-------|-------|
        #   [list]:  |------|
        # 4. 後半のみ範囲外
        #   [@list]: |-------|-------|
        #   [list]:              |------|
        # 5. 完全に範囲外（開始日より後）
        #   [@list]: |-------|-------|
        #   [list]:                   |----|
        # 6. 両端が範囲外
        #   [@list]:   |-------|-------|
        #   [list]:  |--------------------|
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

        #
        # 重複分（空きがないため追加できない範囲の元号）を返す
        #
        # @param [Array<LinearGengou>] list 元号
        #
        # @return [Array<LinearGengou>] 重複分元号
        #
        def rest(list: [])
          result = []

          @list.each do |gengou|
            result |= and!(rest: list, other: gengou)
          end

          Division.connect(list: result)
        end

        #
        # 空き範囲に元号を登録する
        #
        # @param [Array<LinearGengou>] list 元号
        #
        def insert(list: [])
          surplus_result = list.clone
          @list.each do |gengou|
            surplus_result = not!(surplus: surplus_result, other: gengou)
          end

          surplus_result = Division.connect(list: surplus_result)

          surplus_result.each do |gengou|
            @list.push(gengou)
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
            result |= Division.match(this: gengou, other: other)
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
            result |= Division.mismatch(this: gengou, other: other)
          end

          result
        end
      end
    end
  end
end
