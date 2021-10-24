# frozen_string_literal: true

require_relative '../output/logger'

# :nodoc:
module Zakuro
  #
  # Tools 汎用メソッド群
  #
  module Tools
    # :reek:UncommunicativeVariableName {accept: e}

    #
    # Typeconv 型変換
    #
    module Typeconv
      LOGGER = Output::Logger.new(location: 'Typeconv')

      #
      # 文字列を数値化する
      #
      # @param [String] text 対象文字列
      # @param [Integer] default デフォルト数値
      #
      # @return [Integer] 数値
      #
      def self.to_i(text:, default:)
        begin
          return Integer(text)
        rescue StandardError => e
          LOGGER.debug(e)
        end

        default
      end
    end
  end
end
