# frozen_string_literal: true

# :nodoc:
module Zakuro
  # :nodoc:
  module All
    # :nodoc:
    module Motsumetsu
      #
      # Gengou 元号
      #
      class Gengou
        # @return [String] 元号名
        attr_reader :name
        # @return [Integer] 年
        attr_reader :year
        # @return [Integer] 西暦年
        attr_reader :western_year

        #
        # 初期化
        #
        # @param [String] name 元号名
        # @param [Integer] year 年
        # @param [Integer] western_year 西暦年
        #
        def initialize(name: '', year: -1, western_year: -1)
          @name = name
          @year = year
          @western_year = western_year
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
      end
    end
  end
end
