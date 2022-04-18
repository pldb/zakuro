# frozen_string_literal: true

# :nodoc:
module Zakuro
  # :nodoc:
  module Exception
    #
    # Cause 原因
    #
    class Cause
      # @return [String] エラーコード
      attr_reader :code
      # @return [String] メッセージ
      attr_reader :message

      #
      # 初期化
      #
      # @param [String] code エラーコード
      # @param [String] message メッセージ
      #
      def initialize(code:, message:)
        @code = code
        @message = message
      end
    end
  end
end
