# frozen_string_literal: true

require_relative '../../cycle/abstract_solar_term'

# :nodoc:
module Zakuro
  # :nodoc:
  module Calculation
    # :nodoc:
    module Monthly
      #
      # SolarTermSelector 二十四節気検索
      #
      class SolarTermSelector
        # @return [Context::Context] 暦コンテキスト
        attr_reader :context
        # @return [Array<Cyle::AbstractSolarTerm>] 二十四節気
        attr_reader :solar_terms

        #
        # 初期化
        #
        # @param [Context::Context] context 暦コンテキスト
        # @param [Array<Cyle::AbstractSolarTerm>] solar_terms 二十四節気
        #
        def initialize(context: Context::Context.new, solar_terms: [])
          @context = context
          @solar_terms = solar_terms
        end

        #
        # 二十四節気が未設定かどうかを検証する
        #
        # @return [True] 設定なし
        # @return [False] 設定あり
        #
        def empty?
          solar_terms.empty?
        end

        #
        # 中気を返す
        #
        # @return [Cycle::AbstractSolarTerm] 中気
        #
        def even_term
          solar_terms.each do |term|
            return term if term.index.even?
          end

          context.resolver.solar_term.new
        end

        #
        # 節気を返す
        #
        # @return [Cycle::AbstractSolarTerm] 節気
        #
        def odd_term
          solar_terms.each do |term|
            return term if term.index.odd?
          end

          context.resolver.solar_term.new
        end

        #
        # 二十四節気を追加する
        #
        # @param [SolarTerm] term 二十四節気
        #
        def add_term(term:)
          solar_terms.push(term)
        end

        #
        # 二十四節気を正しい順序にソートする
        #
        def sort
          # TODO: refactor
          sorted = (solar_terms.sort do |termx, termy|
            termx.index <=> termy.index
          end)

          unless reset_term?(solar_terms: sorted)
            @solar_terms = sorted
            return
          end

          first = []
          second = []

          sorted.each do |term|
            if term.index >= (23 - 2)
              second.push(term)
              next
            end

            first.push(term)
          end

          # 0以前を先頭にする
          second += first

          @solar_terms = second
        end

        #
        # 大余に対応する二十四節気
        #
        # @param [Integer] day 大余
        #
        # @return [Cycle::AbstractSolarTerm] 二十四節気
        #

        #
        # 大余に対応する二十四節気
        #
        # @param [Integer] day 大余
        # @param [Meta] meta メタ情報
        #
        # @return [Cycle::AbstractSolarTerm] 二十四節気
        #
        def solar_term_by_day(day:, meta:)
          # TODO: refactor
          target = context.resolver.remainder.new(day: day, minute: 0, second: 0)

          meta.all_solar_terms.each_cons(2) do |current_solar_term, next_solar_term|
            in_range = Tool::RemainderComparer.in_range?(
              target: target, start: current_solar_term.remainder, last: next_solar_term.remainder
            )
            return current_solar_term if in_range
          end

          last_solar_term = meta.all_solar_terms[-1]

          empty_solar_term = context.resolver.solar_term.new

          return empty_solar_term unless last_solar_term
          # NOTE: 大余20を上限として範囲チェックする
          if Tool::RemainderComparer.in_limit?(target: target, start: last_solar_term.remainder,
                                               limit: 20)
            return last_solar_term
          end

          empty_solar_term
        end

        private

        #
        # 二十四節気の折り返し（23 -> 0）があるか
        #
        # @param [Array<Cyle::AbstractSolarTerm>] solar_terms 二十四節気
        #
        # @return [True] 折り返しあり
        # @return [False] 折り返しなし
        #
        def reset_term?(solar_terms: [])
          first = false
          last = false

          solar_terms.each do |term|
            index = term.index
            case index
            when Cycle::AbstractSolarTerm::FIRST_INDEX
              first = true
            when Cycle::AbstractSolarTerm::LAST_INDEX
              last = true
            end
          end

          first && last
        end
      end
    end
  end
end
