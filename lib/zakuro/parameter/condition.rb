# frozen_string_literal: true

require_relative '../exception/exception'

require_relative './catalog/basis_date'
require_relative './catalog/column'
require_relative './catalog/option'
require_relative './catalog/range'

# :nodoc:
module Zakuro
  # :nodoc:
  module Parameter
    #
    # Condition 条件
    #
    class Condition
      # @return [Date] 基準日
      attr_reader :date
      # @return [Hash<Symbol, Date>] 範囲
      attr_reader :range
      # @return [Array<String>] 列
      attr_reader :columns
      # @return [Hash<String, Object>] オプション
      attr_reader :options

      #
      # 初期化
      #
      # @param [Hash<Symbol, Object>] hash パラメータ
      # @option hash [Date] :date 基準日
      # @option hash [Hash<Symbol, Date>] :range 範囲
      # @option hash [Array<String>] :columns 列
      # @option hash [Hash<String, Object>] :options オプション
      #
      def initialize(hash: {})
        @date = hash[:date]
        @range = hash[:range]
        @columns = hash[:columns]
        @options = hash[:options] || {}
      end

      #
      # 上書きする
      #
      # @param [Hash<Symbol, Object>] hash パラメータ
      #
      def rewrite(hash: {})
        instance_variables.each do |var|
          key = var.to_s.delete('@')
          val = hash[key.intern]

          next unless val

          instance_variable_set(var, val)
        end
      end

      # :reek:TooManyStatements { max_statements: 8 }

      class << self
        #
        # 検証する
        #
        # @param [Hash<Symbol, Object>] hash パラメータ
        #
        # @return [Array<Exception::Case::Preset>] エラープリセット配列
        #
        def validate(hash:)
          failed = []

          unless hash.is_a?(Hash)
            failed.push(
              Exception::Case::Preset.new(
                hash.class,
                template: Exception::Case::Pattern::INVALID_CONDITION_TYPE
              )
            )
            return failed
          end

          failed.concat(validate_hash(hash: hash))

          failed
        end

        private

        #
        # ハッシュ内を検証する
        #
        # @param [Hash<Symbol, Object>] hash パラメータ
        #
        # @return [Array<Exception::Case::Preset>] エラープリセット配列
        #
        def validate_hash(hash:)
          failed = []
          failed.concat(Catalog::BasisDate.validate(date: hash[:date]))
          failed.concat(Catalog::Range.validate(hash: hash[:range]))
          failed.concat(Catalog::Column.validate(columns: hash[:columns]))
          failed.concat(Catalog::Option.validate(options: hash[:options]))

          failed
        end
      end
    end
  end
end
