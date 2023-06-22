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
        # @return [Integer] 月最後の二十四節気を検索する大余の範囲上限
        LAST_DAY_LIMIT = 20

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
        # @param [Cycle::AbstractSolarTerm] term 二十四節気
        #
        def add_term(term:)
          solar_terms.push(term)
        end

        #
        # 二十四節気を正しい順序にソートする
        #
        def sort
          sorted = (solar_terms.sort do |termx, termy|
            termx.index <=> termy.index
          end)

          unless reset_term?(solar_terms: sorted)
            @solar_terms = sorted
            return
          end

          @solar_terms = reset(terms: sorted)
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
          target = context.resolver.remainder.new(day: day, minute: 0, second: 0)

          meta.all_solar_terms.each_cons(2) do |current_solar_term, next_solar_term|
            in_range = Tool::RemainderComparer.in_range?(
              target: target, start: current_solar_term.remainder, last: next_solar_term.remainder
            )
            return current_solar_term if in_range
          end

          last_solar_term(target: target, meta: meta)
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

        #
        # 二十四節気を終端で折り返す
        #
        # @param [Array<Cyle::AbstractSolarTerm>] terms 二十四節気
        #
        # @return [Array<Cyle::AbstractSolarTerm>] 折り返し済みの二十四節気
        #
        def reset(terms: [])
          first = []
          second = []

          terms.each do |term|
            # NOTE: 二十四節気は最大3つとすると、 「23, 0」「22, 23, 0」「23, 0, 1」 での折り返しが考えられる
            if term.index >= (Cycle::AbstractSolarTerm::LAST_INDEX - 2)
              second.push(term)
              next
            end

            first.push(term)
          end

          # 0以前を先頭にする
          second += first

          second
        end

        #
        # 最後の二十四節気を返す
        #
        # @param [Cycle::AbstractRemainder] target 対象の大余情報
        # @param [Meta] meta メタ情報
        #
        # @return [Cycle::AbstractSolarTerm] 二十四節気
        #
        def last_solar_term(target:, meta:)
          last = meta.all_solar_terms[-1]

          empty_solar_term = context.resolver.solar_term.new

          return empty_solar_term unless last

          if Tool::RemainderComparer.in_limit?(target: target, start: last.remainder,
                                               limit: LAST_DAY_LIMIT)
            return last
          end

          empty_solar_term
        end
      end
    end
  end
end
