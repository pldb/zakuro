# frozen_string_literal: true

require_relative '../../exception/exception'

# :nodoc:
module Zakuro
  # :nodoc:
  module Parameter
    # :nodoc:
    module Catalog
      #
      # Option オプション
      # 取得内容を変更する
      #
      #   * version: 暦
      #   * dropped_days: 没日あり
      #   * seasons: 四季あり
      #
      class Option
        # @return [Array<String>] オプション
        attr_reader :options

        #
        # 初期化
        #
        # @param [Hash<Symbol, Object>] options オプション
        #
        def initialize(options: [])
          @options = options
        end

        # TODO: オプションキーのバリデーション

        class << self
          #
          # 検証する
          #
          # @param [Hash<Symbol, Object>] options オプション
          #
          # @return [Array<Exception::Case::Preset>] エラープリセット配列
          #
          def validate(options:)
            failed = []
            return failed unless options

            return failed if options.is_a?(Hash)

            failed.push(
              Exception::Case::Preset.new(
                hash.class,
                template: Exception::Case::Pattern::INVALID_OPTION_TYPE
              )
            )
            failed
          end
        end
      end
    end
  end
end
