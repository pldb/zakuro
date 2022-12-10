# frozen_string_literal: true

# :nodoc:
module Zakuro
  # :nodoc:
  module All
    # :nodoc:
    module Rekijitsu
      # MedievalGengou 元号（中世）
      class MedievalGengou
        # @return [Regexp] 正規表現
        REGEX = /^\s*([一-龥]{1,4})\s+([0-9]{1,2})年/.freeze

        # @return [String] 元号名
        attr_reader :name
        # @return [Integer] 元号年
        attr_reader :year

        #
        # 初期化
        #
        # @param [String] text 文字列
        #
        def initialize(text: '')
          @name = ''
          @year = -1

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
          @year == -1
        end

        #
        # 比較する（==）
        #
        # @param [MedievalGengou] other 元号（中世）
        #
        # @return [True] 等しい
        # @return [False] 等しくない
        #
        def ==(other)
          return false unless name == other.name

          return false unless year == other.year

          true
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

          @name = matched[1]
          @year = matched[2].to_i
        end
      end
    end
  end
end
