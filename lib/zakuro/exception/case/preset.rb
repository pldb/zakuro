# frozen_string_literal: true

require_relative './template'

# :nodoc:
module Zakuro
  # :nodoc:
  module Exception
    # :nodoc:
    module Case
      #
      # Preset プリセット
      #
      class Preset
        # @return [Template] テンプレート
        attr_reader :template
        # @return [Array<Object>] メッセージ引数
        attr_reader :args

        #
        # 初期化
        #
        # @param [String] args メッセージ引数
        # @param [String] template テンプレート
        #
        def initialize(*args, template:)
          @template = template
          @args = args
        end

        #
        # エラーコードを取得する
        #
        # @return [String] エラーコード
        #
        def code
          template.code
        end

        #
        # メッセージを作成する
        #
        # @return [String] メッセージ
        #
        def message
          template.format(*args)
        end
      end
    end
  end
end
