# frozen_string_literal: true

# :nodoc:
module Zakuro
  # :nodoc:
  module All
    # :nodoc:
    module Gihou
      # Gengou 元号
      class Gengou
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
