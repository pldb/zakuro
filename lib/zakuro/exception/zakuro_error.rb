# frozen_string_literal: true

require_relative './cause'

# :nodoc:
module Zakuro
  # :nodoc:
  module Exception
    #
    # ZakuroError ライブラリ内エラー
    #
    class ZakuroError < StandardError
      # @return [Array<ErrorMessage>] エラーメッセージ
      attr_reader :causes

      #
      # 初期化
      #
      # @param [String] msg メッセージ
      # @param [Array<Cause>] causes 原因
      #
      def initialize(msg: '', causes: [])
        super(msg)
        @causes = causes
      end
    end
  end
end
