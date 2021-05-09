# frozen_string_literal: true

require_relative '../../const/const'
require_relative './localization'

# :nodoc:
module Zakuro
  # :nodoc:
  module Senmyou
    # :nodoc:
    module Solar
      #
      # Location 入定気
      #
      class Location
        # @return [True] 計算済み（前回計算あり）
        # @return [False] 未計算（初回計算）
        attr_reader :calculated
        # @return [Integer] 連番
        attr_reader :index
        # @return [Cycle::Remainder] 大余小余
        attr_reader :remainder

        #
        # 初期化
        #
        # @param [Integer] index 連番
        # @param [Cycle::Remainder] remainder 大余小余
        #
        def initialize(index: -1, remainder: Cycle::Remainder.new)
          @calculated = false
          @index = index
          @remainder = remainder
        end

        # TODO: localization に組み込む
      end
    end
  end
end
