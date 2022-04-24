# frozen_string_literal: true

require_relative './template'

# :nodoc:
module Zakuro
  # :nodoc:
  module Exception
    # :nodoc:
    module Case
      #
      # Pattern 原因パターン
      #
      module Pattern
        INTERNAL_ERROR = Template.new(
          code: 'ERROR_0001',
          message: '内部エラーです。',
          length: 0
        )

        INVALID_DATE_TYPE = Template.new(
          code: 'ERROR_0101',
          message: '日付の型は文字列/日付です。指定型:%s',
          length: 1
        )

        INVALID_RANGE_TYPE = Template.new(
          code: 'ERROR_0102',
          message: '範囲の型はhashです。指定型:%s',
          length: 1
        )

        INVALID_OPTION_TYPE = Template.new(
          code: 'ERROR_0103',
          message: 'オプションの型はhashです。指定型:%s',
          length: 1
        )

        INVALID_COLUMN_TYPE = Template.new(
          code: 'ERROR_0104',
          message: '列の型は配列です。指定型:%s',
          length: 1
        )

        INVALID_CONDITION_TYPE = Template.new(
          code: 'ERROR_0105',
          message: '条件の型は配列です。指定型:%s',
          length: 1
        )

        INVALID_DATE = Template.new(
          code: 'ERROR_0201',
          message: '一日検索の日付指定が誤っています。',
          length: 0
        )

        INVALID_RANGE = Template.new(
          code: 'ERROR_0202',
          message: '範囲検索の日付指定が誤っています。',
          length: 0
        )

        UNCOMMITTABLE_DATE = Template.new(
          code: 'ERROR_0203',
          message: '検索不可能な日付指定です。',
          length: 0
        )
      end
    end
  end
end
