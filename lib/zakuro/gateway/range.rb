# frozen_string_literal: true

require_relative '../calculation/summary/japan/range'
require_relative '../calculation/summary/western/range'

require_relative './locale/range'

# :nodoc:
module Zakuro
  # :nodoc:
  module Gateway
    #
    # Range 範囲
    #
    class Range
      # @return [Locale::Range] 範囲
      attr_reader :range

      #
      # 初期化
      #
      # @param [Context] context 暦コンテキスト
      # @param [Hash<Symbol, Object>] range 範囲
      #
      def initialize(context:, range:)
        @context = context
        @range = Locale::Range.new(range: range)
      end

      #
      # 不正か
      #
      # @return [True] 不正
      # @return [False] 不正なし
      #
      def invalid?
        @range.invalid?
      end

      #
      # 検索結果を取得する
      #
      # @return [Result::Single] 一日検索結果（和暦日）
      #
      def get
        # TODO: refactor
        start_date = range.start_date
        last_date = range.last_date

        if range.valid_western?
          return Calculation::Summary::Western::Range.get(
            context: @context, start_date: start_date.western_date,
            last_date: last_date.western_date
          )
        end

        if range.valid_japan?
          return Calculation::Summary::Japan::Range.get(
            context: @context, start_date: start_date.japan_date,
            last_date: last_date.japan_date
          )
        end

        # TODO: error
        p 'error'
      end
    end
  end
end
