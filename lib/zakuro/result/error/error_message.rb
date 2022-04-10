# frozen_string_literal: true

# :nodoc:
module Zakuro
  #
  # Result 演算結果
  #
  module Result
    #
    # エラーメッセージ
    #
    class ErrorMessage
      # @return [String] エラーコード
      attr_reader :code
      # @return [String] メッセージ
      attr_reader :message

      #
      # 初期化
      #
      # @param [String] code エラーコード
      # @param [String] name メッセージ
      #
      def initialize(code:, name:)
        @code = code
        @name = name
      end
    end
  end
end
