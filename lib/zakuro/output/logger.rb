# frozen_string_literal: true

# :nodoc:
module Zakuro
  # :nodoc:
  module Output
    #
    # 軽量なロガー
    # @note 本番では使用しない
    #
    class Logger
      # @return [Hash<Symbol, Integer>] ログレベル
      LEVELS = {
        none: -1,
        debug: 0,
        info: 1,
        warn: 2,
        error: 3
      }.freeze

      # @return [Integer] 現在ログレベル
      LEVEL = LEVELS[:none]

      # @return [String] 呼び出し位置
      attr_reader :location

      def initialize(location:)
        @location = location
      end

      #
      # DEBUGレベルの標準出力を行う
      #
      # @param [String] messages メッセージ
      #
      def debug(*messages)
        return if none?

        return if LEVELS[:debug] < LEVEL

        output('DEBUG', *messages)
      end

      #
      # INFOレベルの標準出力を行う
      #
      # @param [String] messages メッセージ
      #
      def info(*messages)
        return if none?

        return if LEVELS[:info] < LEVEL

        output('INFO', *messages)
      end

      #
      # ERRORレベルの標準出力を行う
      #
      # @param [Error] error 例外
      # @param [String] messages メッセージ
      #
      def error(error, *messages)
        return if none?

        return if LEVELS[:error] < LEVEL

        output('ERROR', *messages)
        output('ERROR', error.message)
        output('ERROR', *error.backtrace)
      end

      private

      #
      # 出力なしか
      #
      # @return [True] 出力なし
      # @return [False] 出力あり
      #
      def none?
        LEVELS[:debug] >= LEVEL
      end

      #
      # 標準出力を行う
      #
      # @param [String] level ログレベル
      # @param [String] messages メッセージ
      #
      def output(level, *messages)
        messages.each do |message|
          # :#{Thread.current.backtrace[5]}
          p "[#{level}] #{@location}: #{message}"
        end
      end
    end
  end
end
