# frozen_string_literal: true

require_relative '../output/logger'

require_relative './cause'

require_relative './const'

require_relative './zakuro_error'

# :nodoc:
module Zakuro
  # :nodoc:
  module Exception
    # @return [Output::Logger] ロガー
    LOGGER = Output::Logger.new(location: 'exception')

    # @return [String] 共通メッセージ
    MESSAGE = 'an error has occurred'

    #
    # 例外を取得する
    #
    # @param [Array<Symbol>] codes エラーコード
    #
    # @return [ZakuroError] ライブラリエラー
    #
    def self.get(codes: [])
      causes = []
      begin
        codes.each do |code|
          message = Const.const_get(code)
          causes.push(Cause.new(code: code.to_s, message: message))
        end
      rescue StandardError => e
        LOGGER.error(e, MESSAGE)
        message = Const.const_get(:ERROR_NOCODE)
        causes.push(Cause.new(code: :ERROR_NOCODE.to_s, message: message))
      end

      ZakuroError.new(msg: MESSAGE, causes: causes)
    end
  end
end
