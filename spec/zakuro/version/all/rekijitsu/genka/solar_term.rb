# frozen_string_literal: true

# :nodoc:
module Zakuro
  # :nodoc:
  module All
    # :nodoc:
    module Rekijitsu
      # :nodoc:
      module Genka
        # SolarTerm 二十四節気
        class SolarTerm
          # @return [Regexp] 正規表現
          REGEX = /\(([0-9]{1,2})\)([0-9]{1,2}\.[0-9]{1,4})/.freeze

          # @return [Integer] 連番
          attr_reader :index
          # @return [String] 大余小余
          attr_reader :remainder

          #
          # 初期化
          #
          # @param [String] text 文字列
          #
          def initialize(text: '')
            @index = -1
            @remainder = ''

            return unless text

            parse(text)
          end

          #
          # 不正か
          #
          # @return [True] 不正
          # @return [False] 不正なし
          #
          def invalid?
            @index == -1
          end

          private

          #
          # 変換する
          #
          # @param [String] text 文字列
          #
          def parse(text)
            matched = text.match(REGEX)
            return unless matched

            @index = matched[1].to_i
            @remainder = matched[2]
          end
        end
      end
    end
  end
end
