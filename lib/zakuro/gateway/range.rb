# frozen_string_literal: true

require_relative '../calculation/summary/japan/range'
require_relative '../calculation/summary/western/range'
require_relative '../exception/case/preset'
require_relative '../exception/exception'

require_relative './locale/range'

# :nodoc:
module Zakuro
  # :nodoc:
  module Gateway
    #
    # Range 範囲
    #
    class Range
      # @return [Context::Context] 暦コンテキスト
      attr_reader :context
      # @return [Locale::Range] 範囲
      attr_reader :range

      #
      # 初期化
      #
      # @param [Context::Context] context 暦コンテキスト
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
      # @return [Result::Range] 範囲検索結果（和暦日）
      #
      def get
        start_date = range.start_date
        last_date = range.last_date

        return western(start_date: start_date, last_date: last_date) if range.valid_western?

        return japan(start_date: start_date, last_date: last_date) if range.valid_japan?

        raise Exception.get(
          presets: [
            Exception::Case::Preset.new(
              template: Exception::Case::Pattern::INVALID_RANGE
            )
          ]
        )
      end

      private

      #
      # 西暦日による結果を取得する
      #
      # @param [Locale::Date] start_date 西暦開始日
      # @param [Locale::Date] last_date 西暦終了日
      #
      # @return [Result::Range] 範囲検索結果（和暦日）
      #
      def western(start_date: Locale::Date.new, last_date: Locale::Date.new)
        Calculation::Summary::Western::Range.get(
          context: context, start_date: start_date.western_date,
          last_date: last_date.western_date
        )
      end

      #
      # 和暦日による結果を取得する
      #
      # @param [Locale::Date] start_date 和暦開始日
      # @param [Locale::Date] last_date 和暦終了日
      #
      # @return [Result::Range] 範囲検索結果（和暦日）
      #
      def japan(start_date: Locale::Date.new, last_date: Locale::Date.new)
        Calculation::Summary::Japan::Range.get(
          context: context, start_date: start_date.japan_date,
          last_date: last_date.japan_date
        )
      end
    end
  end
end
