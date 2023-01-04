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
      LEVELS = {
        none: -1,
        debug: 0,
        info: 1,
        warn: 2,
        error: 3
      }.freeze

      # TODO: レベルの判定が逆。errorなら全てのレベルを出し、debugならdebugのみ出すようにする
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
        return if LEVEL < LEVELS[:debug]

        output('DEBUG', *messages)
      end

      #
      # INFOレベルの標準出力を行う
      #
      # @param [String] messages メッセージ
      #
      def info(*messages)
        return if LEVEL < LEVELS[:info]

        output('INFO', *messages)
      end

      #
      # ERRORレベルの標準出力を行う
      #
      # @param [Error] error 例外
      # @param [String] messages メッセージ
      #
      def error(error, *messages)
        return if LEVEL < LEVELS[:error]

        output('ERROR', *messages)
        output('ERROR', error.message)
        output('ERROR', *error.backtrace)
      end

      private

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
