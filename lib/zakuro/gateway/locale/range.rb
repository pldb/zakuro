# frozen_string_literal: true

require_relative './date'

# :nodoc:
module Zakuro
  # :nodoc:
  module Gateway
    # :nodoc:
    class Locale
      #
      # Range 範囲
      #
      class Range
        # @return [LocaleDate] 開始日
        attr_reader :start_date
        # @return [LocaleDate] 終了日
        attr_reader :last_date

        #
        # 初期化
        #
        # @param [Hash<Symbol, Object>] range 範囲
        #
        def initialize(range:)
          @start_date = Date.new(date: range[:start])
          @last_date = Date.new(date: range[:last])
        end

        #
        # 西暦日は有効か
        #
        # @return [True] 有効
        # @return [False] 無効
        #
        def valid_western?
          @start_date.valid_western? && @last_date.valid_western?
        end

        #
        # 和暦日は有効か
        #
        # @return [True] 有効
        # @return [False] 無効
        #
        def valid_japan?
          @start_date.valid_japan? && @last_date.valid_japan?
        end

        #
        # 不正か
        #
        # @return [True] 不正
        # @return [False] 不正なし
        #
        def invalid?
          @start_date.invalid? && @last_date.invalid?
        end
      end
    end
  end
end
