# frozen_string_literal: true

# :nodoc:
module Zakuro
  #
  # 軽量なロガー
  # @note 本番では使用しない
  #
  class Logger
    LEVELS = {
      none: -1,
      debug: 0,
      info: 1
      # warn : 2,
      # error : 3,
    }.freeze

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
