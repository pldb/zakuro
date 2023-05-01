# frozen_string_literal: true

require_relative '../output/logger'

# :nodoc:
module Zakuro
  #
  # Tool 汎用メソッド群
  #
  module Tool
    # :reek:UncommunicativeVariableName {accept: e}

    #
    # Typeconv 型変換
    #
    module Typeconv
      LOGGER = Output::Logger.new(location: 'Typeconv')

      class << self
        #
        # 文字列を10進数で数値化する
        #
        # @param [String] text 対象文字列
        # @param [Integer] default デフォルト数値
        #
        # @return [Integer] 数値
        #
        def to_i(text:, default:)
          begin
            return Integer(text, 10)
          rescue StandardError => e
            LOGGER.debug(e)
          end

          default
        end
      end
    end
  end
end
