# frozen_string_literal: true

require_relative '../calculation/summary/japan/single'
require_relative '../calculation/summary/western/single'
require_relative '../exception/case/preset'
require_relative '../exception/exception'

require_relative './locale/date'

# :nodoc:
module Zakuro
  # :nodoc:
  module Gateway
    #
    # Single 1日
    #
    class Single
      # @return [Locale::Date] 日付
      attr_reader :date

      #
      # 初期化
      #
      # @param [Context::Context] context 暦コンテキスト
      # @param [Date, String] date 日付
      #
      def initialize(context:, date:)
        @context = context
        @date = Locale::Date.new(date: date)
      end

      #
      # 不正か
      #
      # @return [True] 不正
      # @return [False] 不正なし
      #
      def invalid?
        date.invalid?
      end

      #
      # 検索結果を取得する
      #
      # @return [Result::Single] 一日検索結果（和暦日）
      #
      def get
        if date.valid_western?
          return Calculation::Summary::Western::Single.get(
            context: @context, date: date.western_date
          )
        end

        if date.valid_japan?
          return Calculation::Summary::Japan::Single.get(
            context: @context, date: date.japan_date
          )
        end

        raise invalid_date_error
      end

      private

      #
      # 日付不正エラーを取得する
      #
      # @return [ZakuroError] ライブラリエラー
      #
      def invalid_date_error
        Exception.get(
          presets: [
            Exception::Case::Preset.new(
              template: Exception::Case::Pattern::INVALID_DATE
            )
          ]
        )
      end
    end
  end
end
