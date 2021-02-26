# frozen_string_literal: true

require_relative './typeof'

# :nodoc:
module Zakuro
  #
  # Tools 汎用メソッド群
  #
  module Tools
    #
    # Stringifier 文字列処理
    #
    module Stringifier
      #
      # 対象インスタンスをハッシュ化する
      #
      # @param [Object] obj 対象インスタンス
      # @param [String] class_prefix インスタンス内でハッシュ変換するクラスのプレフィックス
      #
      # @return [Hash<String, Objcet>] ハッシュ
      #
      def self.to_h(obj:, class_prefix:, formatted: true)
        hash = {}
        obj.instance_variables.each do |var|
          key = var.to_s.delete('@')
          hash[key] = value_to_hash(
            obj: obj.instance_variable_get(var), class_prefix: class_prefix, formatted: formatted
          )
        end
        hash
      end

      # :reek:TooManyStatements { max_statements: 7 } and :reek:NilCheck

      #
      # 対象インスタンスをハッシュ化する（再帰処理）
      #
      # @param [Object] obj 対象インスタンス
      # @param [String] class_prefix インスタンス内でハッシュ変換するクラスのプレフィックス
      #
      # @return [Hash<String, Objcet>] ハッシュ
      #
      def self.value_to_hash(obj:, class_prefix:, formatted:)
        return obj if obj.nil?

        # 日付をフォーマットする
        return obj.format if formatted && Tools::Typeof.time?(obj: obj)

        # 同じモジュール内のオブジェクトは再帰する
        if obj.class.name.start_with?(class_prefix)
          return to_h(obj: obj, class_prefix: class_prefix, formatted: formatted)
        end

        # 配列は要素一つずつで再帰する
        if obj.is_a?(Array)
          arr = []
          obj.each do |item|
            arr.push(to_h(obj: item, class_prefix: class_prefix, formatted: formatted))
          end
          return arr
        end

        obj
      end
      private_class_method :value_to_hash
    end
  end
end
