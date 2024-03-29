# frozen_string_literal: true

require_relative '../output/logger'

require_relative './case/preset'
require_relative './case/pattern'

require_relative './zakuro_error'
require_relative './cause'

# :nodoc:
module Zakuro
  # :nodoc:
  module Exception
    # @return [Output::Logger] ロガー
    LOGGER = Output::Logger.new(location: 'exception')

    # @return [String] 共通メッセージ
    MESSAGE = 'an error has occurred'

    class << self
      #
      # 例外を取得する
      #
      # @param [Array<Case::Preset>] presets 原因プリセット
      #
      # @return [ZakuroError] ライブラリエラー
      #
      def get(presets: [])
        causes = []
        presets.each do |preset|
          causes.push(Cause.new(code: preset.code, message: preset.message))
        end

        ZakuroError.new(msg: MESSAGE, causes: causes)
      end
    end
  end
end
