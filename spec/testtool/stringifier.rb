# frozen_string_literal: true

require 'json'
require File.expand_path('../../lib/zakuro/tool/stringifier', __dir__)
require File.expand_path('./expection', __dir__)

# :nodoc:
module Zakuro
  #
  # TestTool テスト用メソッド群
  #
  module TestTool
    EXPECTION = Expection.new
    #
    # Stringifier 文字列
    #
    module Stringifier
      class << self
        #
        # オブジェクトを文字列にして比較する
        #
        # @param [Object] expected 期待値
        # @param [Object] actual 実際値
        # @param [String] class_prefix クラス名文字列（前方マッチング）
        # @param [True] formatted 日付を文字列にする
        # @param [False] formatted 日付を文字列にしない
        #
        def eql?(expected:, actual:, class_prefix: '', formatted: true)
          expected_json = generate_pretty_json(
            obj: expected, class_prefix: class_prefix, formatted: formatted
          )
          actual_json = generate_pretty_json(
            obj: actual, class_prefix: class_prefix, formatted: formatted
          )

          EXPECTION.eql?(actual: actual_json, expect: expected_json)
        end

        #
        # JSON文字列を生成する
        #
        # @param [Object] obj オブジェクト
        # @param [<Type>] class_prefix <description>
        # @param [String] class_prefix クラス名文字列（前方マッチング）
        # @param [True] formatted 日付を文字列にする
        # @param [False] formatted 日付を文字列にしない
        #
        # @return [String] JSON文字列
        #
        def generate_pretty_json(obj:, class_prefix:, formatted:)
          hash = Zakuro::Tool::Stringifier.to_h(
            obj: obj, class_prefix: class_prefix, formatted: formatted
          )
          JSON.pretty_generate(hash)
        end
      end
    end
  end
end
