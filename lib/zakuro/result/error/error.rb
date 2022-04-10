# frozen_string_literal: true

require_relative './error_message'

# :nodoc:
module Zakuro
  #
  # Result 演算結果
  #
  module Result
    #
    # エラー
    #
    class Error
      # @return [Array<ErrorMessage>] エラーメッセージ
      attr_reader :errors

      #
      # 初期化
      #
      # @param [Array<ErrorMessage>] errors エラーメッセージ
      #
      def initialize(errors: [])
        @errors = errors
      end
    end
  end
end
