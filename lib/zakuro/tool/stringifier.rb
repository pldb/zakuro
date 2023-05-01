# frozen_string_literal: true

require_relative './typeof'

# :nodoc:
module Zakuro
  #
  # Tool 汎用メソッド群
  #
  module Tool
    #
    # Stringifier 文字列処理
    #
    module Stringifier
      class << self
        #
        # 対象インスタンスをハッシュ化する
        #
        # @param [Object] obj 対象インスタンス
        # @param [String] class_prefix インスタンス内でハッシュ変換するクラスのプレフィックス
        # @param [True, False] formatted 整形有無
        #
        # @return [Hash<String, Objcet>] ハッシュ
        #
        def to_h(obj:, class_prefix:, formatted: true)
          hash = {}
          obj.instance_variables.each do |var|
            key = var.to_s.delete('@')
            hash[key] = value_to_hash(
              obj: obj.instance_variable_get(var), class_prefix: class_prefix, formatted: formatted
            )
          end
          hash
        end

        private

        #
        # 対象インスタンスをハッシュ化する（再帰処理）
        #
        # @param [Object] obj 対象インスタンス
        # @param [String] class_prefix インスタンス内でハッシュ変換するクラスのプレフィックス
        # @param [True, False] formatted 整形有無
        #
        # @return [Hash<String, Objcet>] ハッシュ
        #
        def value_to_hash(obj:, class_prefix:, formatted:)
          return obj unless obj

          # 日付をフォーマットする
          return obj.format if formatted && Tool::Typeof.time?(obj: obj)

          # 同じモジュール内のオブジェクトは再帰する
          if obj.class.name.start_with?(class_prefix)
            return to_h(obj: obj, class_prefix: class_prefix, formatted: formatted)
          end

          general_value_to_hash(obj: obj, class_prefix: class_prefix, formatted: formatted)
        end

        #
        # ライブラリを問わない標準的な値をハッシュ化する（再帰処理）
        #
        # @param [Object] obj 対象インスタンス
        # @param [String] class_prefix インスタンス内でハッシュ変換するクラスのプレフィックス
        # @param [True, False] formatted 整形有無
        #
        # @return [Objcet] ハッシュ変換可能な値
        #
        def general_value_to_hash(obj:, class_prefix:, formatted:)
          # 配列は要素一つずつで再帰する
          if obj.is_a?(Array)
            arr = []
            obj.each do |item|
              arr.push(to_h(obj: item, class_prefix: class_prefix, formatted: formatted))
            end
            return arr
          end

          # ハッシュはキーごとに再帰する
          if obj.is_a?(Hash)
            hash = {}
            obj.each do |key, value|
              hash[key] = to_h(obj: value, class_prefix: class_prefix, formatted: formatted)
            end
            return hash
          end

          obj
        end
      end
    end
  end
end
