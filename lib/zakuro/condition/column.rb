# frozen_string_literal: true

require_relative '../exception/exception'

# :nodoc:
module Zakuro
  # :nodoc:
  module Condition
    #
    # Column 特定の列（フィールド）
    # @note 指定された列のみ出力する
    #
    class Column
      # @return [Array<String>] 列
      attr_reader :columns

      #
      # 初期化
      #
      # @param [Array<String>] columns 列
      #
      def initialize(columns: [])
        @columns = columns
      end

      class << self
        #
        # 検証する
        #
        # @param [Array<String>] columns 列
        #
        # @return [Array<Exception::Case::Preset>] エラープリセット配列
        #
        def validate(columns:)
          # TODO: 列内容のバリデーション
          failed = []

          return failed unless columns

          return failed if columns.is_a?(Array)

          failed.push(
            Exception::Case::Preset.new(
              hash.class,
              template: Exception::Case::Pattern::INVALID_COLUMN_TYPE
            )
          )

          failed
        end
      end
    end
  end
end
