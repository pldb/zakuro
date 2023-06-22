# frozen_string_literal: true

require 'json'

require_relative '../tool/stringifier'

# :nodoc:
module Zakuro
  #
  # Result 演算結果
  #
  module Result
    #
    # Core 共通処理
    #
    class Core
      #
      # 初期化
      #
      def initialize(*_args); end

      #
      # ハッシュ化する
      #
      # @return [Hash<String, Object>] ハッシュ
      #
      def to_h
        Tool::Stringifier.to_h(obj: self, class_prefix: 'Zakuro::Result')
      end

      #
      # JSON化する
      #
      # @param [JSON::State] _args 引数（ Struct#to_json ）
      #
      # @return [String] JSON文字列
      #
      def to_json(*_args)
        JSON.generate(to_h)
      end

      #
      # JSON（整形）化する
      #
      # @return [String] JSON（整形）文字列
      #
      def to_pretty_json
        JSON.pretty_generate(to_h)
      end
    end
  end
end
