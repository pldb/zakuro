# frozen_string_literal: true

require 'json'

require_relative './core'
require_relative './data'
require_relative './operation'
require_relative '../output/stringifier'

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
        Stringifier.to_h(obj: self, class_prefix: 'Zakuro::Result')
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

    #
    # Single 1日検索結果
    #
    class Single < Core
      # @return [Data::SingleDay] 1日
      attr_reader :data
      # @return [Operation::Bundle] 運用情報
      attr_reader :operation

      #
      # 初期化
      #
      # @param [Data::SingleDay] data 1日
      # @param [Operation::Bundle] operation 運用情報
      #
      def initialize(data:, operation:)
        super
        @data = data
        @operation = operation
      end
    end
  end
end
