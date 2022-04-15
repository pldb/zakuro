# frozen_string_literal: true

# :nodoc:
module Zakuro
  # :nodoc:
  module Exception
    # :nodoc:
    module Case
      #
      # Template テンプレート
      #
      class Template
        # @return [String] エラーコード
        attr_reader :code
        # @return [String] メッセージ
        attr_reader :message
        # @return [Integer] テンプレート引数長
        attr_reader :length

        #
        # 初期化
        #
        # @param [String] code エラーコード
        # @param [String] message メッセージ
        # @param [Integer] length テンプレート引数長
        #
        def initialize(code:, message:, length: 0)
          @code = code
          @message = message
          @length = length
        end

        #
        # メッセージを作成する
        #
        # @param [Array<Object>] args テンプレート引数長
        #
        # @return [String] メッセージ
        #
        def format(*args)
          return '' unless args.size == length

          super(template, *args)
        end
      end
    end
  end
end
