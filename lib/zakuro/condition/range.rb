# frozen_string_literal: true

require_relative '../exception/exception'

require_relative './basis_date'

# :nodoc:
module Zakuro
  # :nodoc:
  module Condition
    #
    # Range 範囲（開始日-終了日）
    #
    class Range
      # @return [Date] 開始日
      attr_reader :start
      # @return [Date] 終了日
      attr_reader :last

      #
      # 初期化
      #
      # @param [Hash<Symbol, Object>] hash パラメータ
      # @option hash [Symbol] :start 開始日
      # @option hash [Symbol] :start 終了日
      #
      def initialize(hash: {})
        @start = hash[:start]
        @last = hash[:last]
      end

      # :reek:TooManyStatements { max_statements: 7 }

      class << self
        #
        # 検証する
        #
        # @param [Hash<Symbol, Object>] hash パラメータ
        #
        # @return [Array<Exception::Case::Preset>] エラープリセット
        #
        def validate(hash:)
          failed = []
          return failed unless hash

          unless hash.is_a?(Hash)
            failed.push(
              Exception::Case::Preset.new(
                hash.class,
                template: Exception::Case::Pattern::INVALID_RANGE_TYPE
              )
            )
            return failed
          end

          failed.concat(BasisDate.validate(date: hash[:start]))
          failed.concat(BasisDate.validate(date: hash[:last]))

          failed
        end
      end

      #
      # 不正か
      #
      # @return [True] 不正
      # @return [False] 不正なし
      #
      def invalid?
        return true unless @start

        return true unless @end

        false
      end
    end
  end
end
